package game.char;

import flixel.math.FlxVelocity;
import flixel.math.FlxVector;

class Turret extends Actor {
	public var atkSpd:Float;
	public var range:Float;
	public var fireCD:Float;
	public var cost:Int;
	public var ai:State;
	public var enemyGrp:FlxTypedGroup<Enemy>;
	public var playerBullets:FlxTypedGroup<Bullet>;

	public static inline var PROJECTILE_SPEED:Float = 600;

	public function new(x:Float, y:Float, turretData:TurretData,
			bulletGrp:FlxTypedGroup<Bullet>) {
		super(x, y, turretData);
		fireCD = 0;
		ai = new State(idle);
		playerBullets = bulletGrp;
	}

	public function setEnemyGrp(grp:FlxTypedGroup<Enemy>) {
		enemyGrp = grp;
	}

	override public function assignStats() {
		super.assignStats();
		var turretData:TurretData = cast data;
		atkSpd = turretData.atkSpd;
		range = turretData.range;
		cost = turretData.cost;
		var sprite = turretData.sprite.replace('../../', 'assets/');
		loadGraphic(sprite, true, 16, 16, true);
		animation.add('idle', [0]);
		animation.add('fire', [0, 1, 2]);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		ai.update(elapsed);
	}

	public function idle(elapsed:Float) {
		var enemy = enemyInRange();
		if (enemy != null) {
			ai.currentState = attackEnemy;
		}
		animation.play('idle');
		handleCD(elapsed);
	}

	public function attackEnemy(elapsed:Float) {
		var enemy = enemyInRange();
		if (enemy != null) {
			fireAtEnemy();
			animation.play('fire');
		} else {
			ai.currentState = idle;
		}
		handleCD(elapsed);
	}

	/**
	 * Fires at the enemy using the acceleration 
	 * in their direction.
	 */
	public function fireAtEnemy() {
		var enemy = enemyInRange();
		if (fireCD >= atkSpd) {
			var bullet = playerBullets.recycle(Bullet);
			bullet.makeGraphic(4, 4, KColor.BEAU_BLUE);
			bullet.setPosition(this.getMidpoint().x, y);
			bullet.velocity.set(0, 0);
			FlxVelocity.accelerateTowardsObject(bullet, enemy,
				PROJECTILE_SPEED, PROJECTILE_SPEED);
			playerBullets.add(bullet);
			fireCD = 0;
		}
	}

	public function enemyInRange():Enemy {
		var enemy = null;
		if (enemyGrp != null) {
			var enemyList = enemyGrp.members.filter((enemy) -> {
				return enemy.getMidpoint()
					.distanceTo(this.getMidpoint()) < range && enemy.alive;
			});
			if (enemyList != null && enemyList.length > 0) {
				enemy = enemyList.shift();
			}
		}
		return enemy;
	}

	public function handleCD(elapsed:Float) {
		if (fireCD >= atkSpd) {
			fireCD = atkSpd;
		}
		fireCD += elapsed;
	}
}
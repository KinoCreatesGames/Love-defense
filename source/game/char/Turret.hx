package game.char;

import flixel.math.FlxVector;

class Turret extends Actor {
	public var atkSpd:Int;
	public var range:Float;
	public var fireCD:Float;
	public var ai:State;
	public var enemyGrp:FlxTypedGroup<Enemy>;
	public var playerBullets:FlxTypedGroup<Bullet>;

	public static inline var PROJECTILE_SPEED:Float = 400;

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
		handleCD(elapsed);
	}

	public function attackEnemy(elapsed:Float) {
		var enemy = enemyInRange();
		if (enemy != null) {
			fireAtEnemy();
		} else {
			ai.currentState = idle;
		}
		handleCD(elapsed);
	}

	/**
	 * Fires at the enemy using the acceleration 
	 * in their direction
	 */
	public function fireAtEnemy() {
		var enemy = enemyInRange();
		if (fireCD >= atkSpd) {
			var fireAngle = this.getMidpoint()
				.angleBetween(enemy.getMidpoint());
			var bullet = playerBullets.recycle(Bullet);
			var fireVec:FlxVector = new FlxPoint(0, 0);
			fireVec.rotateByDegrees(fireAngle);
			fireVec.normalize();
			bullet.acceleration.set(fireVec.x * PROJECTILE_SPEED,
				fireVec.y * PROJECTILE_SPEED);
			fireCD = 0;
		}
	}

	public function enemyInRange():Enemy {
		var enemy = null;
		if (enemyGrp != null) {
			var enemyList = enemyGrp.members.filter((enemy) -> {
				return enemy.getMidpoint()
					.distanceTo(this.getMidpoint()) < range;
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
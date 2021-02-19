package game.char;

import flixel.math.FlxVelocity;

class Enemy extends Actor {
	public var walkPath:Array<FlxPoint>;
	public var points:Int;

	public function new(x:Float, y:Float, path:Array<FlxPoint>,
			monsterData:MonsterData) {
		super(x, y, monsterData);
		walkPath = path;
		points = monsterData.points;
		var sprite = monsterData.sprite.replace('../../', 'assets/');
		loadGraphic(sprite, true, 16, 16, true);
		animation.add('idle', [0]);
		animation.add('walk', [0, 1, 2]);
		animation.play('walk');
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateMovement(elapsed);
	}

	public function updateMovement(elapsed:Float) {
		var midPoint = walkPath[1].copyTo(new FlxPoint(0, 0));
		midPoint.x = midPoint.x - 8;
		midPoint.y = midPoint.y - 8;
		FlxVelocity.moveTowardsPoint(this,
			new FlxPoint(midPoint.x, midPoint.y), spd);
	}
}
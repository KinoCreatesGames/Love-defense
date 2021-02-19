package game.char;

import flixel.math.FlxVector;
import flixel.math.FlxVelocity;

class Speedy extends Enemy {
	public static inline var MOVEMENT_SPEED:Int = 40;

	public function new(x:Float, y:Float, path:Array<FlxPoint>,
			monsterData:MonsterData) {
		super(x, y, path, monsterData);
		loadGraphic(AssetPaths.speedy__png, true, 16, 16);
		animation.add('idle', [0]);
		animation.add('walk', [0, 1, 2]);
		animation.play('walk');
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateMovement(elapsed);
	}
}
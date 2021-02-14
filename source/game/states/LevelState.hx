package game.states;

import flixel.addons.editors.tiled.TiledMap;

class LevelState extends FlxState {
	/**
	 * Amount of time given to setup initial turrets;
	 */
	public var setupTime:Float;

	/**
	 *  Amount of points available for creating a turret 
	 */
	public var turretPoints:Int;

	public var map:TiledMap;

	override public function create() {
		super.create();
		createLevel();
	}

	public function createLevel() {}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}
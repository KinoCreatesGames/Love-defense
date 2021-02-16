package game.char;

class Enemy extends Actor {
	public var walkPath:Array<FlxPoint>;

	public function new(x:Float, y:Float, path:Array<FlxPoint>,
			monsterData:MonsterData) {
		super(x, y, monsterData);
		walkPath = path;
	}
}
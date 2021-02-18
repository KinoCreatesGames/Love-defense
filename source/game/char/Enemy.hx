package game.char;

class Enemy extends Actor {
	public var walkPath:Array<FlxPoint>;
	public var points:Int;

	public function new(x:Float, y:Float, path:Array<FlxPoint>,
			monsterData:MonsterData) {
		super(x, y, monsterData);
		walkPath = path;
		points = monsterData.points;
	}
}
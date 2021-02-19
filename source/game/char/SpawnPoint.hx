package game.char;

class SpawnPoint extends FlxSprite {
	public var monsterPath:Array<FlxPoint>;
	public var enemyGrp:FlxTypedGroup<Enemy>;

	public var spawnTimer:Float;
	public var canSpawn:Bool;

	public static inline var SPAWN_TIME:Float = 2.5;

	public function new(x:Float, y:Float, enemyGrp:FlxTypedGroup<Enemy>,
			path:Array<FlxPoint>) {
		super(x, y);
		spawnTimer = SPAWN_TIME;
		this.enemyGrp = enemyGrp;
		canSpawn = false;
		monsterPath = path;
		this.loadGraphic(AssetPaths.monster_gate__png, false, 16, 16);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		processMonsterSpawn(elapsed);
	}

	public function processMonsterSpawn(elapsed:Float) {
		if (spawnTimer <= 0 && canSpawn) {
			spawnMonster();
			spawnTimer = SPAWN_TIME;
		} else {
			spawnTimer -= elapsed;
			spawnTimer.clampf(0, SPAWN_TIME);
		}
	}

	public function spawnMonster() {
		// Create Basic Grunt
		var spawnPoint = new FlxPoint(x - 16, y);
		var monsterData = DepotData.Enemies.lines.getByFn((line) ->
			line.name == 'Grunt');
		var randomIndex = Math.round((DepotData.Enemies.lines.length
			- 1) * Math.random());
		var monsterData = DepotData.Enemies.lines[randomIndex];
		var enemy = new Enemy(spawnPoint.x, spawnPoint.y, monsterPath,
			monsterData);
		enemyGrp.add(enemy);
	}

	public function startSpawn() {
		canSpawn = true;
	}

	public function stopSpawn() {
		canSpawn = false;
	}
}
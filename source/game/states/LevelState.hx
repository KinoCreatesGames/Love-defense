package game.states;

import flixel.addons.editors.tiled.TiledObject;
import game.ui.PlayerHUD;
import flixel.FlxObject;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledTileSet;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledMap;

class LevelState extends FlxState {
	/**
	 * Amount of time given to setup initial turrets;
	 */
	public var setupTime:Float;

	public var levelTime:Float;

	/**
	 *  Amount of points available for creating a turret 
	 */
	public var turretPoints:Int;

	public var heart:FlxSprite;

	public var completeLevel:Bool;
	public var gameOver:Bool;
	public var levelScore = 0;

	public var map:TiledMap;

	public var hud:PlayerHUD;

	// Groups
	public var playerTurrets:FlxTypedGroup<Turret>;
	public var playerDamageGrp:FlxTypedGroup<FlxSprite>;
	public var turretPositions:FlxTypedGroup<FlxSprite>;
	public var enemySpawnPositions:FlxTypedGroup<SpawnPoint>;
	public var levelGrp:FlxTypedGroup<FlxTilemap>;
	public var decorationGrp:FlxTypedGroup<FlxTilemap>;
	public var enemyGrp:FlxTypedGroup<Enemy>;
	public var playerBullets:FlxTypedGroup<Bullet>;

	public static inline var TILESET_NAME:String = 'Floor_tileset';

	override public function create() {
		super.create();
		completeLevel = false;
		gameOver = false;
		levelScore = 0;
		setSetupTime();
		setLevelTime();
		setTurretPoints();
	}

	/**
	 * By default 60 seconds
	 */
	public function setSetupTime() {
		setupTime = 60.0;
	}

	/**
	 * By default 120 seconds
	 */
	public function setLevelTime() {
		levelTime = 120.0;
	}

	/**
	 * The amount of points you start with at the start of a stage
	 * By default 400 Points.
	 */
	public function setTurretPoints() {
		turretPoints = 400;
	}

	public function createLevel(?levelName:String) {
		final map = new TiledMap(levelName);
		this.map = map;
		final turretPositionLayer:TiledObjectLayer = cast(map.getLayer('TurretPositions'));
		final enemySpawnPositionLayer:TiledObjectLayer = cast(map.getLayer('EnemyPositions'));
		// Position of the heart on screen
		final heartPositionLayer:TiledObjectLayer = cast(map.getLayer('HeartPosition'));
		// Damage Area for the heart in the game
		final damageAreaLayer:TiledObjectLayer = cast(map.getLayer('DamageArea'));
		final tileLayer:TiledTileLayer = cast(map.getLayer('Level'));

		// Create Groups And Level
		playerTurrets = new FlxTypedGroup<Turret>();
		playerBullets = new FlxTypedGroup<Bullet>();
		playerDamageGrp = new FlxTypedGroup<FlxSprite>();
		turretPositions = new FlxTypedGroup<FlxSprite>();
		enemySpawnPositions = new FlxTypedGroup<SpawnPoint>();
		enemyGrp = new FlxTypedGroup<Enemy>();
		levelGrp = new FlxTypedGroup<FlxTilemap>();
		decorationGrp = new FlxTypedGroup<FlxTilemap>();

		// Add Level Information
		createLevelMap(tileLayer);
		createTurretPositions(turretPositionLayer);
		createEnemySpawns(enemySpawnPositionLayer);
		createHeart(heartPositionLayer);
		createDamageArea(damageAreaLayer);
		// Add Groups
		hud = new PlayerHUD(heart);
		add(levelGrp);
		add(decorationGrp);
		add(turretPositions);
		add(enemySpawnPositions);
		add(enemyGrp);
		add(playerDamageGrp);
		add(playerTurrets);
		add(playerBullets);
		add(hud);
	}

	public function createLevelMap(tileLayer:TiledTileLayer) {
		// Gets Tiled Image Data
		var tileset:TiledTileSet = map.getTileSet(TILESET_NAME);
		var tilesetPath = AssetPaths.floor_tileset__png;

		if (tileLayer == null) {
			// get with prefix
			tileLayer = null;
		} else {
			addLevelToGrp(tileLayer, tilesetPath, tileset);
		}
		createDecorationLayers();
	}

	public function addLevelToGrp(tileLayer:TiledTileLayer,
			tilesetPath:String, tileset:TiledTileSet) {
		var level = new FlxTilemap();
		level.loadMapFromArray(tileLayer.tileArray, map.width, map.height,
			tilesetPath, map.tileWidth, map.tileHeight,
			FlxTilemapAutoTiling.OFF, tileset.firstGID, 1);
		levelGrp.add(level);
	}

	public function createDecorationLayers() {
		var tileset:TiledTileSet = map.getTileSet(TILESET_NAME);
		// This works because it has an ID given by Flixel
		var tilesetPath = AssetPaths.floor_tileset__png;
		final tileLayer:TiledTileLayer = cast(map.getLayer('Decoration'));

		if (tileLayer != null) {
			final levelDecoration = new FlxTilemap();
			levelDecoration.loadMapFromArray(tileLayer.tileArray, map.width,
				map.height, tilesetPath, map.tileWidth, map.tileHeight,
				FlxTilemapAutoTiling.OFF, tileset.firstGID, 1, FlxObject.NONE);
			decorationGrp.add(levelDecoration);
		}
		// };
	}

	public function createTurretPositions(layer:TiledObjectLayer) {
		layer.objects.iter((tObj) -> {
			var sprite = new FlxSprite(tObj.x, tObj.y);
			sprite.makeGraphic(16, 16, 0x55FFFFFF);
			turretPositions.add(sprite);
		});
	}

	public function createEnemySpawns(layer:TiledObjectLayer) {
		layer.objects.iter((tObj) -> {
			var pathPrefix = 'Path_';
			var pathPoints = [];
			// Path Keys

			for (key in tObj.properties.keysIterator()) {
				if (key.contains(pathPrefix)) {
					var point = tObj.properties.get(key)
						.split(",")
						.map(Std.parseFloat)
						.map(f -> (f + 1) * map.tileWidth);
					pathPoints.push(new FlxPoint(point[0], point[1]));
				}
			}

			var sprite = new SpawnPoint(tObj.x, tObj.y, enemyGrp, pathPoints);

			enemySpawnPositions.add(sprite);
		});
	}

	public function createDamageArea(layer:TiledObjectLayer) {
		layer.objects.iter((tObj) -> {
			var sprite = new FlxSprite(tObj.x, tObj.y);
			sprite.makeGraphic(16, 16, KColor.TRANSPARENT);
			playerDamageGrp.add(sprite);
		});
	}

	public function createHeart(layer:TiledObjectLayer) {
		layer.objects.iter((tObj) -> {
			heart = new FlxSprite(tObj.x, tObj.y);
			heart.makeGraphic(16, 16, KColor.RED);
			// Set Health to 100
			heart.health = 100;
			playerDamageGrp.add(heart);
		});
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		processPause();
		processCollisions();
		processLevel(elapsed);
	}

	public function processPause() {
		if (FlxG.keys.anyJustPressed([ESCAPE])) {
			trace('Pause Game');
			openSubState(new PauseSubState());
		}
	}

	public function processCollisions() {
		FlxG.overlap(enemyGrp, playerDamageGrp, enemyTouchDamageArea);
		FlxG.overlap(playerBullets, enemyGrp, playerBulletTouchEnemy);
	}

	public function enemyTouchDamageArea(enemy:Enemy, damageArea:FlxSprite) {
		trace('Touch Heart');
		heart.health -= enemy.atk;
		enemy.kill();
		trace(heart.health);
		trace(enemy.atk);
		if (heart.health <= 0) {
			heart.kill();
		}
	}

	public function playerBulletTouchEnemy(bullet:Bullet, enemy:Enemy) {
		enemy.health -= bullet.atk;
		if (enemy.health <= 0) {
			enemy.kill();
			levelScore += 100;
		}

		// Update Score
		hud.setScore(levelScore);
	}

	public function processLevel(elapsed:Float) {
		if (setupTime >= 0) {
			setupTime -= elapsed;
			hud.setTimer(setupTime);
		} else if (setupTime <= 0) {
			// Start Level Time & Spawners
			startSpawners();
			if (levelTime <= 0 && heart.alive) {
				// complete level
				completeLevel = true;
				stopSpawners();
			} else {
				levelTime -= elapsed;
			}
			hud.setTimer(levelTime);
		}

		if (!heart.alive) {
			gameOver = true;
		}
	}

	public function startSpawners() {
		enemySpawnPositions.members.iter((spawner) -> {
			spawner.startSpawn();
		});
	}

	public function stopSpawners() {
		enemySpawnPositions.members.iter((spawner) -> {
			spawner.stopSpawn();
		});
	}
}
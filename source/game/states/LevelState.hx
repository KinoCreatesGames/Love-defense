package game.states;

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
	public var turretPositions:FlxTypedGroup<FlxSprite>;
	public var enemySpawnPositions:FlxTypedGroup<FlxSprite>;
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

	public function createLevel(?levelName:String) {
		final map = new TiledMap(levelName);
		this.map = map;
		final turretPositionLayer:TiledObjectLayer = cast(map.getLayer('TurretPositions'));
		final enemySpawnPositionLayer:TiledObjectLayer = cast(map.getLayer('EnemyPositions'));
		final tileLayer:TiledTileLayer = cast(map.getLayer('Level'));

		// Create Groups And Level
		playerTurrets = new FlxTypedGroup<Turret>();
		playerBullets = new FlxTypedGroup<Bullet>();
		turretPositions = new FlxTypedGroup<FlxSprite>();
		enemySpawnPositions = new FlxTypedGroup<FlxSprite>();
		enemyGrp = new FlxTypedGroup<Enemy>();
		levelGrp = new FlxTypedGroup<FlxTilemap>();

		// Add Level
		createLevelMap(tileLayer);
		createHeart();
		// Add Groups
		hud = new PlayerHUD(heart);
		add(levelGrp);
		add(turretPositions);
		add(enemySpawnPositions);
		add(enemyGrp);
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
		var decorLayerPrefix = 'Decor_';
		trace(map.layers.length);
		for (i in 0...map.layers.length) {
			var tileLayer:TiledTileLayer = cast(map.getLayer(decorLayerPrefix
				+ i));

			if (tileLayer != null) {
				final levelDecoration = new FlxTilemap();
				levelDecoration.loadMapFromArray(tileLayer.tileArray,
					map.width, map.height, tilesetPath, map.tileWidth,
					map.tileHeight, FlxTilemapAutoTiling.OFF,
					tileset.firstGID, 1, FlxObject.NONE);
				decorationGrp.add(levelDecoration);
			}
		};
	}

	public function createLevelLayers() {}

	public function createTurretPositions() {}

	public function createHeart() {
		heart = new FlxSprite(0, 0);
		heart.makeGraphic(16, 16, KColor.RED);
		add(heart);
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
		FlxG.overlap(enemyGrp, heart, enemyTouchHeart);
	}

	public function enemyTouchHeart(enemy:Enemy, heart:FlxSprite) {
		heart.health -= enemy.atk;
		enemy.kill();
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
			// Start Level Time
			if (levelTime <= 0 && heart.alive) {
				// complete level
				completeLevel = true;
			} else {
				levelTime -= elapsed;
			}
			hud.setTimer(levelTime);
		}

		if (!heart.alive) {
			gameOver = true;
		}
	}
}
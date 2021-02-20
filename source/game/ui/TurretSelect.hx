package game.ui;

class TurretSelect extends FlxTypedGroup<FlxSprite> {
	public var position:FlxPoint;
	public var background:FlxSprite;
	public var selectionRect:FlxSprite;
	public var rangeCircle:FlxSprite;
	public var statText:FlxText;
	public var borderSize:Float;
	public var turretSprites:Array<FlxSprite>;
	public var turretInfo:Array<TurretData>;
	public var playerTurrets:FlxTypedGroup<Turret>;
	public var currentTurretPosition:FlxSprite;
	public var clickTurret:(TurretSelect, TurretData) -> Void;

	public var selectSound:FlxSound;

	public static inline var WIDTH:Int = 400;
	public static inline var HEIGHT:Int = 60;
	public static inline var BGCOLOR:Int = KColor.RICH_BLACK;

	public function new(x:Float, y:Float,
			playerTurrets:FlxTypedGroup<Turret>) {
		super();
		position = new FlxPoint(x, y);
		borderSize = 4;
		turretSprites = [];
		turretInfo = [];
		this.playerTurrets = playerTurrets;

		selectSound = FlxG.sound.load(AssetPaths.mouse_over__wav);
		create();
	}

	public function create() {
		createRangeCircle(position);
		createBackground(position);
		createStatText(position);
		createTurrets(position);
		createSelectionRect(position);
	}

	public function createBackground(positioin:FlxPoint) {
		background = new FlxSprite(position.x, position.y);
		// Have to use make graphic first in order to actually draw Rects
		background.makeGraphic(WIDTH, HEIGHT, BGCOLOR);

		background.drawRect(0, 0, WIDTH, HEIGHT, KColor.WHITE);
		background.drawRect(borderSize, borderSize, WIDTH - borderSize * 2,
			HEIGHT - borderSize * 2, BGCOLOR);
		add(background);
	}

	public function createStatText(position:FlxPoint) {
		var padding = 6;
		var x = position.x + padding + borderSize;
		var y = position.y + padding + borderSize;
		statText = new FlxText(x, y, cast WIDTH - (12 + borderSize), '',
			Globals.FONT_N);
		statText.wordWrap = true;

		add(statText);
	}

	public function createTurrets(position:FlxPoint) {
		var padding = 108;
		var verticalPadding = 24;
		var horizontalSpacing = 24;
		var startPosition = background.x + padding;
		var x = startPosition;
		var y = background.y
			+ (background.height - (verticalPadding + borderSize));

		for (i in 0...DepotData.Turrets.lines.length) {
			var turretData = DepotData.Turrets.lines[i];
			var sprite = new FlxSprite(x, y);
			x += horizontalSpacing + sprite.width;
			var spriteRef = turretData.sprite.replace('../../', 'assets/');
			if (turretData.sprite.length > 0) {
				sprite.loadGraphic(spriteRef, true, 16, 16, true);
			}
			turretSprites.push(sprite);
			turretInfo.push(cast turretData);
			add(sprite);
		}
	}

	public function createRangeCircle(position:FlxPoint) {
		rangeCircle = new FlxSprite(0, 0);
		rangeCircle.makeGraphic(FlxG.width, FlxG.height, KColor.TRANSPARENT,
			true);
		rangeCircle.visible = false;
		add(rangeCircle);
	}

	public function createSelectionRect(position:FlxPoint) {
		selectionRect = new FlxSprite(0, 0);
		// Add true here so that we don't affect other transparent spites
		// With drawing the border with our draw rect
		selectionRect.makeGraphic(16, 16, KColor.TRANSPARENT, true);
		selectionRect.drawRect(0, 0, 16, 16, KColor.TRANSPARENT, {
			thickness: 2,
			color: KColor.WHITE
		});
		selectionRect.visible = false;
		add(selectionRect);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		if (visible == true) {
			updateSelection();
		}
	}

	public function updateSelection() {
		for (i in 0...turretSprites.length) {
			var turret = turretSprites[i];
			var turretData = turretInfo[i];
			if (FlxG.mouse.overlaps(turret)
				&& currentTurretPosition != null && FlxG.mouse.justPressed) {
				// Handle Clicking Turret for creation & Range Indicator
				if (clickTurret != null) {
					clickTurret(this, turretData);
				}
			} else if (FlxG.mouse.overlaps(turret)
				&& turret.x != selectionRect.x) {
				selectSound.play();
				selectionRect.setPosition(turret.x, turret.y);
				selectionRect.visible = true;
				updateTurretInformation(turretData);
				updateRangeIndicator(turretData);
			}
		}
	}

	public function updateRangeIndicator(turretData:TurretData) {
		if (currentTurretPosition != null) {
			rangeCircle.visible = true;
			var pos = currentTurretPosition.getPosition();
			rangeCircle.fill(KColor.TRANSPARENT); // CLear
			var offsetY = 8;
			var offsetX = -32;
			rangeCircle.drawCircle(pos.x + offsetX, pos.y + offsetY,
				turretData.range, KColor.TRANSPARENT, {
					thickness: 5,
					color: KColor.WHITE
				});
		} else {
			rangeCircle.fill(KColor.TRANSPARENT); // CLear
			rangeCircle.visible = false;
		}
	}

	public function updateTurretInformation(turretData:TurretData) {
		var atk = '${turretData.atk}'.rpad(' ', 5);
		var atkSpd = '${turretData.atkSpd}'.rpad(' ', 5);
		var range = '${turretData.range}'.rpad(' ', 5);
		var points = '${turretData.cost}'.rpad(' ', 3);
		statText.text = 'Name ${turretData.name.capitalize().rpad(' ', 7)} Atk ${atk} AtkSpd ${atkSpd} Rng ${range} Pts ${points}';
	}

	public function move(x:Float, y:Float) {
		members.iter((member) -> {
			var currentPosition = member.getPosition();
			var newPosition = new FlxPoint(x, y);
			newPosition.putWeak();
			var diffPosition = newPosition.subtractPoint(currentPosition);
			// Adjust the relative components by the new position of the container
			var relativeX = currentPosition.x - position.x;
			var relativeY = currentPosition.y - position.y;
			member.x += diffPosition.x + relativeX;
			member.y += diffPosition.y + relativeY;
		});
		position.set(x, y);
	}

	public function show() {
		visible = true;
	}

	public function hide() {
		currentTurretPosition = null;
		rangeCircle.visible = false;
		selectionRect.visible = false;
		selectionRect.setPosition(0, 0);
		visible = false;
	}
}
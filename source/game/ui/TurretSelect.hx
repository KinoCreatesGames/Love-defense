package game.ui;

class TurretSelect extends FlxTypedGroup<FlxSprite> {
	public var position:FlxPoint;
	public var background:FlxSprite;
	public var selectionRect:FlxSprite;
	public var statText:FlxText;
	public var borderSize:Float;
	public var turretSprites:Array<FlxSprite>;
	public var turretInfo:Array<TurretData>;
	public var playerTurrets:FlxTypedGroup<Turret>;
	public var currentTurretPosition:FlxSprite;
	public var clickTurret:(TurretSelect, TurretData) -> Void;

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
		create();
	}

	public function create() {
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
				sprite.loadGraphic(spriteRef, false, 16, 16);
			}
			turretSprites.push(sprite);
			turretInfo.push(cast turretData);
			add(sprite);
		}
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
		updateSelection();
	}

	public function updateSelection() {
		for (i in 0...turretSprites.length) {
			var turret = turretSprites[i];
			var turretData = turretInfo[i];
			if (FlxG.mouse.overlaps(turret)
				&& currentTurretPosition != null && FlxG.mouse.justPressed) {
				// Handle Clicking Turret for creation
				if (clickTurret != null) {
					clickTurret(this, turretData);
				}
			} else if (FlxG.mouse.overlaps(turret)) {
				selectionRect.setPosition(turret.x, turret.y);
				selectionRect.visible = true;
				updateTurretInformation(turretData);
			}
		}
	}

	public function updateTurretInformation(turretData:TurretData) {
		var atk = '${turretData.atk}'.rpad(' ', 5);
		var atkSpd = '${turretData.atkSpd}'.rpad(' ', 5);
		var range = '${turretData.range}'.rpad(' ', 5);
		statText.text = 'Name ${turretData.name.capitalize().rpad(' ', 7)} Atk ${atk} AtkSpd ${atkSpd} Rng ${range}';
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
		visible = false;
	}
}
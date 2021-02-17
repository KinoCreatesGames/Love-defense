package game.ui;

class TurretSelect extends FlxTypedGroup<FlxSprite> {
	public var position:FlxPoint;
	public var background:FlxSprite;
	public var nameText:FlxText;
	public var borderSize:Float;
	public var turretSprites:Array<FlxSprite>;

	public static inline var WIDTH:Int = 400;
	public static inline var HEIGHT:Int = 60;
	public static inline var BGCOLOR:Int = KColor.RICH_BLACK;

	public function new(x:Float, y:Float) {
		super();
		position = new FlxPoint(x, y);
		borderSize = 4;
		turretSprites = [];
		create();
	}

	public function create() {
		createBackground(position);
		createNameText(position);
		createTurrets(position);
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

	public function createNameText(position:FlxPoint) {
		var padding = 6;
		var x = position.x + padding + borderSize;
		var y = position.y + padding + borderSize;
		nameText = new FlxText(x, y, cast WIDTH - (12 + borderSize), 'Name',
			Globals.FONT_N);
		nameText.wordWrap = true;

		add(nameText);
	}

	public function createTurrets(position:FlxPoint) {
		var padding = 6;
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
			add(sprite);
		}
	}

	public function setName(value:String) {
		nameText.text = value;
	}

	public function updateTurretInformation() {}

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
		visible = false;
	}
}
package game.ui;

class PlayerHUD extends FlxTypedGroup<FlxSprite> {
	public var timer:Float;
	public var timerText:FlxText;
	public var score:Float;
	public var scoreText:FlxText;
	public var turretPoints:Int;
	public var turretPointsText:FlxText;
	public var heartHealthBar:FlxBar;
	public var heart:FlxSprite;

	public function new(heart:FlxSprite) {
		super();
		this.heart = heart;
		create();
	}

	public function create() {
		createTimer();
		createHeartHealth();
		createTurretPoints();
		createScore();
	}

	public function createTimer() {
		var padding = 12;
		timerText = new FlxText(0, padding, -1, 'Time  0', Globals.FONT_N);
		timerText.screenCenterHorz();
		add(timerText);
	}

	public function createHeartHealth() {
		var padding = 12;
		heartHealthBar = new FlxBar(padding, padding, LEFT_TO_RIGHT, 64, 16,
			heart, 'health', 0, heart.health);
		var pink = 0xFFFF6B97;
		var lightOrange = 0xFFff9166;
		heartHealthBar.createFilledBar(KColor.RICH_BLACK_FORGRA, pink, true,
			lightOrange);
		add(heartHealthBar);
	}

	public function createTurretPoints() {
		var padding = 12;
		turretPoints = 0;
		turretPointsText = new FlxText(padding,
			heartHealthBar.y + heartHealthBar.height + padding, -1,
			'TPoints  0', Globals.FONT_N);
		add(turretPointsText);
	}

	public function createScore() {
		var padding = 12;
		score = 0;
		scoreText = new FlxText(0, padding, -1, 'Score 0', Globals.FONT_N);
		scoreText.text = 'Score  ${score}';
		scoreText.x = FlxG.width - (scoreText.width + padding);
		add(scoreText);
	}

	public function setTimer(time:Float) {
		timer = time;
		updateTimer();
	}

	public function updateTimer() {
		timerText.text = 'Time  ${Math.ceil(timer)}';
	}

	public function setTurretPoints(value:Int) {
		turretPoints = value;
		updateTurretPoints();
	}

	public function updateTurretPoints() {
		turretPointsText.text = 'TPoints  ${turretPoints}';
	}

	public function setScore(value:Float) {
		score = value;
		updateScore();
	}

	public function updateScore() {
		var padding = 12;
		scoreText.text = 'Score  ${score}';
		scoreText.x = FlxG.width - (scoreText.width + padding);
	}
}
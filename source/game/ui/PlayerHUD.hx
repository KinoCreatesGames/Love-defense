package game.ui;

class PlayerHUD extends FlxTypedGroup<FlxSprite> {
	public var timer:Float;
	public var timerText:FlxText;
	public var score:Float;
	public var scoreText:FlxText;
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

	public function createScore() {
		var padding = 12;
		score = 0;
		scoreText = new FlxText(0, padding, -1, 'Score 0', Globals.FONT_N);
		scoreText.text = 'Score  ${score}';
		scoreText.x = FlxG.width - (scoreText.width + padding);
		add(scoreText);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	public function setTimer(time:Float) {
		timer = time;
		updateTimer();
	}

	public function updateTimer() {
		timerText.text = 'Time  ${Math.ceil(timer)}';
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
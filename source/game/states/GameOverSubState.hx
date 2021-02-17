package game.states;

import game.ui.TextButton;

class GameOverSubState extends FlxSubState {
	public var background:FlxSprite;
	public var gameOverText:FlxText;
	public var continueButton:TextButton;
	public var toTitleButton:TextButton;

	private var initialPosition:Float;
	private var timeCount:Float;

	public function new() {
		super();
	}

	override public function create() {
		super.create();
		timeCount = 0;
		createBackground();
		createCongrats();
		createButtons();
	}

	// note 480 x 270
	public function createBackground() {
		var width = FlxG.width / 2;
		var height = FlxG.height / 2;
		background = new FlxSprite(width, height);
		background.makeGraphic(cast width, cast height, KColor.TRANSPARENT);
		background.screenCenter();
		add(background);
	}

	public function createCongrats() {
		gameOverText = new FlxText(background.x, background.y, -1,
			Globals.TEXT_GAME_OVER, Globals.FONT_L);

		initialPosition = gameOverText.y;
		add(gameOverText);
	}

	public function createButtons() {
		var padding = 24;
		var x = background.x + padding;
		var y = background.y + (background.height - padding);
		continueButton = new TextButton(cast x, cast y, 'Continue',
			Globals.FONT_N, clickContinue);

		continueButton.hoverColor = KColor.PRETTY_PINK;
		continueButton.clickColor = KColor.RICH_BLACK_FORGRA;

		x = background.x + (background.width - padding);
		toTitleButton = new TextButton(cast x, cast y, 'To Title',
			Globals.FONT_N, clickToTitle);

		toTitleButton.hoverColor = KColor.PRETTY_PINK;
		toTitleButton.clickColor = KColor.RICH_BLACK_FORGRA;
		add(continueButton);
		add(toTitleButton);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateGameOver(elapsed);
	}

	public function updateGameOver(elapsed:Float) {
		timeCount += elapsed;
		gameOverText.y = initialPosition + (30 * Math.sin(timeCount));
		if (timeCount > 30) {
			timeCount = 0;
		}
	}

	public function clickContinue() {
		// Return to previous level and restart
		FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
			close();
			FlxG.resetState();
			// FlxG.camera.fade(KColor.BLACK, 1, true);
			// FlxG.switchState(new TitleState());
		});
	}

	public function clickToTitle() {
		FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
			close();
			// FlxG.camera.fade(KColor.BLACK, 1, true);
			FlxG.switchState(new TitleState());
		});
	}
}
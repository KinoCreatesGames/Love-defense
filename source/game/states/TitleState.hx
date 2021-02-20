package game.states;

import game.ui.TextButton;
import flixel.util.FlxAxes;

/**
 * Add Press Start Before entering main scene for title
 * as part of the update functionality
 */
class TitleState extends FlxState {
	public var pressStartText:FlxText;
	public var playButton:TextButton;
	public var completeFadeStart:Bool;
	#if desktop
	public var exitButton:TextButton;
	#end

	override public function create() {
		FlxG.sound.playMusic(AssetPaths.title_music__ogg);
		FlxG.mouse.visible = true;
		bgColor = KColor.RICH_BLACK_FORGRA;
		// Create Title Text
		var text = new FlxText(0, 0, -1, Globals.GAME_TITLE, 32);
		add(text);
		text.alignment = CENTER;
		text.screenCenter();
		completeFadeStart = false;
		createPressStart();
		createButtons();
		// createControls();
		createCredits();
		createVersion();
		super.create();
	}

	public function createPressStart() {
		pressStartText = new FlxText(0, 0, -1, 'Press Any Button To Start',
			Globals.FONT_N);
		pressStartText.screenCenter();
		pressStartText.y += 40;
		// add later
		add(pressStartText);
		pressStartText.flicker(0, .4);
	}

	public function createButtons() {
		// Create Buttons
		var spacing = 16;
		var y = 40;
		playButton = new TextButton(0, 0, Globals.TEXT_START, Globals.FONT_N,
			clickStart);
		playButton.hoverColor = KColor.BURGUNDY;
		playButton.clickColor = KColor.BURGUNDY;
		playButton.screenCenter();
		playButton.y += y;
		y += spacing;
		#if desktop
		exitButton = new TextButton(0, 0, Globals.TEXT_EXIT, Globals.FONT_N,
			clickExit);
		exitButton.hoverColor = KColor.BURGUNDY;
		exitButton.clickColor = KColor.BURGUNDY;
		exitButton.screenCenter();
		exitButton.y += y;
		#end
		// Add Buttons
		playButton.canClick = false;
		playButton.alpha = 0;

		add(playButton);
		#if desktop
		exitButton.canClick = false;
		exitButton.alpha = 0;
		add(exitButton);
		#end
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updatePressStart(elapsed);
	}

	public function updatePressStart(elapsed:Float) {
		var keyPressed = FlxG.keys.firstPressed();
		if (keyPressed != -1) {
			pressStartText.stopFlickering();
			pressStartText.visible = false;
		} else if (pressStartText.visible) {}

		var fadeTime = 0.25;
		if (!pressStartText.visible && !pressStartText.isFlickering()
			&& completeFadeStart == false) {
			playButton.fadeIn(fadeTime);
			if (playButton.alpha >= .9) {
				#if !desktop
				completeFadeStart = true;
				#end
			}

			#if desktop
			if (creditsButton.alpha >= .9) {
				exitButton.fadeIn(fadeTime);
				completeFadeStart = true;
			}
			exitButton.visible = true;
			#end
		}

		if (completeFadeStart) {
			playButton.canClick = true;

			#if desktop
			exitButton.canClick = true;
			#end
		}
	}

	public function clickStart() {
		FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
			FlxG.sound.music.fadeOut(1);
			FlxG.camera.fade(KColor.BLACK, 1, true);
			FlxG.switchState(new LevelOneState());
		});
	}

	#if desktop
	public function clickExit() {
		Sys.exit(0);
	}
	#end

	public function createControls() {
		var textWidth = 200;
		var textSize = 12;
		var controlsText = new FlxText(20, FlxG.height - 20, textWidth,
			'How To Move:
UP: W/UP
Left/Right: A/Left, S/Right', textSize);
		add(controlsText);
	}

	public function createCredits() {
		var textWidth = 200;
		var textSize = 12;
		var creditsText = new FlxText(FlxG.width - textWidth,
			FlxG.height - 20, textWidth, 'Created by KinoCreates', textSize);
		add(creditsText);
	}

	public function createVersion() {
		var textWidth = 200;
		var textSize = 12;
		var versionText = new FlxText(20, FlxG.height - 20, textWidth,
			Globals.TEXT_VERSION, textSize);
		add(versionText);
	}
}
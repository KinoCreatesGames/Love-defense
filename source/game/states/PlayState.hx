package game.states;

import flixel.system.FlxAssets.FlxShader;
import openfl.filters.ShaderFilter;
import openfl.display.StageQuality;
import flixel.text.FlxText;
import flixel.FlxState;

class PlayState extends FlxState {
	override public function create() {
		super.create();
		// FlxG.camera.pixelPerfectRender = true;
		var text = new FlxText("Hello World", 8);
		text.screenCenter();
		add(text);

		var testSprite = new FlxSprite(40, 40);
		var testSprite2 = new FlxSprite(64, 64);
		testSprite.makeGraphic(8, 8, KColor.WHITE);
		testSprite2.makeGraphic(16, 16, KColor.WHITE);

		add(testSprite);
		add(testSprite2);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}
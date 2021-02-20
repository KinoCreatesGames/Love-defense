package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:pathy33:assets%2Fmaps%2Flove-defense.ldtky4:sizei49726y4:typey4:TEXTy2:idR1y7:preloadtgoR0y51:assets%2Fmaps%2Flove-defense%2Ftiled%2FLevelOne.tmxR2i10825R3R4R5R7R6tgoR0y57:assets%2Fmaps%2Flove-defense%2Ftiled%2Flove-defense.worldR2i79R3R4R5R8R6tgoR2i4758R3y5:SOUNDR5y31:assets%2Fsounds%2Ffootsteps.wavy9:pathGroupaR10hR6tgoR2i3672R3R9R5y32:assets%2Fsounds%2Fmouse-over.wavR11aR12hR6tgoR2i6900R3R9R5y31:assets%2Fsounds%2Fmenu-open.wavR11aR13hR6tgoR2i8410R3R9R5y34:assets%2Fsounds%2Fimpact-heart.wavR11aR14hR6tgoR2i4584R3R9R5y33:assets%2Fsounds%2Fbullet-fire.wavR11aR15hR6tgoR2i19472R3R9R5y31:assets%2Fsounds%2Fpause-out.wavR11aR16hR6tgoR2i60190R3R9R5y30:assets%2Fsounds%2Fpower-up.wavR11aR17hR6tgoR2i4578R3R9R5y38:assets%2Fsounds%2Fturret-menu-exit.wavR11aR18hR6tgoR2i8378R3R9R5y34:assets%2Fsounds%2Fbutton-click.wavR11aR19hR6tgoR2i12492R3R9R5y34:assets%2Fsounds%2Fenemy-impact.wavR11aR20hR6tgoR2i218252R3R9R5y34:assets%2Fsounds%2Fheart-blowup.wavR11aR21hR6tgoR2i22964R3R9R5y30:assets%2Fsounds%2Fpause-in.wavR11aR22hR6tgoR0y36:assets%2Fsounds%2Fsounds-go-here.txtR2zR3R4R5R23R6tgoR2i39740R3R9R5y32:assets%2Fsounds%2Flow-health.wavR11aR24hR6tgoR0y35:assets%2Fimages%2Ffloor-tileset.pngR2i691R3y5:IMAGER5R25R6tgoR0y29:assets%2Fimages%2Fcog-two.pngR2i512R3R26R5R27R6tgoR0y28:assets%2Fimages%2Fbutton.pngR2i1126R3R26R5R28R6tgoR0y31:assets%2Fimages%2Fexit-door.pngR2i382R3R26R5R29R6tgoR0y37:assets%2Fimages%2Fcrystal-defense.pngR2i318R3R26R5R30R6tgoR0y34:assets%2Fimages%2Fmonster-gate.pngR2i142R3R26R5R31R6tgoR0y33:assets%2Fimages%2Flove-turret.pngR2i244R3R26R5R32R6tgoR0y30:assets%2Fimages%2FenemyOne.pngR2i370R3R26R5R33R6tgoR0y38:assets%2Fimages%2Flove-bomb-turret.pngR2i311R3R26R5R34R6tgoR0y36:assets%2Fimages%2Fimages-go-here.txtR2zR3R4R5R35R6tgoR0y33:assets%2Fimages%2Fheart-nexus.pngR2i314R3R26R5R36R6tgoR0y37:assets%2Fimages%2Faffection-heart.pngR2i685R3R26R5R37R6tgoR0y37:assets%2Fimages%2Flove-ice-turret.pngR2i295R3R26R5R38R6tgoR0y34:assets%2Fimages%2Fdialog-arrow.pngR2i261R3R26R5R39R6tgoR0y40:assets%2Fimages%2Flove-nature-turret.pngR2i327R3R26R5R40R6tgoR0y37:assets%2Fimages%2Flove-turret-two.pngR2i330R3R26R5R41R6tgoR0y28:assets%2Fimages%2Fspeedy.pngR2i249R3R26R5R42R6tgoR0y39:assets%2Fimages%2Flove-flame-turret.pngR2i265R3R26R5R43R6tgoR0y36:assets%2Fmusic%2Fmusic-goes-here.txtR2zR3R4R5R44R6tgoR2i1322654R3y5:MUSICR5y32:assets%2Fmusic%2Fsetup-music.oggR11aR46hR6tgoR2i2789536R3R45R5y32:assets%2Fmusic%2Ftitle-music.oggR11aR47hR6tgoR2i4096760R3R9R5y37:assets%2Fmusic%2Fmovingrightalong.wavR11aR48hR6tgoR2i2789536R3R45R5y61:assets%2Fmusic%2Ftriangular%20ideology-the%20fan%20sequel.oggR11aR49hR6tgoR0y34:assets%2Fdata%2Fdata-goes-here.txtR2zR3R4R5R50R6tgoR0y32:assets%2Fdata%2Flove-defense.dpoR2i14735R3R4R5R51R6tgoR2i39706R3R45R5y28:flixel%2Fsounds%2Fflixel.mp3R11aR52y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i2114R3R45R5y26:flixel%2Fsounds%2Fbeep.mp3R11aR54y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i5794R3R9R5R55R11aR54R55hgoR2i33629R3R9R5R53R11aR52R53hgoR2i15744R3y4:FONTy9:classNamey35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R56R57y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R26R5R62R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R26R5R63R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_maps_love_defense_ldtk extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_maps_love_defense_tiled_levelone_tmx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_maps_love_defense_tiled_love_defense_world extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_footsteps_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_mouse_over_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_menu_open_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_impact_heart_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_bullet_fire_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_pause_out_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_power_up_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_turret_menu_exit_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_button_click_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_enemy_impact_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_heart_blowup_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_pause_in_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_low_health_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_floor_tileset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_cog_two_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_exit_door_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_crystal_defense_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_monster_gate_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_love_turret_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_enemyone_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_love_bomb_turret_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_heart_nexus_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_affection_heart_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_love_ice_turret_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_dialog_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_love_nature_turret_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_love_turret_two_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_speedy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_love_flame_turret_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_setup_music_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_title_music_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_movingrightalong_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_triangular_ideology_the_fan_sequel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_love_defense_dpo extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/maps/love-defense.ldtk") @:noCompletion #if display private #end class __ASSET__assets_maps_love_defense_ldtk extends haxe.io.Bytes {}
@:keep @:file("assets/maps/love-defense/tiled/LevelOne.tmx") @:noCompletion #if display private #end class __ASSET__assets_maps_love_defense_tiled_levelone_tmx extends haxe.io.Bytes {}
@:keep @:file("assets/maps/love-defense/tiled/love-defense.world") @:noCompletion #if display private #end class __ASSET__assets_maps_love_defense_tiled_love_defense_world extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/footsteps.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_footsteps_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/mouse-over.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_mouse_over_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/menu-open.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_menu_open_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/impact-heart.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_impact_heart_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/bullet-fire.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_bullet_fire_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/pause-out.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_pause_out_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/power-up.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_power_up_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/turret-menu-exit.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_turret_menu_exit_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/button-click.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_button_click_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/enemy-impact.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_enemy_impact_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/heart-blowup.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_heart_blowup_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/pause-in.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_pause_in_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sounds-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/low-health.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_low_health_wav extends haxe.io.Bytes {}
@:keep @:image("assets/images/floor-tileset.png") @:noCompletion #if display private #end class __ASSET__assets_images_floor_tileset_png extends lime.graphics.Image {}
@:keep @:image("assets/images/cog-two.png") @:noCompletion #if display private #end class __ASSET__assets_images_cog_two_png extends lime.graphics.Image {}
@:keep @:image("assets/images/button.png") @:noCompletion #if display private #end class __ASSET__assets_images_button_png extends lime.graphics.Image {}
@:keep @:image("assets/images/exit-door.png") @:noCompletion #if display private #end class __ASSET__assets_images_exit_door_png extends lime.graphics.Image {}
@:keep @:image("assets/images/crystal-defense.png") @:noCompletion #if display private #end class __ASSET__assets_images_crystal_defense_png extends lime.graphics.Image {}
@:keep @:image("assets/images/monster-gate.png") @:noCompletion #if display private #end class __ASSET__assets_images_monster_gate_png extends lime.graphics.Image {}
@:keep @:image("assets/images/love-turret.png") @:noCompletion #if display private #end class __ASSET__assets_images_love_turret_png extends lime.graphics.Image {}
@:keep @:image("assets/images/enemyOne.png") @:noCompletion #if display private #end class __ASSET__assets_images_enemyone_png extends lime.graphics.Image {}
@:keep @:image("assets/images/love-bomb-turret.png") @:noCompletion #if display private #end class __ASSET__assets_images_love_bomb_turret_png extends lime.graphics.Image {}
@:keep @:file("assets/images/images-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/images/heart-nexus.png") @:noCompletion #if display private #end class __ASSET__assets_images_heart_nexus_png extends lime.graphics.Image {}
@:keep @:image("assets/images/affection-heart.png") @:noCompletion #if display private #end class __ASSET__assets_images_affection_heart_png extends lime.graphics.Image {}
@:keep @:image("assets/images/love-ice-turret.png") @:noCompletion #if display private #end class __ASSET__assets_images_love_ice_turret_png extends lime.graphics.Image {}
@:keep @:image("assets/images/dialog-arrow.png") @:noCompletion #if display private #end class __ASSET__assets_images_dialog_arrow_png extends lime.graphics.Image {}
@:keep @:image("assets/images/love-nature-turret.png") @:noCompletion #if display private #end class __ASSET__assets_images_love_nature_turret_png extends lime.graphics.Image {}
@:keep @:image("assets/images/love-turret-two.png") @:noCompletion #if display private #end class __ASSET__assets_images_love_turret_two_png extends lime.graphics.Image {}
@:keep @:image("assets/images/speedy.png") @:noCompletion #if display private #end class __ASSET__assets_images_speedy_png extends lime.graphics.Image {}
@:keep @:image("assets/images/love-flame-turret.png") @:noCompletion #if display private #end class __ASSET__assets_images_love_flame_turret_png extends lime.graphics.Image {}
@:keep @:file("assets/music/music-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/music/setup-music.ogg") @:noCompletion #if display private #end class __ASSET__assets_music_setup_music_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/music/title-music.ogg") @:noCompletion #if display private #end class __ASSET__assets_music_title_music_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/music/movingrightalong.wav") @:noCompletion #if display private #end class __ASSET__assets_music_movingrightalong_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/triangular ideology-the fan sequel.ogg") @:noCompletion #if display private #end class __ASSET__assets_music_triangular_ideology_the_fan_sequel_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/data/data-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/love-defense.dpo") @:noCompletion #if display private #end class __ASSET__assets_data_love_defense_dpo extends haxe.io.Bytes {}
@:keep @:file("/home/runner/haxe/haxe_libraries/flixel/4.8.1/haxelib/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("/home/runner/haxe/haxe_libraries/flixel/4.8.1/haxelib/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("/home/runner/haxe/haxe_libraries/flixel/4.8.1/haxelib/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("/home/runner/haxe/haxe_libraries/flixel/4.8.1/haxelib/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("/home/runner/haxe/haxe_libraries/flixel/4.8.1/haxelib/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("/home/runner/haxe/haxe_libraries/flixel/4.8.1/haxelib/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end

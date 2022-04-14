#if sys
package;

import lime.app.Application;
#if windows
import Discord.DiscordClient;
#end
import openfl.display.BitmapData;
import openfl.utils.Assets;
import flixel.ui.FlxBar;
import haxe.Exception;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
#if cpp
import sys.FileSystem;
import sys.io.File;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;

using StringTools;

class Caching extends MusicBeatState
{
	var toBeDone = 0;
	var done = 0;

	var loaded = false;

	var bg:FlxSprite;
	var loadingText:FlxText;

	var music = [];
	var characters = [];
	var ccStuff = [];

	override function create()
	{
		FlxG.save.bind('funkin', 'ninjamuffin99');

		PlayerSettings.init();

		KadeEngineData.initSave();

		FlxG.mouse.visible = false;

		FlxG.worldBounds.set(0,0);

		loadingText = new FlxText(0, FlxG.height - 65, FlxG.width, "", 36);
        loadingText.setFormat(Paths.font("vcr.ttf"), 36, FlxColor.WHITE, CENTER);
        loadingText.screenCenter(X);

		#if cpp
		trace("caching music...");

		for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/songs")))
		{
			music.push(i);
		}

		trace("caching characters...");

		for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/shared/images/characters")))
		{
			if (!i.endsWith(".png"))
				continue;

			characters.push(i);
		}

		trace("caching cc stuff...");

		for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/shared/images/cc")))
		{
			if (!i.endsWith(".png"))
				continue;

			ccStuff.push(i);
		}
		#end

		toBeDone = Lambda.count(music) + Lambda.count(characters) + Lambda.count(ccStuff);

		add(loadingText);

		FlxG.mouse.visible = false;

		trace('starting caching..');
		
		#if cpp
		sys.thread.Thread.create(() -> {
			cache();
		});
		#end

		super.create();
	}

	var calledDone = false;

	override function update(elapsed) 
	{
		loadingText.text = "Loading" + " (" + done + "/" + toBeDone + ")";
		
		super.update(elapsed);
	}

	function cache()
	{
		trace("LOADING: " + toBeDone + " OBJECTS.");

		for (i in music)
		{
			FlxG.sound.cache(Paths.inst(i));
			FlxG.sound.cache(Paths.voices(i));
			trace("cached " + i);
			done++;
		}

		for (i in characters)
		{
			var replaced = i.replace(".png", "");
			FlxG.bitmap.add(Paths.image("characters/" + replaced, 'shared'));
			trace("cached " + replaced);
			done++;
		}

		for (i in ccStuff)
		{
			var replaced = i.replace(".png", "");
			FlxG.bitmap.add(Paths.image("cc/" + replaced, 'shared'));
			trace("cached " + replaced);
			done++;
		}

		trace("Finished caching...");

		loaded = true;

		FlxG.switchState(new TitleState());
	}
}
#end
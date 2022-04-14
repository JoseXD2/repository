package;

import flixel.FlxSprite;
import flixel.FlxG;

class NoteSplash extends FlxSprite
{
    public function new(x:Float = 0, y:Float = 0, note:Int = 0)
    {
        super(x, y);

		frames = Paths.getSparrowAtlas('noteStuff/noteSplashes' + (FlxG.save.data.noteColor ? '-gray' : ''));

        animation.addByPrefix("splash-0-0", "left 1", 24, false);
        animation.addByPrefix("splash-0-1", "left 2", 24, false);
		animation.addByPrefix("splash-1-0", "down 1", 24, false);
        animation.addByPrefix("splash-1-1", "down 2", 24, false);
		animation.addByPrefix("splash-2-0", "up 1", 24, false);
        animation.addByPrefix("splash-2-1", "up 2", 24, false);
		animation.addByPrefix("splash-3-0", "right 1", 24, false);
        animation.addByPrefix("splash-3-1", "right 2", 24, false);

		setupNoteSplash(x, y, note);
        antialiasing = true;
    }

    public function setupNoteSplash(x:Float, y:Float, note:Int = 0) 
    {
		setPosition(x, y);
		var dir:Int = FlxG.random.int(0, 1);
		alpha = 0.6;
		animation.play('splash-' + note + '-' + dir, true);
		updateHitbox();
		offset.set(0.2 * width, 0.2 * height);
	}

    override function update(elapsed:Float) 
    {
		if(animation.curAnim.finished) kill();

		super.update(elapsed);
	}
}

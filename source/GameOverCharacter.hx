package;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxSprite;

class GameOverCharacter extends FlxSprite
{
    public var animOffsets:Map<String, Array<Dynamic>>;

    public function new(x:Float, y:Float, ?reason:String = 'cc')
    {
        super(x, y);

        animOffsets = new Map<String, Array<Dynamic>>();

        var tex:FlxAtlasFrames;

        switch (reason)
        {
            case 'cc':
                tex = Paths.getSparrowAtlas('BOYFRIEND', 'shared', true);
				frames = tex;

                animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

                addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);

            case 'meat':
                tex = Paths.getSparrowAtlas('meatBF', 'shared', true);
                frames = tex;

                animation.addByPrefix('firstDeath', 'bf dies meat note', 24, false);

                addOffset('firstDeath');
        }

        antialiasing = true;
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (animation.curAnim.name == 'firstDeath' && animation.curAnim.finished && animOffsets.exists('deathLoop'))
            playAnim('deathLoop');
    }

    public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
    {
        animation.play(AnimName, Force, Reversed, Frame);
    
        var daOffset = animOffsets.get(AnimName);
    
        if (animOffsets.exists(AnimName))
            offset.set(daOffset[0], daOffset[1]);
         else
            offset.set(0, 0);
    }

    public function addOffset(name:String, x:Float = 0, y:Float = 0)
    {
        animOffsets[name] = [x, y];
    }
}
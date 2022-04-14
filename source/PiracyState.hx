package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;

class PiracyState extends MusicBeatState
{
    override public function create()
    {
        var lol:FlxSprite = new FlxSprite().loadGraphic(Paths.image('cc/antiPiracy', 'shared'));
        lol.setGraphicSize(FlxG.width, FlxG.height);
        lol.updateHitbox();
        lol.antialiasing = true;
        add(lol);

        trace('pirate detected!1! >:(');
        
        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}

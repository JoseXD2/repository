package;

import flixel.text.FlxText;
import openfl.Assets;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.addons.text.FlxTypeText;
import flixel.FlxG;

using StringTools;

class CheatingState extends MusicBeatState
{
    var text:Array<String> = [
        'Oh... - nothing',
        'It seems that little Boyfriend wants to break the rules... - nothing',
        'Too bad. - crash'
    ];

    var dialogue:String;
    var curDialogue:Int;

    var effect:String = 'nothing';

    var dialogueText:FlxTypeText;

    override public function create() 
    {
        trace('cheating moment');

        if (FlxG.sound.music != null && FlxG.sound.music.playing)
            FlxG.sound.music.fadeOut(1.2, 0);
        
        dialogueText = new FlxTypeText(73, FlxG.height - 75, FlxG.width, "", 36);
        dialogueText.font = "Karma Suture";
        dialogueText.color = FlxColor.WHITE;
        dialogueText.sounds = [FlxG.sound.load(Paths.sound('text', 'shared'), 0.6)];
        add(dialogueText);

        startDialogue();

        super.create();   
    }

    override public function update(elapsed:Float) 
    {
        super.update(elapsed);

        // here we go
        if (text[curDialogue+1] != null)
        {
            dialogueText.completeCallback = function ()
            {
                new FlxTimer().start(2, function (tmr:FlxTimer)
                {
                    curDialogue++;
                    startDialogue(); 
                });
            };
        }
    }

    function startDialogue()
	{
        cleanDialog();

		dialogueText.resetText(dialogue);
		dialogueText.start(0.04, true);

        switch (effect)
        {
            case 'crash':
                new FlxTimer().start(2, function (tmr:FlxTimer)
                {
                    FlxTween.tween(dialogueText, {alpha: 0}, 0.5, {
                        ease: FlxEase.quadOut, 
                        onComplete: function (twn:FlxTween)
                        {
                            Sys.exit(0);
                        }
                    });
                });  
        }
	}

    function cleanDialog()
	{
        var data:Array<String> = text[curDialogue].split(" - ");
        dialogue = data[0];
        effect = data[1];
	}
}
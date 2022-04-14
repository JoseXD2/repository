package;

import flixel.FlxSprite;

using StringTools;

class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;
	public var isPlayer:Bool;
	public var status:String = 'normal';

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();

		this.isPlayer = isPlayer;

		changeIcon(char);
		antialiasing = true;
		scrollFactor.set();
	}

	public function changeIcon(newChar:String)
	{
		if (animation.getByName(newChar) == null)
		{
			if (newChar == 'cc-angry')
				newChar = 'cc';

			var file = Paths.image('icons/icon-' + newChar);
			
			loadGraphic(file, true, 150, 150);

			animation.add(newChar, [0, 1, 2], 0, false, isPlayer);
			animation.play(newChar);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		switch (status)
		{
			case 'normal':
				animation.curAnim.curFrame = 0;
			case 'losing':
				animation.curAnim.curFrame = 1;
			case 'winning':
				animation.curAnim.curFrame = 2;
		}

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}

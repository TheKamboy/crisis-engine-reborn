package objects;

// old code
// class HealthIcon extends FlxSprite
// {
// 	public var sprTracker:FlxSprite;
// 	private var isOldIcon:Bool = false;
// 	private var isPlayer:Bool = false;
// 	private var char:String = '';

// 	public function new(char:String = 'bf', isPlayer:Bool = false, ?allowGPU:Bool = true)
// 	{
// 		super();
// 		isOldIcon = (char == 'bf-old');
// 		this.isPlayer = isPlayer;
// 		changeIcon(char, allowGPU);
// 		scrollFactor.set();
// 	}

// 	override function update(elapsed:Float)
// 	{
// 		super.update(elapsed);

// 		if (sprTracker != null)
// 			setPosition(sprTracker.x + sprTracker.width + 12, sprTracker.y - 30);
// 	}

// 	private var iconOffsets:Array<Float> = [0, 0];
// 	public function changeIcon(char:String, ?allowGPU:Bool = true) {
// 		if(this.char != char) {
// 			var name:String = 'icons/' + char;
// 			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-' + char; //Older versions of psych engine's support
// 			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-face'; //Prevents crash from missing icon
			
// 			var graphic = Paths.image(name, allowGPU);
// 			loadGraphic(graphic, true, Math.floor(graphic.width / 2), Math.floor(graphic.height));
// 			iconOffsets[0] = (width - 150) / 2;
// 			iconOffsets[1] = (height - 150) / 2;
// 			updateHitbox();

// 			animation.add(char, [0, 1], 0, false, isPlayer);
// 			animation.play(char);
// 			this.char = char;

// 			if(char.endsWith('-pixel'))
// 				antialiasing = false;
// 			else
// 				antialiasing = ClientPrefs.data.antialiasing;
// 		}
// 	}

// 	override function updateHitbox()
// 	{
// 		super.updateHitbox();
// 		offset.x = iconOffsets[0];
// 		offset.y = iconOffsets[1];
// 	}

// 	public function getCharacter():String {
// 		return char;
// 	}
// }

import flixel.math.FlxMath;
import flixel.FlxSprite;
import openfl.utils.Assets as OpenFlAssets;
import flixel.FlxG;

using StringTools;

class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;
	public var canBounce:Bool = false;
	private var isOldIcon:Bool = false;
	private var isPlayer:Bool = false;
	private var char:String = '';

	public function new(char:String = 'bf', isPlayer:Bool = false, ?allowGPU:Bool = true)
	{
		super();
		isOldIcon = (char == 'bf-old');
		this.isPlayer = isPlayer;
		changeIcon(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}

	public function swapOldIcon() {
		if(isOldIcon = !isOldIcon) changeIcon('bf-old');
		else changeIcon('bf');
	}

	public var iconOffsets:Array<Float> = [0, 0];
	public function changeIcon(char:String) {
		if(this.char != char) {
			var name:String = 'icons/' + char;
			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-' + char; //Older versions of psych engine's support
			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-face'; //Prevents crash from missing icon
			var file:Dynamic = Paths.image(name);

			if (file == null)
				file == Paths.image('icons/icon-face');
			else if (!Paths.fileExists('images/icons/icon-face.png', IMAGE)){
				// throw "Don't delete the placeholder icon";
				trace("Warning: could not find the placeholder icon, expect crashes!");
			}

			loadGraphic(file); //Load stupidly first for getting the file size
			var width2 = width;
			if (width == 450) {
				iconOffsets = [0, 0, 0];
				loadGraphic(file, true, Math.floor(width / 3), Math.floor(height)); //Then load it fr // winning icons go br
				iconOffsets[0] = (width - 150) / 3;
				iconOffsets[1] = (width - 150) / 3;
				iconOffsets[2] = (width - 150) / 3;
			} else {
				loadGraphic(file, true, Math.floor(width / 2), Math.floor(height)); //Then load it fr // winning icons go br
				iconOffsets[0] = (width - 150) / 2;
				iconOffsets[1] = (width - 150) / 2;
			}

			updateHitbox();

			if (width2 == 450) {
				animation.add(char, [0, 1, 2], 0, false, isPlayer);
			} else {
				animation.add(char, [0, 1], 0, false, isPlayer);
			}
			animation.play(char);
			this.char = char;

			antialiasing = ClientPrefs.data.antialiasing;
			if(char.endsWith('-pixel')) {
				antialiasing = false;
			}
		}
	}

	public function bounce() {
		if(canBounce) {
			var mult:Float = 1.2;
			scale.set(mult, mult);
			updateHitbox();
		}
	}

	override function updateHitbox()
	{
		super.updateHitbox();
 		offset.x = iconOffsets[0];
 		offset.y = iconOffsets[1];
	}

	public function getCharacter():String {
		return char;
	}
}
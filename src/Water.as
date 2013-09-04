package  
{
	import flash.ui.ContextMenuBuiltInItems;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author mad
	 */
	public class Water extends FlxSprite 
	{
		//private var image:BitmapData;
		public var maxLevel:Number;
		public var conectorLevel:Number;
				
		public function Water(X:Number,Y:Number,_width:Number,_height:Number, _gravity:Number) 
		{
			super(X, Y);
			
			width = _width;
			height = _height;
			
			makeGraphic(width, height, 0xFF66FFFF);
			
			if (FlxG.getPlugin(FlxControl) == null)
			{
				FlxG.addPlugin(new FlxControl);
			}
			
			//	Add this sprite to the FlxControl plugin and tell it we want the sprite to accelerate and decelerate smoothly
			FlxControl.create(this, FlxControlHandler.MOVEMENT_INSTANT, FlxControlHandler.STOPPING_DECELERATES, 2, true, false);
			
			FlxControl.player2.setBounds(16, 0, 288, 240);
			
			FlxControl.player2.setBounds(16, 16, FlxG.width -32, FlxG.height -32);
			
			//	Because we are using the MOVEMENT_ACCELERATES type the first value is the acceleration speed of the sprite
			//	Think of it as the time it takes to reach maximum velocity. A value of 100 means it would take 1 second. A value of 400 means it would take 0.25 of a second.
			FlxControl.player2.setMovementSpeed(400, 0, 100, 200, 400, 0);
			
			//Set a downward gravity of 400px/sec
			FlxControl.player2.setGravity(0, _gravity);
				
		}
		
		//public function
		
	}

}
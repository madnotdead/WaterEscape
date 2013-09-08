 package  
{
	import flash.display.BitmapData;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author mad
	 */
	
	public class Room extends FlxSprite 
	{
		public var _water:Number;
		public var _left:Number;
		public var _top:Number;
		public var _rigth:Number;
		public var _bottom:Number;
		private var K:Number = 10;
		public var waterSprite:FlxSprite;
		public var _pressure:Number; 
		
		/**
		 * Constructor of the class Room
		 * 
		 * @param	x			The x position.
		 * @param	y			The y position.
		 * @param	left		The left side of the room.
		 * @param	top			The top of the room.
		 * @param	rigth		The rigth side of the room.
		 * @param	bottom		The bottom of the room.
		 * @param	water		Optional.The quantity of water allow in the room.
		 * 
		 */
		public function Room(x:Number,y:Number,left:Number,top:Number,rigth:Number,bottom:Number,water:Number=0,pressure:Number=10) 
		{
			super(x, y);
			
			width = rigth - left;
			
			height = bottom - top;
			
			_water = water;
			
			_left = left;
			_rigth = rigth;
			_top = top;
			_bottom = bottom;
		
			_pressure = pressure;
			
			waterSprite = new FlxSprite(width, height);
			
			makeGraphic(width, height, 0xFFFCF7E3);
		}
		
		override public function update():void 
		{
			drawWater();
			super.update();
		}
		
		public function getWaterLevel():Number
		{
			var maxUCWater:Number = this.width * this.height;
			var waterLevel:Number = 0;
			
/*			if (this._water < maxUCWater)
				waterLevel = this._bottom - this._water / this.width;
			else
				waterLevel =  this.height;*/
			
			if (_water < this.height)
				waterLevel = this._water;
			else
				waterLevel =  this.height;
			
			return waterLevel;
		}
		
		public function getPressureLevel():Number
		{
			var waterLevel:Number = this.getWaterLevel();
			//var waterLevel:Number = this._water;
			var pressureLevel:Number;
			
			if (waterLevel >= this._top) 
				pressureLevel = waterLevel;
			 else 
				pressureLevel =  this._top - K * this._water / (this.width * this.height);
			
				return pressureLevel;
			//return this._pressure;
		}
		
		public function addWater(quantity:Number):void
		{
				if(this._water <= this.height) 
				 this._water += quantity;

		}
		
		
		public function removeWater(quantity:Number):Number
		{
			if (quantity > this._water)
			{
				quantity = this._water;
				this._water = 0;
			}
			else
				this._water -= quantity;
				
			return quantity;
		}
		
		public function drawWater():void
		{
			if (this._water > 1)
			{
				waterSprite.makeGraphic(this.width, this._water, 0xFF66FFFF);
				//waterSprite.makeGraphic(this.width, this.getWaterLevel(), 0xFF66FFFF);
				//this.stamp(waterSprite, 0, this._water);	
				this.stamp(waterSprite,0, this.height - waterSprite.height);	
			}
		}
	}

}
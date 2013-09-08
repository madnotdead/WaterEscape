package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	import org.flixel.FlxSprite;
	import Room;
	
	/**
	 * ...
	 * @author mad
	 */
	public class Connector extends FlxSprite 
	{
		public var rRoom:Room;
		public var lRoom:Room;
		public var top:Number;
		public var bottom:Number;
		public var perm:Number;
		public const PERM_SCALE:Number = 10;
		public var type:Number;
		public var level:Number;
		public var connectorOpened:Boolean;
		protected var oFlow:Number;
		
		private const HTYPE:Number = 1;
		private const VTYPE:Number = 2;
		
		public function Connector(_x:Number, _y:Number, _lRoom:Room, _rRoom:Room, _top:Number, _bottom:Number, _width:Number, _perm:Number,_type:Number) 
		{		
			super(_x, _y);
			
			rRoom = _rRoom;
			lRoom = _lRoom;
			top = _top;
			bottom  = _bottom 
			width = _width;
			perm = _perm;
			height = bottom - top;
			
			level = y - height;
			
			type = _type;
			
			connectorOpened = false;
			makeGraphic(width, height, 0xFFFA1717);
		}
		
		public function min(a:Number, b:Number):Number
		{
			if (a < b)
				return a;
			else
				return b;
		}
		
		public function max(a:Number, b:Number):Number
		{
			if (a > b)
				return a;
			else
				return b;
		}
		
		override public function update():void 
		{
			/*if (type == HTYPE)
			{
				if (connectorOpened)
				{
					if (lRoom.getWaterLevel() >= level)
					{
						if (rRoom.getWaterLevel() < lRoom.getWaterLevel())
						{
							lRoom.removeWater(0.1);
							rRoom.addWater(0.1);
						}
					}
				}
			}
			
			if (type == VTYPE)
			{
				if (connectorOpened)
				{
					if (lRoom.getWaterLevel() > 0)
					{
						if (rRoom.getWaterLevel() < rRoom.height && lRoom.getWaterLevel() > 0.5 )
						{
							lRoom.removeWater(0.5);
							rRoom.addWater(0.5);
						}
					}
				}
			}*/
			
			if (type == HTYPE)
			{
				var cf1:Number = max(0, (this.bottom - this.lRoom.getWaterLevel() / this.height));
				var cf2:Number = max(0, (this.bottom - this.rRoom.getWaterLevel() / this.height));
				var cf:Number = min(1, max(cf1, cf2));
				
				var deltaP:Number = this.rRoom.getPressureLevel() - this.lRoom.getPressureLevel();
				
				
				var flow:Number = deltaP * cf * this.perm * this.PERM_SCALE * 1;
				
				if (flow > 0)
				{
					//flow *= -1;
					flow  = this.lRoom.removeWater(flow);
					//flow *= -1;
					this.rRoom.addWater(flow);
					
					while (flow != 0 && (this.lRoom.getPressureLevel() < this.rRoom.getPressureLevel()))
					{
						flow *= 0.5;
						this.lRoom.removeWater(flow);
						this.rRoom.addWater(flow);
					}
				}
				else
				{
					flow *= -1;
					flow = this.lRoom.removeWater(flow);
					this.rRoom.addWater(flow);
					
					while (flow != 0 && (this.rRoom.getPressureLevel() < this.lRoom.getPressureLevel()))
					{
						flow *= 0.5;
						this.rRoom.removeWater(flow);
						this.lRoom.addWater(flow);
					}
				}
			}
			trace("flow: " + flow);
			super.update();
		}
		
	}

}
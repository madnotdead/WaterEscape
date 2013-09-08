
package  
{
	import org.flixel.FlxState;
	import org.flixel.FlxGame;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author mad
	 */
	public class PlayState2 extends FlxState 
	{
		private var room:Room;
		private var room2:Room;
		private var room3:Room;
		private var connH:Connector;
		private var connV:Connector;
		private var conns:Vector.<Connector> = new Vector.<Connector>();
		private var water:Number = 0;
		private var text:FlxText;
		
		public function PlayState2() 
		{     
			//x,y,l,t,r,b,w
			room = new Room(10, 10, 10, 10, 100, 100, 0,0);
			room2 = new Room(110, 10, 110, 10, 250, 100, 0,0);
			room3 = new Room(10, 110, 10, 200, FlxG.width - 10, 300, 0,0); 		
			
			connH = new Connector(room._rigth, 50, room, room2, 10, 20, 10, 0.1,1);
			connV = new Connector(room2._left + 10, room2._bottom, room2, room3, room2._bottom, room2._bottom + 10, 20, 0.2, 2);
			
			text = new FlxText(10, FlxG.height - 20, FlxG.width, "Use A to open Hconnectors / S to open Vconnectors / D to close them.");
			
			conns.push(connH);
			conns.push(connV);
			
			add(room);
			add(room2);
			add(room3);                        
			add(connH);
			add(connV);
			add(text);
		}
		
		override public function update():void 
		{
			room.addWater(0.1);
			super.update();
			
			if (FlxG.keys.A)
			{
/*				for each (var itemToOpen:Connector in conns) 
				{
					itemToOpen.connectorOpened = true;
					itemToOpen.color = 0x40FF00;
				}*/
				
				connH.connectorOpened = true;
			}
				
			if (FlxG.keys.S)
			{
/*				for each (var itemToOpen:Connector in conns) 
				{
					itemToOpen.connectorOpened = true;
					itemToOpen.color = 0x40FF00;
				}*/
				
				connV.connectorOpened = true;
			}
			
			if (FlxG.keys.D)
			{
/*				for each (var itemTOclose:Connector in conns) 
				{
					itemTOclose.connectorOpened = false;
					itemTOclose.color = 0xB40431;
				}*/
			}
			
			trace("room 1- waterLevel: " + room.getWaterLevel());
		}		
	}

}
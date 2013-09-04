package  
{
	import org.flixel.*;
	import org.flixel.system.FlxTile;
	
	public class PlayState extends FlxState
	{
		private var player:Player;
		private var floor:FlxTileblock;
		private var platform:FlxTileblock;
		private var platform2:FlxTileblock;
		private var platform3:FlxTileblock;
		private var platform4:FlxTileblock;
		private var leftWall:FlxTileblock;
		private var rigthWall:FlxTileblock;
		private var top:FlxTileblock;
		private var middleWall:FlxTileblock;
		private var water:Water;
		private var water2:Water;
		private var water3:Water;
		private var hasOverlap:Boolean;
		private var cGroup:FlxGroup;
		private var oGroup:FlxGroup;
		private var room:Room;
		//private var wGroup:FlxGroup;
		
		public function PlayState() 
		{
			hasOverlap = false;
			cGroup = new FlxGroup();
			oGroup = new FlxGroup();
			//wGroup = new FlxGroup();
		}
		
		
		override public function create():void
		{
			FlxG.bgColor = 0xff144954;
			
			player = new Player(16, 210);
			
			
			//{ platforms
			
			platform = new FlxTileblock(16, 180, 128, 16);
			platform.makeGraphic(128, 16, 0xff689c16);
			
			platform2 = new FlxTileblock(16, FlxG.height / 2 + 16, 32, 16 );
			platform2.makeGraphic(50, 16, 0xff689c16);
			
			platform3 = new FlxTileblock(64, 100, 50, 16);
			platform3.makeGraphic(50, 16, 0xff689c16);
			
			//}
			
			//{ water
			
			
			
			water = new Water(16, FlxG.height - 16, FlxG.width / 2 - 16, FlxG.height - 32,-800);
			water2 = new Water(FlxG.width / 2 + 16, FlxG.height - 16, FlxG.width / 2 - 32, FlxG.height - 32, -800);
			water3 = new Water(FlxG.width / 2, FlxG.height/2, 16, FlxG.height / 2 - 16, -800);
			
			water.maxLevel = FlxG.height - 16;
			water.conectorLevel =  FlxG.height / 2;
			water2.maxLevel = FlxG.height - 16;
			water3.maxLevel = FlxG.height - 16;
			//}			

			//{ walls
				
			floor = new FlxTileblock(0, FlxG.height - 16, FlxG.width, 16);
			floor.makeGraphic(FlxG.width, 16, 0xff689c16);
			
			leftWall = new FlxTileblock(0, 0, 16, FlxG.height);
			leftWall.makeGraphic(16, FlxG.height, 0xff689c16);
			
			rigthWall = new FlxTileblock(FlxG.width - 16, 0, 16, FlxG.height);
			rigthWall.makeGraphic(16, FlxG.height, 0xff689c16);
			
			top = new FlxTileblock(16, 0, FlxG.width -32, 16);
			top.makeGraphic(FlxG.width - 32, 16, 0xff689c16);
			
			middleWall = new FlxTileblock(FlxG.width / 2, FlxG.height / 2, 16, FlxG.height / 2 - 16);
			middleWall.makeGraphic(16, FlxG.height / 2 - 16, 0xff689c16);
				
			room = new Room(16, 16, 16, 16, 48, 48, -10);
			room.drawWater();
			//}
			
			//{ add to world
			

			
			add(water);
			add(water2);
			add(water3);
			add(player);
			add(floor);
			add(platform);
            add(leftWall);
			add(rigthWall);
			add(top);
			add(middleWall);
			add(platform2);
			add(platform3);
			
			add(room);
			//}

			
			oGroup.add(water);
			oGroup.add(water2);
			oGroup.add(water3);
			cGroup.add(floor);
			cGroup.add(platform);
			cGroup.add(platform2);
			cGroup.add(platform3);
			cGroup.add(leftWall);
			cGroup.add(rigthWall);
			cGroup.add(top);
			cGroup.add(middleWall);

			

			//	These are debugger watches. Bring up the debug console (the ' key by default) and you'll see their values in real-time as you play
			FlxG.watch(player.acceleration, "x", "ax");
			FlxG.watch(player.velocity, "x", "vx");
			FlxG.watch(player.velocity, "y", "vy");
		}
		
		override public function update():void
		{
			super.update();
			
			FlxG.collide(player, cGroup);
			FlxG.collide(oGroup, top);
			
			if (water.y > water.conectorLevel)// && water2.y < water.conectorLevel)
				water2.acceleration.y = 0;
			else
			{
				water2.acceleration.y = -800;
				water.acceleration.y = 0;
			}
				
			
			if (water2.y <= water3.y)
			{
				water3.acceleration.y = water.acceleration.y = water2.acceleration.y;
				//water.acceleration.y = water2.acceleration.y;
			}
			else
				water3.acceleration.y = 0;
			
			hasOverlap = FlxG.overlap(player, oGroup);		
			
			if (hasOverlap)// && isUnderWater())
			{
				//if (isUnderWater())
				//{
					if (FlxG.keys.pressed("SPACE") )
						player.velocity.y = -50;
					else
						player.velocity.y = 50;
				//}

			}
			else
				player.velocity.y = 150;
			
		}
		
		public function isUnderWater():Boolean
		{
			for (var i:int = 0; i < oGroup.members.length - 1; i++) 
			{
				if (FlxG.overlap(oGroup.members[i]) && oGroup.members[i].y < player.y)
					return true;
			}
			
			return false;
		}
		
	}

}
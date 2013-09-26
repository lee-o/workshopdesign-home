package site.player 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class PlayerEvent extends Event 
	{
		public static const READY_TO_PLAY:String = "ready_to_play";
		
		public static const STOP:String = "stop";
		
		public static const APPARU:String = "apparu";
		
		public static const DISPARU:String = "disparu";
		
		public function PlayerEvent(type:String) 
		{ 
			
			super(type);
			
		} 
		
		public override function clone():Event 
		{ 
			return new PlayerEvent(type);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("PlayerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}
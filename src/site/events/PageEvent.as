package site.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class PageEvent extends Event 
	{
		public static const READY_TO_PLAY:String = "ready_to_play";
		
		public static const STOP:String = "stop";
		
		public static const APPARU:String = "apparu";
		
		public static const DISPARU:String = "disparu";
		
		public static const CLEAR:String = "clear";
		
		public function PageEvent(type:String) 
		{ 
			
			super(type);
			
		} 
		
		public override function clone():Event 
		{ 
			return new PageEvent(type);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("PageEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}
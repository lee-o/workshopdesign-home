package site.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class FluxEvent extends Event 
	{
		public static const READY_TO_PLAY:String = "ready_to_play";
		
		public function FluxEvent(type:String,bubbles:Boolean = false, cancelable:Boolean = false) 
		{ 
			
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new FluxEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("FluxEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}
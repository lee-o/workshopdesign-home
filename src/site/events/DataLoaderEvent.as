package site.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class DataLoaderEvent extends Event 
	{
		public static const READY:String = "ready";
		
		public function DataLoaderEvent(type:String) 
		{ 
			
			super(type);
			
		} 
		
		public override function clone():Event 
		{ 
			return new DataLoaderEvent(type);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("DataLoaderEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}
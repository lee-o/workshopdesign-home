package com.shic.utils 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author David
	 */
	public class CacheEvent extends Event 
	{
				
		public static const LOADED_COMPLETE:String = "loadedComplete";
		
		public function CacheEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new CacheEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("CacheEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}
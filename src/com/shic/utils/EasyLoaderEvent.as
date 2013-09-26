package com.shic.utils
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class EasyLoaderEvent extends Event 
	{
		public static const ERROR:String = "error";
		
		public function EasyLoaderEvent(type:String) 
		{ 
			
			super(type);
			
		} 
		
		public override function clone():Event 
		{ 
			return new EasyLoaderEvent(type);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("EasyLoaderEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}
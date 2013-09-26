package com.shic.utils 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author shic
	 */
	public class VolumeEvent extends Event 
	{
		public static const CHANGE:String = "change";
		private var _volume:Number;
		
		public function VolumeEvent(type:String, p_volume:Number) 
		{ 
			//trace("change volume "+p_volume);
			_volume = p_volume;
			super(type);
			
		} 
		
		public override function clone():Event 
		{ 
			return new VolumeEvent(type, _volume);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("VolumeEvent", "type", "volume"); 
		}
		
		public function get volume():Number { return _volume; }
		
	}
	
}
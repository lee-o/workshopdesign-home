package com.shic.utils 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author shic
	 */
	public class EasyXmlEvent extends Event 
	{
		public static const COMPLETE:String = "complete";
		public static const ERROR:String = "error";
		private var _xml:XML;
		
		public function EasyXmlEvent(type:String, p_xml:XML) 
		{ 
			_xml = p_xml;
			super(type);
			
		} 
		
		/*public override function clone():Event 
		{ 
			return new EasyXmlEvent(type, bubbles, cancelable);
		} */
		
		public override function toString():String 
		{ 
			return formatToString("EasyXmlEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get xml():XML { return _xml; }
		
	}
	
}
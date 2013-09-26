package com.shic.utils 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * Cette classe permet d'enregistrer de manière global un propriété volume comprise entre 0 et 1, destinée à être utilisée pour gérer les volume sonore sur toute l'annimation.
	 * @author shic
	 */
	public class Volume extends EventDispatcher
	{
		
		private var _volume:Number = 1;
		private static var instance:Volume = new Volume(); 
		
		public function Volume(monObjetQuiADuSon:*=null) {
			
		}
		static public function addEventListener(event:String,fonction:Function):void {
			return instance.addEventListener(event, fonction);
		}
		static public function removeEventListener(event:String,fonction:Function):void {
			return instance.removeEventListener(event, fonction);
		}
		public function get() : Number {
			return _volume;
		}
		public function set( v:Number) : Number {
			_volume = v;
			if (_volume > 1) {
				_volume = 1;
			}else if (_volume < 0) {
				_volume = 0;
			}
			
			dispatchEvent(new VolumeEvent(VolumeEvent.CHANGE,_volume));
		}
		static public function get global ():Number { return instance.get(); }	
		static public function set global (value:Number):void 
		{
			instance.set( value );
			
		}
		[Event(name = "change", type = "com.shic.utils.VolumeEvent")]
		
	}

}
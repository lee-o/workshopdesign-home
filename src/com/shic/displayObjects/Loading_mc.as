package com.shic.displayObjects
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	[Embed(source='bibliotheque.swf', symbol='loading_mc')]
	/**
	 * Un objet loading_mc représente un graphique rond dégradé qui tourne à une cadence de 20 degrés pas image.
	 * @author shic
	 */
	public class Loading_mc extends Sprite
	{
		//symbole qui tourne
		public var rond_mc : Sprite;
		
		private var __visible:Boolean = true; 
		
		public function Loading_mc() 
		{
			super();
			_visible = true;
		}
		
		/**
		 * la propriété _visible quand elle est true met la propriété visible sur true et fait tourner le loading, dans le cas contraire, le loading ne tourne plus et met la propriété visible sur false.
		 */
		public function get _visible():Boolean { return _visible; }
		public function set _visible(value:Boolean):void 
		{
			__visible = value;
			visible = __visible;
			this.removeEventListener(Event.ENTER_FRAME, tourne);
			if (visible) {	
				this.addEventListener(Event.ENTER_FRAME, tourne);
			}else {
				this.alpha = 0;
			}
		}
		
		private function tourne(e:Event):void 
		{
			rond_mc.rotation += 20;
			if (!visible) {
				_visible = false;
			}
			if (alpha<1) {
				alpha += 0.1;
			}else {
				alpha = 1;
			}
		}
		
	}

}
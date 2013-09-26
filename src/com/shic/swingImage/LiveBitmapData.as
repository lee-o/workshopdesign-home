package com.shic.swingImage 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author david m
	 */
	public class LiveBitmapData extends BitmapData
	{
		private var _source:DisplayObject;
		private var _rectangle:Rectangle;
		private var _obj:Sprite = new Sprite();
		private var matrix:Matrix;
		
		/**
		 * Retourne un BitmapData qui est la représentation de source dans la zone définie par rectangle.
		 * Le bitmapData ainsi obtenu est mis à jour automatiquement sur Event.ENTER_FRAME, il est donc très couteux en ressources machine du fait qu'il dessine en temps réel le displayObject source.
		 * @param	source le display object à dessiner
		 * @param	rectangle la zone de dessin
		 * @param	transparent
		 * @param	color
		 */
		public function LiveBitmapData(source:DisplayObject,rectangle:Rectangle,transparent:Boolean=true,color:uint=0x00ff00) 
		{
			super(rectangle.width, rectangle.height, transparent, color);
			_rectangle = rectangle;
			matrix = new Matrix(1, 0, 0, 1, -_rectangle.x, -_rectangle.y);
			_source = source;
			refresh();
			_obj.addEventListener(Event.ENTER_FRAME, loop);
		}
		/**
		 * 
		 * @param	e
		 */
		private function loop(e:Event) :void{
			refresh();
		}
		/**
		 * met immédiatement à jour le bitmapData
		 */
		public function refresh():void {
			this.draw(_source, matrix);
		}
		/**
		 * le display object qui est déssiné
		 */
		public function set source(source:DisplayObject):void {
			_source = source;
		}
		public function get source():DisplayObject {
			return source;
		}
		/**
		 * l'espace de coordonnée du display object qui est déssiné
		 */
		public function set rectangle(rectangle:Rectangle):void {
			_rectangle = rectangle;
			matrix = new Matrix(1, 0, 0, 1, -_rectangle.x, -_rectangle.y);
			trace("refresh rectangle matrix");
			refresh();
		}
		public function get rectangle():Rectangle {
			return _rectangle;
		}
		
	}

}
package cc.shic.display
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author david m
	 */
	public class Square extends Sprite
	{
		public var optionnalParameters:Object = new Object();
		
		private var _bitmapFillUrl:String;
		private var loader:EasyLoader;
		private var _bmpdFill:BitmapData;
		
		private var _width:Number=100;
		private var _height:Number = 100;
		
		private var _alphaFill:Number=1;
		private var _color:uint = 0xff0000;
		
		/**
		 retourne un carré rouge de 100 / 100 pixels
		 */
		public function Square(width:Number=100,height:Number=100,color:uint=0x00ff00,alphaFill:Number=1) 
		{
			this.width = width;
			this.height = height;
			this.alphaFill = alphaFill;
			this.color = color;

		}
		/**
		 * url d'une image permettant de remplir l'objet avec une trame
		 */
		public function get bitmapFillUrl():String { return _bitmapFillUrl; }
		public function set bitmapFillUrl(value:String):void 
		{
			_bitmapFillUrl = value;
			loader = new EasyLoader(_bitmapFillUrl);
			loader.addEventListener(Event.COMPLETE, setBitmap);
		}
		
		public override function get width():Number { return _width; }
		public override function set width(value:Number):void 
		{
			_width = value;
			build();
		}
		
		public override function get height():Number { return _height; }
		public override function set height(value:Number):void 
		{
			_height = value;
			build();
		}
		/**
		 * valeur de 0 à 1 utilisée pour définir l'alpha de remplissage
		 */
		public function get alphaFill():Number { return _alphaFill; }
		public function set alphaFill(value:Number):void 
		{
			_alphaFill = value;
			build();
		}
		/**
		 * bitmap data de remplissage
		 */
		public function get bmpdFill():BitmapData { return _bmpdFill; }
		public function set bmpdFill(value:BitmapData):void 
		{
			_bmpdFill = value;
			build();
		}
		
		public function get color():uint { return _color; }
		public function set color(value:uint):void 
		{
			_color = value;
			build();
		}
		/**
		 * applique le bitmap en remplissage
		 * @param	e
		 */
		private function setBitmap(e:Event):void 
		{
			if (loader) {
				bmpdFill = new BitmapData(loader.width, loader.height);
				bmpdFill.draw(loader);
				build();
			}
		}
		/**
		 * cree la forme
		 */
		private function build():void
		{
			this.graphics.clear();
			if (bmpdFill) {
				this.graphics.beginBitmapFill(bmpdFill, null, true, false);
			}else {
				this.graphics.beginFill(color, alphaFill);
			}
			this.graphics.drawRect(0, 0, width, height);
		}
		
	}

}
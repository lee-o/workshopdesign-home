package site.gfx 
{
	import com.shic.displayObjects.Square2;
	import com.shic.displayObjects.TextFieldMonoLine;
	import MainWorkshopDesign;
	import site.navigation.DataLoader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author lee-o
	 */
	public class invCartoucheTitre extends Sprite
	{
		private var largeur:Number;
		private var hauteur:Number;
		private var color:Number;
		private var begin:Boolean;
		private var end:Boolean;
		private var conteneur:Sprite;
		public var corp:Square2;
		private var decalageTri:uint;
		public var posX:int;
		
		public function invCartoucheTitre(_largeur:Number,_hauteur:Number,_decalageTri:uint,_color:Number,_begin:Boolean = false,_end:Boolean = false) 
		{
			largeur = _largeur;
			hauteur = _hauteur;
			color = _color;
			begin = _begin;
			end = _end;
			decalageTri = _decalageTri;
			//
			init();
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			conteneur = new Sprite();
			corp = new Square2(largeur, hauteur, color, 1);
			conteneur.addChild(makeBeginTri(0, 0, decalageTri, hauteur));
			//
			conteneur.addChild(corp);
			addChild(conteneur);
		}
		
		private function makeBeginTri(_x:uint,_y:uint,_w:uint, _h:uint):Shape
		{
			var tri:Shape = new Shape();
			tri.graphics.beginFill(color, 1);
			tri.graphics.moveTo(_x, _y);	
			tri.graphics.lineTo(_x - _w, _h);
			tri.graphics.lineTo(_x, _h);
			tri.graphics.endFill();
			return tri;
		}
	}

}
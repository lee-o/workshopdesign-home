package site.gfx 
{
	import com.greensock.TweenMax;
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
	public class cartoucheTitre extends Sprite
	{
		private var titre:String;
		private var style:String;
		private var textColor:Number;
		private var color:Number;
		private var begin:Boolean;
		private var end:Boolean;
		public var type:String;
		public var id:String;
		private var decalageTri:uint;
		public var posX:int;
		public var number:int;
		private var titre_txt:TextFieldMonoLine;
		private var beginTri:Shape;
		private var endTri:Shape;
		private var cartoucheConteneur:Sprite;
		private var cartouche:Square2;
		private var cartoucheWidth:int;
		public var selected:Boolean = false;
		
		public function cartoucheTitre(_titre:String,_style:String,_textColor:Number,_color:Number,_decalageTri:uint,_begin:Boolean = false,_end:Boolean = false,_type:String = null) 
		{
			titre = _titre;
			style = _style;
			textColor = _textColor;
			color = _color;
			begin = _begin;
			end = _end;
			//id = _id;
			type = _type;
			decalageTri = _decalageTri;
			//
			init();
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			titre_txt = new TextFieldMonoLine(titre);
			titre_txt.name = "titre_txt";
			DataLoader.xmlStyleLoader.appliqueFormat(titre_txt, style);
			titre_txt.textColor = textColor;
			titre_txt.x = 6;
			titre_txt.y = 4;
			//
			cartoucheConteneur = new Sprite();
			cartouche = new Square2(uint(titre_txt.width + 12), uint(titre_txt.height + 7), color, 1);
			cartoucheWidth = cartouche.width;
			cartoucheConteneur.addChild(cartouche);
			//
			if (begin) {
				cartoucheConteneur.addChild(makeBeginTri(0, 0, decalageTri, uint(titre_txt.height + 7)));
			}
			if(end){
				cartoucheConteneur.addChild(makeEndTri(uint(titre_txt.width + 12), 0, decalageTri, uint(titre_txt.height + 7)));
			}
			//
			addChild(cartoucheConteneur);
			addChild(titre_txt);
		}
		
		private function makeBeginTri(_x:uint,_y:uint,_w:uint, _h:uint):Shape
		{
			beginTri = new Shape();
			beginTri.graphics.beginFill(color, 1);
			beginTri.graphics.moveTo(_x, _y);	
			beginTri.graphics.lineTo(_x - _w, _h);
			beginTri.graphics.lineTo(_x, _h);
			beginTri.graphics.endFill();
			return beginTri;
		}
		
		private function makeEndTri(_x:uint,_y:uint,_w:uint, _h:uint):Shape
		{
			endTri = new Shape();
			endTri.graphics.beginFill(color, 1);
			endTri.graphics.moveTo(_x, _y);	
			endTri.graphics.lineTo(_x + _w, _y);
			endTri.graphics.lineTo(_x, _h);
			endTri.graphics.endFill();
			return endTri;
		}
		
		public function dilate(t:Number,d:int):void
		{
			if (end)
			{
				TweenMax.killTweensOf(endTri);
				TweenMax.to(endTri, t, { x:d } );
				//
				TweenMax.killTweensOf(cartouche);
				TweenMax.to(cartouche, t, { width:cartoucheWidth + d } );
				//
				TweenMax.killTweensOf(titre_txt);
				TweenMax.to(titre_txt, t, { x:((cartoucheWidth + d) - titre_txt.width)/2} );
			}
		}
		
		public function retracte(t:Number,d:int):void
		{
			if (end)
			{
				TweenMax.killTweensOf(endTri);
				TweenMax.to(endTri, t, { x:0 } );
				//
				TweenMax.killTweensOf(cartouche);
				TweenMax.to(cartouche, t, { width:cartoucheWidth } );
				//
				TweenMax.killTweensOf(titre_txt);
				TweenMax.to(titre_txt, t, { x:6} );
			}
		}
	}

}
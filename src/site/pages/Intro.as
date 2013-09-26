package site.pages 
{
	import com.greensock.easing.Quad;
	import com.greensock.easing.Sine;
	import com.greensock.TweenMax;
	import com.shic.displayObjects.Square;
	import com.shic.utils.Utils;
	import flash.display.Shape;
	import site.fx.Shifter;
	import MainWorkshopDesign;
	import site.gfx.LogoWsdLarge;
	import site.navigation.DataLoader;
	import site.navigation.Navigation;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.DisplacementMapFilterMode;
	import flash.geom.Point;
	/**
	 * ...
	 * @author lee-o
	 */
	public class Intro extends Sprite
	{
		public var logo_mc:LogoWsdLarge;
		//
		private var deplacementX:Number;
		private var deplacementY:Number;
		//
		private var compteurTemp:int = 0;
		private var dureeTempo:int = 180;
		//
		private var progress:Object;
		//
		private var nbrDupli:uint = 5;
		//
		public var conteneurDupli:Sprite = new Sprite();
		public var conteneurShifter:Sprite = new Sprite();
		//
		public var fondColor:Square;
		//
		public var shifter:Shifter;
		
		public function Intro() 
		{
			//
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
			
		}
		
		private function init(e:Event = null):void {
			Navigation.setLoading(false);
			//
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, removeFromStage);
			//
			logo_mc = new LogoWsdLarge();
			//
			fondColor = new Square(stage.stageWidth, stage.stageHeight, 0x000000, 1);
			addChild(fondColor);
			fondColor.alpha = 0;
			TweenMax.to(fondColor, DataLoader.tempsApparition * 2, { autoAlpha:1,onComplete:duplik} );
			TweenMax.to(fondColor, DataLoader.tempsApparition*2, {delay:DataLoader.tempsApparition*2,autoAlpha:0} );
			//
			
		}
		
		private function clear():void
		{
			parent.removeChild(this);
			//Navigation.initHome();
		}
		
		private function duplik():void {
			addChild(conteneurDupli);
			conteneurDupli.alpha = 0;
			//
			addChild(conteneurShifter);
			//
			shifter = new Shifter(MainWorkshopDesign.root,MainWorkshopDesign.root);
			addEventListener(Event.ENTER_FRAME, shifter.playShift);
			
			//
			resize();
			//
			for (var u:uint = 0; u < nbrDupli;u++){
				var logo_bmpd:BitmapData = new BitmapData(logo_mc.width, logo_mc.height, true, 0x006699);
				logo_bmpd.draw(logo_mc);
				var logo_bmp:Bitmap = new Bitmap(logo_bmpd, "auto", true);
				conteneurDupli.addChild(logo_bmp);
				distort(logo_bmp);
			}
			TweenMax.to(conteneurDupli, DataLoader.tempsApparition * 2, { autoAlpha:1 } ); 
			TweenMax.to(fondColor, DataLoader.tempsApparition*2, {autoAlpha:0} ); 
		}
		
		private function distort(img:Bitmap):void {
			var X:int = Utils.randRange( - 8,  8);
			var Y:int = Utils.randRange( - 8,  8);
			var A:Number = Utils.randRange(80, 100) / 100;
			var T:Number = Utils.randRange(1, 5 ) / 10;
			TweenMax.to(img,T, {ease:Sine.easeInOut ,x: X, y: Y,alpha: A,onComplete:distort, onCompleteParams:[img] } );
		}
		
		public function resize(e:Event = null):void
		{
			conteneurDupli.x = stage.stageWidth / 2 - logo_mc.width / 2;
			conteneurDupli.y = stage.stageHeight / 2 - logo_mc.height / 2;
			//
			//conteneurShifter.x = conteneurDupli.x;
			//conteneurShifter.y = conteneurDupli.y;
			//
			fondColor.width = stage.stageWidth;
			fondColor.height = stage.stageHeight;
		}
		
		private function removeFromStage(e:Event):void
		{
			TweenMax.killTweensOf(progress);
			TweenMax.killChildTweensOf(conteneurDupli);
			TweenMax.killTweensOf(logo_mc);
			//dispatchEvent(new PageEvent(PageEvent.CLEAR));
		}
		
	}

}
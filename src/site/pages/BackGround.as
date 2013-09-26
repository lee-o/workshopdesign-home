package site.pages 
{
	import com.greensock.easing.Quad;
	import com.greensock.TweenMax;
	import com.shic.utils.EasyLoader;
	import com.shic.utils.Utils;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import site.navigation.DataLoader;
	/**
	 * ...
	 * @author lee-o
	 */
	public class BackGround extends Sprite
	{
		[Event(name = "complete", type = "flash.events.Event")]
		//
		[Embed(source='trame.png')]
		public var Trame:Class;
		//
		private var xml:XML;
		private var pictureXML:XMLList;
		private var nombreImages:uint;
		private var imageEnCour:uint = 0;
		private var backGroundVector:Vector.<MovieClip> = new Vector.<MovieClip>();
		private var content:Sprite = new Sprite();
		private var temporisation:uint = 6;
		private var _pauseDiaporama:Boolean = false;
		private var zoomRatio:Number = 1.2;
		private var trame:Sprite = new Sprite();
		private var imgTrame:Bitmap;
		private var bmpTrame:BitmapData;
		//		
		public function BackGround(_xml:XML) 
		{
			xml = _xml;
			init();
		}
		
		private function init(e:Event = null):void 
		{
			pictureXML = xml.backdrop;
			nombreImages = pictureXML.picture.length();
			//
			addChild(content);
			addChild(trame);
			trame.blendMode = BlendMode.ADD;
			//
			loadBitmap();
			loadPicture();
		}
		
		private function loadPicture(i:uint = 0):void 
		{
			var image:EasyLoader = new EasyLoader(DataLoader.racine + pictureXML.picture[i], false, 0, false);
			image.addEventListener(Event.COMPLETE, pictureLoaded);
		}
		
		private function loadBitmap():void {
			imgTrame = new Trame();
			bmpTrame = imgTrame.bitmapData
		}
		
		private function rempliTrame(X:int, Y:int, W:Number, H:Number):void
		{
			trame.graphics.clear();
			trame.graphics.beginBitmapFill(bmpTrame, null, true, true);
			trame.graphics.moveTo(0, 0);
			trame.graphics.lineTo(0, H);
			trame.graphics.lineTo(W, H);
			trame.graphics.lineTo(W, 0);
			trame.graphics.lineTo(0, 0);
			trame.graphics.endFill();
		}

		private function pictureLoaded(e:Event):void 
		{
			//trace("pictureLoaded");
			e.target.removeEventListener(Event.COMPLETE, pictureLoaded);
			var bmpData:BitmapData = new BitmapData(e.target.width, e.target.height, false, 0x00000000);
			bmpData.draw(e.target as EasyLoader);
			var bmp:Bitmap = new Bitmap(bmpData, "auto", true); 
			var photo:MovieClip = new MovieClip();
			photo.visible = false;
			photo.alpha = 0;
			photo.addChild(bmp);
			bmp.x = -bmp.width/2;
			bmp.y = -bmp.height/2;
			content.addChild(photo);
			backGroundVector.push(photo);
			checkIfAllConstruct();
		}
		
		private function checkIfAllConstruct(e:Event = null):void
		{
			
			if (backGroundVector.length == nombreImages) {
				//
				backGroundVector[0].visible = true;
				backGroundVector[0].alpha = 1;
				backGroundVector[0].addEventListener(Event.ENTER_FRAME, zoom);
				//
				var timer:Timer = new Timer(temporisation * 1000, 0);
				timer.addEventListener(TimerEvent.TIMER, diaporama);
				timer.start();
				//
				resize();
				//
				dispatchEvent(new Event(Event.COMPLETE));
			}else {
				loadPicture(backGroundVector.length);
			}
		}
		
		private function diaporama(e:TimerEvent = null):void
		{
			if (!_pauseDiaporama) {
				TweenMax.killTweensOf(backGroundVector[imageEnCour]);
				backGroundVector[imageEnCour].removeEventListener(Event.ENTER_FRAME, zoom);
				content.addChild(backGroundVector[imageEnCour]);
				TweenMax.to(backGroundVector[imageEnCour], DataLoader.tempsApparition * 2, {autoAlpha:0 , blurFilter:{blurX:16,blurY:16,quality:1}} );
				imageEnCour ++ >= backGroundVector.length - 1 ? imageEnCour = 0 : imageEnCour = imageEnCour;
				backGroundVector[imageEnCour].width = backGroundVector[imageEnCour].W;
				backGroundVector[imageEnCour].height = backGroundVector[imageEnCour].H;
				backGroundVector[imageEnCour].filters = [new BlurFilter(0, 0, 0)];
				backGroundVector[imageEnCour].visible = true;
				backGroundVector[imageEnCour].alpha = 1;
				backGroundVector[imageEnCour].addEventListener(Event.ENTER_FRAME, zoom);
			}
		}
		
		private function zoom(e:Event):void{
			e.target.width += 1;
			e.target.scaleY = e.target.scaleX;
		}

		public function get pauseDiaporama ():Boolean {
			return _pauseDiaporama;
		}
		
		public function set pauseDiaporama (_bool:Boolean):void {
			_pauseDiaporama = _bool;
		}
		
		public function resize(e:Event = null):void
		{
			if (stage) {
				var Width:int = stage.stageWidth; 
				var Height:int = stage.stageHeight; 
				var nbrElements:uint = backGroundVector.length;
				scrollRect = new Rectangle(0, 0, Width, Height);
				//
				content.x = Width/2;
				content.y = Height/2;
				//
				rempliTrame(0,0,Width,Height);
				//
				for (var i:uint = 0; i < nbrElements; i++) {
					var temp:MovieClip = backGroundVector[i];
					if (temp) {
						temp.width = Width;
						temp.scaleY = temp.scaleX;
						if (temp.height < Height) {
							temp.height = Height;
							temp.scaleX = temp.scaleY;
						}
						temp.W = temp.width;
						temp.H = temp.height;
					}
						
				}
			}
		}
		
	}
}
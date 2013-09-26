package site.gfx 
{
	import com.greensock.TweenMax;
	import flash.display.BitmapDataChannel;
	import flash.display.Sprite;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author lee-o
	 */
	public class noisePattern extends Sprite
	{
		//NOISE
		private var conteneurImg:Sprite;
		private var _noisePattern_bmp:BitmapData;
		private var tempo:uint = 0;
		private var nbreImg:uint = 10;
		private var cadence:uint;
		private var afficheNum:uint = 0;
		private var dispatchFirst:Boolean = true;
		private var largeurPattern:uint;
		private var hauteurPattern:uint;
		//
		//
		/**
		 * cree un noise TV
		 * @param	_cadence	le nombre d image entre chaque remplacement d image dans l animation pre calculee
		 * @param	_nbreImg	le # d'ecran a copier en bmp pour l animation pre calculée
		 * 
		 */
		public function noisePattern(_largeur:uint,_hauteur:uint,_cadence:uint, _nbreImg:uint,color_1:uint,color_2:uint) 
		{
			visible = false;
			alpha = 0;
			//
			largeurPattern = _largeur;
			hauteurPattern = _hauteur;
			cadence = _cadence;
			nbreImg = _nbreImg;
			conteneurImg = new Sprite();
			//
			//NOISE
			for (var i:Number = 0; i < nbreImg; i++) {
				_noisePattern_bmp = new BitmapData(largeurPattern, hauteurPattern, false, 0xff000000);
				var _noisePattern_img:Bitmap = new Bitmap(_noisePattern_bmp,"auto",true);
				_noisePattern_img.name = "noise_" + i;
				var seed:int = int(Math.random() * int.MAX_VALUE);
				var channel:uint = BitmapDataChannel.RED;
				_noisePattern_bmp.noise(seed, color_1, color_2, channel, true);
				conteneurImg.addChild(_noisePattern_img);
			}
			//
			addEventListener(Event.ENTER_FRAME, neigeTv);
			addChild(conteneurImg);
		}
		
		[Event(name = "complete", type = "flash.events.Event")]		
		private function neigeTv(e:Event):void {
			if (dispatchFirst == true) {
				dispatchFirst = false;
				dispatchEvent(new Event(Event.COMPLETE));
			}
			//NOISE
			if(tempo ++ == cadence){
				tempo = 0;
				var tempNum:uint = afficheNum;
				afficheNum = uint(Math.random() * nbreImg);
				while (afficheNum == tempNum) {
					afficheNum = uint(Math.random() * nbreImg);
				}
				forVisible(afficheNum);
			}
		}
		
		private function forVisible(num:uint):void
		{
			for (var i:Number = 0; i < nbreImg; i++) {
				conteneurImg.getChildAt(i).visible = false;
			}
			conteneurImg.getChildAt(num).visible = true;
		}
		
		public function pause():void {
			removeEventListener(Event.ENTER_FRAME, neigeTv);
		}
		
		public function play():void {
			addEventListener(Event.ENTER_FRAME, neigeTv);
		}
		
		public function apparition(time:Number = 1,_delay:Number = 0, value:Number = 1):void
		{
			TweenMax.to(this, time, {delay:_delay, autoAlpha:value } );
		}
		
	}

}

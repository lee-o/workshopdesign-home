package site.gfx 
{
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
	public class perlinPattern extends Sprite
	{
		//NOISE
		private var _noisePattern_bmp:BitmapData;
		private var _noisePattern_img:Bitmap;
		private var tempo:uint = 0;
		//
		//PERLIN NOISE
		private var _perlinPattern_bmp:BitmapData;
		private var seed:Number;
		private var channels:uint;
		private var nuage_img:Bitmap;
		private var pt1:Point = new Point(0,0);
		private var pt2:Point = new Point(0,0);
		private var perlinDeplacement:Array = [pt1, pt2];
		private var nbrBmp:uint = 0;
		//
		//
		public function perlinPattern() 
		{
			alpha = 0.5;
			//NOISE
			_noisePattern_bmp = new BitmapData(1200, 1200,false, 0xff000000);
			_noisePattern_img = new Bitmap(_noisePattern_bmp);
			_noisePattern_bmp.noise(Math.random() * 100, 220, 255, 7, true);
			addChild(_noisePattern_img);
			//addEventListener(Event.ENTER_FRAME,neigeTv);
			//
			//PERLIN NOISE
			/*_perlinPattern_bmp = new BitmapData(200, 200, false, 0xff000000);
			seed = Math.floor(Math.random() * 1000);
			channels = BitmapDataChannel.GREEN | BitmapDataChannel.BLUE ;
			_perlinPattern_bmp.perlinNoise(50, 50, 4, seed, false, true, channels, true, perlinDeplacement);
			nuage_img = new Bitmap(_perlinPattern_bmp);
			addChild(nuage_img);
			addEventListener(Event.ENTER_FRAME,perlinNuage);*/
		}
		
		private function neigeTv(e:Event):void {
			//NOISE
			tempo ++;
			if(tempo == 2){
				_noisePattern_bmp.noise(Math.random() * 100, 220, 255, 7, true);
				tempo = 0;
			}
		}
		
		private function perlinNuage(e:Event):void {
			//PERLIN NOISE
			perlinDeplacement[0].x = calculCourbe("sin",0.01,tempo ++);
			perlinDeplacement[1].y = calculCourbe("cos", 0.005, tempo ++);
			_perlinPattern_bmp.perlinNoise(50, 50, 4, seed, false, true, channels, true, perlinDeplacement);
		}
		
		private function calculCourbe(type:String,mult:Number, value:Number):Number {
			var tx:Number;
			if (type == "sin")
			{
				tx = 100 * Math.sin(mult * value);
			}else if (type == "cos")
			{
				tx = 100 * Math.cos(mult * value);
			}
			//trace(Math.floor(Math.abs(tx)));
			return Math.round(tx);
		}
		
	}

}




/*
seed = Math.floor(Math.random() * 1000);
channels:uint = BitmapDataChannel.GREEN | BitmapDataChannel.BLUE ;
myBitmapDataObject.perlinNoise(100, 80, 6, seed, false, true, channels, false, null);
var clouds:Bitmap = new Bitmap(myBitmapDataObject);
addChild(clouds);*/

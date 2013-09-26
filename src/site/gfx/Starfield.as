package site.gfx {
	
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.geom.Point;
	import flash.events.Event;
	
	public class Starfield extends Sprite {
		
		public var w:Number;
		public var h:Number;
		public var count:uint;
		public var minSize:Number;
		public var maxSize:Number;
		public var holder:Sprite;
		public var bdSize:uint;
		public var speedX:Number;
		public var speedY:Number;
		public var perlinNoiseSize:Number;
		public var _debug:Boolean;
		private var bd:BitmapData;
		private var bmp:Bitmap;
		private var offs:Array=[new Point(0,0), new Point(0,0)];
		
		public function Starfield(pw:Number, ph:Number, pcount:uint, pminSize:Number=1, pmaxSize:Number=2, pperlinNoiseSize:Number=5, pspeedX:Number=.1, pspeedY:Number=.05, pbdSize:uint=30) {
			holder=new Sprite();
			
			w=pw;
			h=ph;
			count=pcount;
			minSize=pminSize;
			maxSize=pmaxSize;
			bdSize=pbdSize;
			speedX=pspeedX;
			speedY=pspeedY;
			perlinNoiseSize=pperlinNoiseSize;
			
			bd=new BitmapData(30, 30, false);
			bmp=new Bitmap(bd);
			bmp.blendMode=BlendMode.SCREEN;
			addChild(bmp);
			generateField();
			startTwinkle()
			addChild(holder);
			bmp.mask=holder;
			bmp.width=w;
			bmp.height=h;
		}
		
		public function generateField():void {
			for(var i:uint=0; i<count; i++) {
				addStar();
			}
		}
		
		public function addStar():void {
			holder.graphics.beginFill(0xff0000);
			holder.graphics.drawCircle(Math.random()*w, Math.random()*h, Math.random()*(maxSize-minSize)+minSize);
			holder.graphics.endFill();
		}
		public function startTwinkle():void {
			addEventListener(Event.ENTER_FRAME, onframe);
		}
		public function stopTwinkle():void {
			removeEventListener(Event.ENTER_FRAME, onframe);
		}
		private function onframe(event:Event):void {
			twinkle();
		}
		public function twinkle():void {
			offs[1].x+=speedX;
			offs[1].y+=speedY;
			bd.perlinNoise(perlinNoiseSize,perlinNoiseSize,2,10,false,true,7,true,offs);
		}
		public function set debug(arg:Boolean):void {
			arg ? bmp.mask=null : bmp.mask=holder;
			_debug=arg;
		}
		public function get debug():Boolean {
			return _debug
		}
		
	}
	
	
	
}
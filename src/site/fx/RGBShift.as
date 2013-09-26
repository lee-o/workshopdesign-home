package site.fx 
{
	
	import com.greensock.TweenMax
	import com.greensock.easing.Sine;
	import com.shic.utils.Utils;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.BitmapDataChannel;
	import flash.display.BlendMode;
	import flash.events.Event;
	import flash.filters.BitmapFilter;
	import flash.filters.DisplacementMapFilter;	
	import flash.filters.DisplacementMapFilterMode;
	import flash.geom.Point;
	
	public class RGBShift extends Sprite {
		
		private var _centerX:Number;
		private var _centerY:Number;
		private var _counter:uint = 0;
		private var _repeat:uint;
		private var _countClear:uint = 0;
		private var rgbBMD:Array;
		private var _nbrChanel:uint = 3;
		//private var dObj:BitmapData;
		private var dObj:Sprite;
		
		// CONSTRUCTOR
		public function RGBShift(_dObj:Sprite, repeat:Number = 0) {
			
			dObj = _dObj;
			_repeat = repeat;
			//
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
			
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, clear);
			rgbBMD = createRGB(dObj);
	        _nbrChanel = rgbBMD.length;
			//
			for (var i:int=0; i<_nbrChanel; i++) {
	            var bmp:Bitmap = new Bitmap(rgbBMD[i]);
				bmp.smoothing = true;
				
				if(i>0) {
					// set SCREEN blend mode for the 2nd and 3rd images
	            	bmp.blendMode = BlendMode.SCREEN;
				}	
				var container:Sprite = new Sprite(); // container sprite 
				container.addChild(bmp); // add the Bitmap to the Sprite's display list
				
				// find the center
				_centerX = bmp.width/2;
				_centerY = bmp.height/2;
				
				// center the image
				bmp.x = 0-_centerX;
				bmp.y =	0-_centerY;

				container.x = _centerX;
				container.y = _centerY;
				
				addChild(container); // add the Sprite to the display list
				//container.filters = [deform(container)];
				distort(container);  // start the bitmap distortion
	        }
		}
		
		//-----------------------------------------------------------------------------
		
		private function distort(img:Sprite):void {
			var X:int = Utils.randRange(_centerX - 6, _centerX + 6);
			var Y:int = Utils.randRange(_centerY - 3, _centerY + 3);
			var A:Number = Utils.randRange(80, 100) / 100;
			var T:Number = Utils.randRange(1, 2 ) / 10;
			//
			if (_counter <= _repeat) {
				TweenMax.to(img,T, {ease:Sine.easeInOut ,x: X, y: Y,alpha: A,onComplete:distort, onCompleteParams:[img] } );
			}else {
				TweenMax.to(img,T, {ease:Sine.easeInOut ,x: X, y: Y,alpha: 0,onComplete:dispatchComplete} );
			}
			_counter++;
		}
		
		[Event(name = "complete", type = "flash.events.Event")]
		
		private function clear(e:Event):void
		{
			TweenMax.killChildTweensOf(this);
			dispatchEvent(new Event(Event.COMPLETE));
			removeEventListener(Event.REMOVED_FROM_STAGE, clear);
		}
		private function dispatchComplete():void
		{
			_countClear ++;
			if (_countClear == _nbrChanel) {
				TweenMax.killChildTweensOf(this);
				dispatchEvent(new Event(Event.COMPLETE));
				removeEventListener(Event.REMOVED_FROM_STAGE, clear);
			}
		}

		//-----------------------------------------------------------------------------
		private function createBMD(dObj:DisplayObject):BitmapData {
			// create a new BitmapData object the size of our DisplayObject
			var bmd:BitmapData = new BitmapData(dObj.width, dObj.height, true, 0xffffffff);
			// draw the display object to the bitmap data
			bmd.draw(dObj);

			return bmd;
		}
		
		//-----------------------------------------------------------------------------
		//private function createRGB(dObj:BitmapData):Array {
		private function createRGB(dObj:Sprite):Array {
			var bmd:BitmapData = createBMD(dObj); // create bitmapData from the display object
			// create a new bitmap data object for each color channel
	        var r:BitmapData = new BitmapData(bmd.width, bmd.height, true, 0xff000000);
	        var g:BitmapData = new BitmapData(bmd.width, bmd.height, true, 0xff000000);
	        var b:BitmapData = new BitmapData(bmd.width, bmd.height, true, 0xff000000);
	
			// copy the data from each channel into the corresponding bitmap data
	        r.copyChannel(bmd, bmd.rect, new Point(), BitmapDataChannel.RED, BitmapDataChannel.RED);
	        g.copyChannel(bmd, bmd.rect, new Point(), BitmapDataChannel.GREEN, BitmapDataChannel.GREEN);
	        b.copyChannel(bmd, bmd.rect, new Point(), BitmapDataChannel.BLUE, BitmapDataChannel.BLUE);
			
			// return an array with the bitmap data for the 3 color channels
	        return [r, g, b];
	    }
	
	}

}
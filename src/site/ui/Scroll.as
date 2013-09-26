package site.ui
{
	
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle; 
	import flash.display.Shape; 
	import site.navigation.DataLoader;
	[Embed(source='bibliotheque.swf', symbol='scrollbar_mc')]

	public class Scroll extends Sprite
	{
		//symbole _ruler importé de la bibliotheque
		public var _ruler : Sprite;
		//symbole _background importé de la bibliotheque
		public var _background : Sprite;
		//symbole _ruler importé de la bibliotheque
		public var _arrowTop : Sprite;
		public var _arrowBottom : Sprite;
		//
		private var _dragged:Sprite; 
		private var _mask:Sprite; 
		private var _hitarea:Sprite; 
		private var _blurred:Boolean; 
		private var _YFactor:Number; 
		private var _colorRulerOut:Number;
		private var _colorRulerOver:Number;
		private var _colorBackground:Number; 
		private var _alphaBackground:Number;
		private var _alphaRulerOut:Number;
		private var _alphaRulerOver:Number;
		private var colorTransform_rulerOut:ColorTransform = new ColorTransform();
		private var colorTransform_rulerOver:ColorTransform = new ColorTransform();
		private var colorTransform_background:ColorTransform = new ColorTransform();
		
		private var _initY:Number; 
		
		private var minY:Number;
		private var maxY:Number;
		private var percentuale:uint;
		private var contentstarty:Number; 
		private var bf:BlurFilter;
		//SAVOIR SI ON EST CLICKER OU PAS SUR RULER
		private var clicked:Boolean = false;
		private var over:Boolean = false;
		//le scroller est actif ou pas
		public var _actif:Boolean;
		
		private var initialized:Boolean = false; 
		
		//cache des positions en cas de pause
		private var draggedPosTemp:int; 
		private var rulerPosTemp:int; 
		//variable qui permet de bloquer le defilement du scroll a la molette de la souris si true, la souris n est pas active, si false la souris est active
		public var blocked:Boolean = false;
		private var checkPos:int;
		
		/**
		 * Creates a new Scrollbar object to scroll a single Display Object.
		 * @param	dragged	the object to be scrolled
		 * @param	maskclip	le mask
		 * @param	hitarea	la zone ou le mousewhell est actif
		 * @param	blurred	flou appliqué sur le clip dragged = false
		 * @param	yfactor	le facteur de saut de ligne
		 */
		public function Scroll(dragged:Sprite, maskclip:Sprite, hitarea:Sprite, blurred:Boolean = false, yfactor:Number = 4,actif:Boolean = true ,colorRulerOut:Number = 0x006699,alphaRulerOut:Number = 1,colorRulerOver:Number = 0x00ff00, alphaRulerOver:Number = 1, colorBackground:Number = 0xff0000, alphaBackground:Number = 1)
		{
			super();
			_dragged = dragged; 
			_mask = maskclip;
			_hitarea = hitarea;
			_blurred = blurred; 
			_YFactor = yfactor; 
			_actif = actif;
			_colorRulerOut = colorRulerOut;
			_colorRulerOver = colorRulerOver;
			_colorBackground = colorBackground;
			_alphaRulerOut = alphaRulerOut;
			_alphaRulerOver = alphaRulerOver;
			_alphaBackground = alphaBackground;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function set dragged (v:Sprite):void {
			_dragged = v; 
		}
		
		public function set maskclip (v:Sprite):void {
			_mask = v; 
		}
		
		public function set ruler (v:Sprite):void {
			_ruler = v; 
		}
		
		public function set arrowTop (v:Sprite):void {
			_arrowTop = v; 
		}
		
		public function set arrowBottom (v:Sprite):void {
			_arrowBottom = v; 
		}
		
		public function set background (v:Sprite):void {
			_background = v; 
		}
		
		public function set hitarea (v:Sprite):void {
			_hitarea = v; 
		}		
		
		private function checkPieces():Boolean {
			var ok:Boolean = true; 
			if (_dragged == null) {
				trace("SCROLLBAR: DRAGGED not set"); 
				ok = false; 	
			}
			if (_mask == null) {
				trace("SCROLLBAR: MASK not set"); 
				ok = false; 	
			}
			if (_ruler == null) {
				trace("SCROLLBAR: RULER not set"); 	
				ok = false; 
			}
			if (_arrowTop == null) {
				trace("SCROLLBAR: ARROWTOP not set"); 	
				ok = false; 
			}
			if (_arrowBottom == null) {
				trace("SCROLLBAR: ARROWBOTTOM not set"); 	
				ok = false; 
			}
			if (_background == null) {
				trace("SCROLLBAR: BACKGROUND not set"); 	
				ok = false; 
			}
			if (_hitarea == null) {
				trace("SCROLLBAR: HITAREA not set"); 	
				ok = false; 
			}
			return ok; 
		}
		
		public function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
			if (checkPieces() == false) {
				trace("SCROLLBAR: CANNOT INITIALIZE"); 
			} else { 
				
				if (initialized == true) {
					reset();
				}
				//MISE EN COULEUR
				colorTransform_rulerOut = new ColorTransform();
				colorTransform_rulerOut.color = _colorRulerOut;
				_ruler.transform.colorTransform = colorTransform_rulerOut;
				_ruler.alpha = _alphaRulerOut;
				//
				colorTransform_rulerOver = new ColorTransform();
				colorTransform_rulerOver.color = _colorRulerOver;
				//
				colorTransform_background = new ColorTransform();
				colorTransform_background.color = _colorBackground;
				_background.transform.colorTransform = colorTransform_background;
				//
				_arrowTop.transform.colorTransform = colorTransform_background;
				_arrowBottom.transform.colorTransform = colorTransform_background;
				//
				//bf = new BlurFilter(0, 0, 1); 
				//this._dragged.filters = new Array(bf); 
				this._dragged.mask = this._mask; 
				//this._dragged.cacheAsBitmap = true; 
				
				_background.height = _mask.height;
				_background.alpha = _alphaBackground;
				//_background.visible = false;
				this.minY = _background.y; 
				
				this._ruler.buttonMode = true; 
	
				this.contentstarty = _dragged.y; 
				
				_arrowTop.mouseEnabled = false;
				_arrowBottom.mouseEnabled = false;
				_ruler.addEventListener(MouseEvent.MOUSE_DOWN, clickHandle); 
				_ruler.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
				_ruler.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
				stage.addEventListener(MouseEvent.MOUSE_UP, releaseHandle);
				stage.addEventListener(MouseEvent.MOUSE_WHEEL, wheelHandle, false); 
				//stage.addEventListener(Event.MOUSE_LEAVE, outFlashHandle);
				addEventListener(Event.ENTER_FRAME, enterFrameHandle); 
				
				initialized = true; 
			}
		}
		
		private function destroy(e:Event):void 
		{
			trace("destroy scroll");
			_ruler.removeEventListener(MouseEvent.MOUSE_DOWN, clickHandle); 
			_ruler.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			_ruler.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			stage.removeEventListener(MouseEvent.MOUSE_UP, releaseHandle);
			stage.removeEventListener(MouseEvent.MOUSE_WHEEL, wheelHandle, false); 
			//stage.removeEventListener(Event.MOUSE_LEAVE, outFlashHandle);
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeEventListener(Event.ENTER_FRAME, enterFrameHandle); 
		}
		
		public function ajuste(maskclip:Sprite):void
		{
			_mask = maskclip;
			_background.height = _mask.height;
		}
		
		private function mouseOver(e:MouseEvent):void 
		{
			over = true;
			e.target.transform.colorTransform = colorTransform_rulerOver;
			e.target.alpha = _alphaRulerOver;
		}
		
		private function mouseOut(e:MouseEvent):void 
		{
			over = false;
			if(clicked == false){
				e.target.transform.colorTransform = colorTransform_rulerOut;
				e.target.alpha = _alphaRulerOut;
			}
		}
		
		private function clickHandle(e:MouseEvent) :void
		{
			
			clicked = true;
			var rect:Rectangle = new Rectangle(_background.x-(_ruler.width/2), minY, 0, maxY);
			_ruler.startDrag(false, rect);
		}
		
		private function releaseHandle(e:MouseEvent) :void
		{
			clicked = false;
			if(over == false){
				_ruler.transform.colorTransform = colorTransform_rulerOut;
				_ruler.alpha = _alphaRulerOut;
			}
			_ruler.stopDrag();
		}
		
		private function outFlashHandle(e:Event) :void
		{
			clicked = false;
			if(over == false){
				_ruler.transform.colorTransform = colorTransform_rulerOut;
				_ruler.alpha = _alphaRulerOut;
			}
			_ruler.stopDrag();
		}
		
		private function wheelHandle(e:MouseEvent):void
		{
			if (this._hitarea.hitTestPoint(stage.mouseX, stage.mouseY, false))
			{
				if (blocked == false) {
					scrollData(e.delta);
				}
			}
		}
		
		private function enterFrameHandle(e:Event):void
		{
			//trace(name);
			positionContent();
		}
		
		private function scrollData(q:int):void
		{
			var d:Number;
			var rulerY:Number; 
			
			var quantity:Number = this._ruler.height / 5; 

			d = -q * Math.abs(quantity); 
	
			if (d > 0) {
				rulerY = Math.min(maxY, _ruler.y + d);
			}
			if (d < 0) {
				rulerY = Math.max(minY, _ruler.y + d);
			}
			
			_ruler.y = rulerY; 
	
			positionContent();
		}
		
		public function positionContent():void {
			
			var upY:Number;
			var downY:Number;
			var curY:Number;
			
			/* thanks to Kalicious (http://www.kalicious.com/) */
			this._ruler.height = int((this._mask.height / this._dragged.height) * this._background.height);
			this.maxY = int(this._background.height - this._ruler.height);
			/*	*/ 		
			this._arrowTop.y = this._ruler.y + 10;
			this._arrowBottom.y = this._ruler.y + this._ruler.height - 10;
			
			var limit:Number = int(this._background.height - this._ruler.height); 

 			if (this._ruler.y > limit) {
				this._ruler.y = limit; 
			} 
	
			checkContentLength();	
	
			percentuale = (100 / maxY) * _ruler.y;
				
			upY = 0;
			downY = _dragged.height - (_mask.height / 2);
			 
			var fx:Number = contentstarty - (((downY - (_mask.height/2)) / 100) * percentuale); 
			
			var curry:Number = _dragged.y; 
			var finalx:Number = fx; 
			
			var difMvt:int = Math.abs(curry - finalx)*10
			//if (curry != finalx) {
			if (difMvt > 5) {
				//checkPos = 0;
				var diff:Number = finalx-curry;
				curry += diff / _YFactor; 
				
				//var bfactor:Number = Math.abs(diff)/8; 
				//bf.blurY = bfactor/2; 
				//if (_blurred == true) {
					//_dragged.filters = new Array(bf);
				//}
			}//else {
				//if(checkPos == 0){
					//trace(name + " contenu en place");
				//}
				//checkPos = 1;
			//}
			
			_dragged.y = curry; 
		}
		
		public function checkContentLength():void
		{
			if (_dragged.height < _mask.height) {
				_ruler.visible = false;
				_background.visible = false;
				_arrowTop.visible = false;
				_arrowBottom.visible = false;
				//TweenMax.to(_ruler, DataLoader.tempsApparition, { autoAlpha:0 } );
				//TweenMax.to(_background, DataLoader.tempsApparition, { autoAlpha:0 } );
				reset();
			} else {
				_ruler.visible = true;
				_background.visible = true;
				_arrowTop.visible = true;
				_arrowBottom.visible = true;
				//TweenMax.to(_ruler, DataLoader.tempsApparition, { autoAlpha:1 } );
				//TweenMax.to(_background, DataLoader.tempsApparition, { autoAlpha:1 } );
			}
		}
		
		public function reset():void {
			_dragged.y = contentstarty; 
			_ruler.y = 0; 			
		}
		
		public function stop():void {
			//mise en cache des valeurs hauteur des elements
			draggedPosTemp = _dragged.y;
			rulerPosTemp = _ruler.y;
			//
			_dragged.y = contentstarty; 
			_ruler.y = 0; 
			//
			removeEventListener(Event.ENTER_FRAME, enterFrameHandle); 
		}
		
		public function pause():void {
			//mise en cache des valeurs hauteur des elements
			draggedPosTemp = _dragged.y;
			rulerPosTemp = _ruler.y;
			//
			removeEventListener(Event.ENTER_FRAME, enterFrameHandle); 
		}
		
		public function play():void {
			_dragged.y = draggedPosTemp; 
			_ruler.y = rulerPosTemp; 
			//
			addEventListener(Event.ENTER_FRAME, enterFrameHandle); 
		}
		
	}
}
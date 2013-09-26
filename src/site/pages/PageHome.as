package site.pages 
{
	import com.greensock.TweenMax;
	import com.shic.displayObjects.Square;
	import flash.events.Event;
	import site.navigation.DataLoader;
	/**
	 * ...
	 * @author ...
	 */
	public class PageHome extends ContenuPage
	{
		private var xml:XMLList;
		private var work:ModuleProduct;
		private var product:ModuleProduct;
		private var nbreElements:uint = 0;
		private var elementLoaded:uint = 0;
		private var video:ModuleYouTube;
		private var footer:Square;
		
		public function PageHome(_xml:XMLList,_type:String) 
		{
			//visible = false;
			//alpha = 0;
			//
			TYPE = _type;
			xml = _xml;
			//
			super();
			//
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void 
		{
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			work = new ModuleProduct(xml.children().(@type == TYPE).works);
			addChild(work);
			work.addEventListener(Event.COMPLETE, checkIfAllLoaded);
			nbreElements ++;
			//
			product = new ModuleProduct(xml.children().(@type == TYPE).products);
			addChild(product);
			product.addEventListener(Event.COMPLETE, checkIfAllLoaded);
			nbreElements ++;
			//
			video = new ModuleYouTube(xml.children().(@type == TYPE).news);
			addChild(video);
			video.addEventListener(Event.COMPLETE, checkIfAllLoaded);
			nbreElements ++;
			//
			footer = new Square(10, 50, 0x006699, 0.6);
			footer.alpha = 0;
			addChild(footer);
		}
		
		public override function pauseVideo():void
		{
			if (video && this.contains(video)) {
				video.pauseButtonClickHandler();
			}
		}
		
		private function checkIfAllLoaded(e:Event):void
		{
			elementLoaded++;
			if (nbreElements == elementLoaded) {
				resize();
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		public override function resize():void 
		{
			if (work && this.contains(work) && product && this.contains(product) && video && this.contains(video) && footer && this.contains(footer)) {
				video.y = work.height + DataLoader.margeGlobale;
				product.y = video.y + video.hauteurModule + DataLoader.margeGlobale/2;
				footer.y = product.y + product.height;
				
			}
		}
		
		public override function apparition():void {
			work.apparition();
			TweenMax.delayedCall(DataLoader.tempsApparition,video.apparition);
			TweenMax.delayedCall(DataLoader.tempsApparition*2,product.apparition);
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
		}
		
	}

}
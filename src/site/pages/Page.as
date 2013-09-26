package site.pages 
{
	import com.greensock.TweenMax;
	import com.shic.displayObjects.Square;
	import flash.display.Sprite;
	import flash.events.Event;
	import site.navigation.DataLoader;
	import site.navigation.Navigation;
	import site.ui.Scroll;
	
	/**
	 * ...
	 * @author 
	 */
	public  class Page extends Sprite
	{
		public var fond:Square;
		private var largeurFond:uint = DataLoader.largeurPage;
		private var type:String;
		public var scrollGlobal:Scroll;
		private var maskScroll:Square;
		private var tempScroll:Sprite;
		
		public function Page(_type:String = null) 
		{
			type = _type
			//
			if(stage){
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void
		{
			
			//
			//fond = new Square(1, stage.stageHeight, DataLoader.couleurFond, DataLoader.alphaFond);
			fond = new Square(1, stage.stageHeight, DataLoader.couleurFond, DataLoader.alphaFond,true,0,DataLoader.couleurTrait);
			fond.alpha = 0;
			addChild(fond);
			//
			//
			tempScroll = new Square(10, 10, 0x000000, 0);
			addChild(tempScroll);
			maskScroll = new Square(largeurFond, stage.stageHeight, 0x000000, 0.5);
			scrollGlobal = new Scroll(tempScroll, maskScroll, maskScroll, false, 4,false, DataLoader.couleurTexteBlanc, 0.8, DataLoader.couleurTexteBlanc,1, DataLoader.couleurFond,DataLoader.alphaFond/2);
			scrollGlobal.alpha = 0;
			scrollGlobal.visible = false;
			scrollGlobal.scaleX = 1;
			scrollGlobal.x = stage.stageWidth - this.x - scrollGlobal.width;
			addChild(scrollGlobal);
		}
		
		public function resize(e:Event=null):void
		{
			fond.y = -1;
			fond.height = stage.stageHeight + 2;
			maskScroll.width = stage.stageWidth;
			maskScroll.height = stage.stageHeight;
			scrollGlobal.ajuste(maskScroll);
			scrollGlobal.x = stage.stageWidth - this.x - scrollGlobal.width;
		}
		
		public function apparition(e:Event=null):void
		{
			TweenMax.to(fond, DataLoader.tempsApparition, { autoAlpha:1, width:largeurFond } );
			//TweenMax.to(scrollGlobal, DataLoader.tempsApparition, { delay:DataLoader.tempsApparition*3,autoAlpha:1} );
		}
	}

}
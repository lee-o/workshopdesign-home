package 
{
	import com.shic.displayObjects.Loading_mc;
	import com.shic.displayObjects.Square;
	import com.shic.displayObjects.TextFieldMultiLines;
	import com.shic.utils.Utils;
	import com.greensock.*;
	import com.thinkadelik.stat.Ga;
	import flash.filters.DropShadowFilter;
	import site.navigation.Navigation;
	import site.pages.BackGround;
	import site.navigation.DataLoader;
	import site.events.DataLoaderEvent;
	import site.navigation.Menu;
	import site.pages.Intro;
	import site.pages.LinkMenu;
	import site.pages.Logo;
	import site.pages.Page;
	import site.pages.PageHome;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.Security;
	import com.pixelbreaker.ui.osx.MacMouseWheel; 
	//
	Security.allowDomain("*.workshopdesign-home.com");
	Security.loadPolicyFile("*.workshopdesign-home.com/crossdomain.xml");
	Security.allowDomain("*.youtube.com");
	Security.loadPolicyFile("*.youtube.com/crossdomain.xml");
	 /* ...
	 * @author 
	 */
	public class MainWorkshopDesign extends Sprite 
	{
		[Embed(source = 'site/embedFonts/Fonts.swf', fontFamily = 'HelveticaNeueLT Std Thin')]
		private var HelveticaNeueThin:Class;
		[Embed(source='site/embedFonts/Fonts.swf', fontFamily='HelveticaNeueLT Std Lt')]
		private var HelveticaNeueLight:Class;
		[Embed(source='site/embedFonts/Fonts.swf', fontFamily='HelveticaNeueLT Std')]
		private var HelveticaNeue:Class;
		[Embed(source='site/embedFonts/Fonts.swf', fontFamily='HelveticaNeueLT Std', fontWeight='bold')]
		private var HelveticaNeueBold:Class;
		
		public static var linkMenu:LinkMenu;
		public static var backGround_mc:BackGround;
		public static var logo_mc:Logo;
		public static var intro_mc:Intro;
		public var dataLoader:DataLoader;
		public var ga:Ga;
		public static var root : Sprite;
		public static var menu_mc:Menu;
		public static var loading:Loading_mc = new Loading_mc();
		private static var cashGlobal:Square;
		private static var cliktext:TextFieldMultiLines;
		public static var page:Page;
		public static var posPage:uint = 220;
		

		
		public function MainWorkshopDesign ()
		{
			if (stage){init();}
			else{addEventListener(Event.ADDED_TO_STAGE, init);}
		}
		
		/**
		 * démare le projet
		 * @param	e
		 */
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			MainWorkshopDesign.root = this;
			//
			//stage
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(Event.RESIZE, resize);
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFullScreen);
			//
			stage.stageFocusRect = false;
			//
			addChild(loading);
			resize();
			//
			dataLoader = new DataLoader();
			dataLoader.addEventListener(DataLoaderEvent.READY, dataLoaded);
			//
			MacMouseWheel.setup( stage );
		}
		
		private function dataLoaded(e:DataLoaderEvent):void 
		{
			//
			ga = new Ga();
			//
			backGround_mc = new BackGround(DataLoader.xmlWsdLoader.xml);
			//
			//LOGO ATTENTE/////////////
			/*addChild(backGround_mc);
			intro_mc = new Intro();
			addChild(intro_mc);
			backGround_mc.alpha = 0;
			TweenMax.to(backGround_mc, DataLoader.tempsApparition, { delay:DataLoader.tempsApparition*2,alpha:1 } );*/
			//
			//ENTREE SITE/////////////
			backGround_mc.alpha = 0;
			backGround_mc.addEventListener(Event.COMPLETE, backGroundLoaderHandler);
		}
		
		private function backGroundLoaderHandler(e:Event = null):void 
		{
			Navigation.setLoading(false);
			//
			backGround_mc.removeEventListener(Event.COMPLETE, backGroundLoaderHandler);
			//
			linkMenu = new LinkMenu(DataLoader.xmlWsdLoader.xml);
			linkMenu.visible = false;
			linkMenu.alpha = 0;
			//
			logo_mc = new Logo();
			//
			menu_mc = new Menu(DataLoader.xmlWsdLoader.xml);
			menu_mc.visible = false;
			menu_mc.alpha = 0;
			//
			page = new Page();
			page.x = posPage;
			//
			addChild(backGround_mc);
			addChild(logo_mc);
			addChild(menu_mc);
			addChild(page);
			addChild(linkMenu);
			//
			TweenMax.to(backGround_mc, DataLoader.tempsApparition, { alpha:1 } );
			TweenMax.delayedCall(DataLoader.tempsApparition/2, logo_mc.apparition);
			TweenMax.to(linkMenu, DataLoader.tempsApparition, { delay:DataLoader.tempsApparition*2, autoAlpha:1 } );
			TweenMax.to(menu_mc, DataLoader.tempsApparition, { delay:DataLoader.tempsApparition*2.5, autoAlpha:1 } );
			TweenMax.delayedCall(DataLoader.tempsApparition*3, page.apparition);
			TweenMax.delayedCall(DataLoader.tempsApparition*3.5, menu_mc.openHome, ["Home"]);
			//
			scrollRect = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			//
			resize();
		}
		
		public static function MainPlay(e:MouseEvent = null):void
		{
			backGround_mc.pauseDiaporama = false;
			TweenMax.to(cashGlobal, DataLoader.tempsApparition / 2, { autoAlpha:0 , onComplete:function rePlay():void {
				cashGlobal.removeEventListener(MouseEvent.CLICK, MainPlay);
				root.removeChild(cashGlobal);
				cashGlobal = null;
			}
			} );
			//
			TweenMax.to(cliktext, DataLoader.tempsApparition / 2, { autoAlpha:0 , onComplete:function rePlay():void {
				root.removeChild(cliktext);
				cliktext = null;
			}
			} );
			/*var obj:Object = new Object();
			obj.type = "navigation";
			obj.name = "back";
			Ga.track("Event", obj);*/
			Ga.Event("navigation", "back");
		}
		
		public static function MainPause(e:MouseEvent = null):void
		{
			backGround_mc.pauseDiaporama = true;
			//
			Navigation.TYPE == "Home" ? Navigation.currentPage.pauseVideo() : null;
			//
			if(MainWorkshopDesign.root.stage.displayState == StageDisplayState.FULL_SCREEN){
				MainWorkshopDesign.root.stage.displayState = StageDisplayState.NORMAL;
			}
			//
			cashGlobal = new Square(root.stage.stageWidth, root.stage.stageHeight, 0x000000, 0.9);
			cashGlobal.visible = false;
			cashGlobal.alpha = 0;
			root.addChild(cashGlobal);
			//
			cliktext = new TextFieldMultiLines("CLICK TO REPLAY");
			cliktext.visible = false;
			cliktext.alpha = 0;
			cliktext.width = 110;
			DataLoader.xmlStyleLoader.appliqueFormat(cliktext, "Helvetica-Neue-Lt-Std-Light");
			cliktext.textColor = 0xFFFFFF;
			cliktext.x = root.stage.stageWidth / 2 - cliktext.width / 2;
			cliktext.y = root.stage.stageHeight / 2 - cliktext.height / 2;
			root.addChild(cliktext);
			//
			TweenMax.to(cashGlobal, DataLoader.tempsApparition / 2, { autoAlpha:1 } );
			TweenMax.to(cliktext, DataLoader.tempsApparition / 2, {delay:0.5, autoAlpha:1 } );
			cashGlobal.addEventListener(MouseEvent.CLICK, MainPlay);
			//
			/*var obj:Object = new Object();
			obj.type = "navigation";
			obj.name = "exit";
			Ga.track("Event", obj);*/
			Ga.Event("navigation", "exit");
		}
		
		private function onFullScreen(e:FullScreenEvent):void 
		{
			if (stage.displayState == StageDisplayState.FULL_SCREEN) {
				
			}else {
				
			}
			resize();
			
		}
		
		public static function toggleFullScreen(e:MouseEvent = null):void 
		{
			//trace(root.stage.displayState);
            switch(root.stage.displayState) {
                case StageDisplayState.NORMAL:
                    root.stage.displayState = StageDisplayState.FULL_SCREEN;    
                    break;
                case StageDisplayState.FULL_SCREEN:
                    root.stage.displayState = StageDisplayState.NORMAL;    
                    break;
            }
        } 
		public static function resize(e:Event = null):void
		{
			root.scrollRect = new Rectangle(0, 0, root.stage.stageWidth, root.stage.stageHeight);
			
			if (cashGlobal) {
				cashGlobal.width = root.stage.stageWidth;
				cashGlobal.height = root.stage.stageHeight;
			}
			
			if (cliktext) {
				cliktext.x = root.stage.stageWidth / 2 - cliktext.width / 2;
				cliktext.y = root.stage.stageHeight / 2 - cliktext.height / 2;
			}
			
			if (backGround_mc && root.contains(backGround_mc)) {
				backGround_mc.resize();
			}
			
			if (intro_mc && root.contains(intro_mc)) {
				intro_mc.resize();
			}
			
			if (loading && root.contains(loading)) {
				loading.x = root.stage.stageWidth / 2;
				loading.y = root.stage.stageHeight / 2;
			}
			
			if (linkMenu && root.contains(linkMenu)) {
				linkMenu.x = uint(root.stage.stageWidth - (DataLoader.margeBordure));
				linkMenu.y = DataLoader.margeBordure;
			}
			
			if (logo_mc && root.contains(logo_mc)) {
				logo_mc.resize();
			}
			
			if (menu_mc && root.contains(menu_mc)) {
				menu_mc.y = (root.stage.stageHeight - menu_mc.height) / 2;
				menu_mc.x = DataLoader.margeBordure;
			}
			
			if (page && root.contains(page)) {
				page.x = Math.max(posPage,root.stage.stageWidth/5);
				page.resize();
			}
			
			if (Navigation.currentPage && page.contains(Navigation.currentPage)) {
				Navigation.currentPage.resize();
			}
		}	
		
	}

}
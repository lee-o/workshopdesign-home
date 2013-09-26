package site.pages 
{
	import com.shic.utils.Utils;
	import com.thinkadelik.stat.Ga;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import site.gfx.LogoMain;
	import site.gfx.LogoTitreWsd;
	import site.gfx.LogoWsdLarge;
	import site.navigation.DataLoader;
	/**
	 * ...
	 * @author ...
	 */
	public class Logo extends Sprite
	{
		private var logoMain:LogoMain;
		private var logoTitreWsd:LogoTitreWsd;
		private var logoWsd:LogoWsdLarge;
		//
		public function Logo() 
		{
			init();
		}
		
		private function init():void 
		{
			logoMain = new LogoMain;
			addChild(logoMain);
			//
			logoTitreWsd = new LogoTitreWsd;
			addChild(logoTitreWsd);
			//
			logoWsd = new LogoWsdLarge;
			addChild(logoWsd);
			logoWsd.x = logoWsd.y = DataLoader.margeBordure;
			//logoWsd.scaleX = logoWsd.scaleY = 0.75;
			//
			var logoFbClick:Sprite = logoMain.getChildByName("LogoFbClick") as Sprite;
			logoFbClick.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			logoFbClick.buttonMode = true;
			//
			var logoTwitClick:Sprite = logoMain.getChildByName("LogoTwitClick") as Sprite;
			logoTwitClick.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			logoTwitClick.buttonMode = true;
			//
			var logoPinClick:Sprite = logoMain.getChildByName("LogoPinClick") as Sprite;
			logoPinClick.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			logoPinClick.buttonMode = true;
			//
			var logoStoreClick:Sprite = logoMain.getChildByName("LogoStoreClick") as Sprite;
			logoStoreClick.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			logoStoreClick.buttonMode = true;
			//
			var logoFsClick:Sprite = logoMain.getChildByName("LogoFsClick") as Sprite;
			logoFsClick.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			logoFsClick.buttonMode = true;
			//
			MainWorkshopDesign.root.stage.addEventListener(FullScreenEvent.FULL_SCREEN, logoMain.onFullScreen);
			//
			resize();
			//
		}
		
		private function mouseUpHandler(e:MouseEvent):void 
		{
			e.currentTarget.name != "LogoFsClick" ? MainWorkshopDesign.MainPause():null;
			//
			switch(e.currentTarget.name) {
				case "LogoFbClick":
					Utils.openExternalPage("http://www.facebook.com/pages/WORKSHOPDESIGN/185260378192154");
					break;
				case "LogoTwitClick":
					Utils.openExternalPage("https://twitter.com/WORKSHOPDESIGN1");
					break;
				case "LogoPinClick":
					Utils.openExternalPage("http://pinterest.com/workshopinit/");
					break;
				case "LogoStoreClick":
					Utils.openExternalPage("http://itunes.apple.com/fr/app/workshopdesign-e-store/id489886197?mt=8");
					break;
				case "LogoFsClick":
					MainWorkshopDesign.toggleFullScreen();
					break;
				
			}
			//
			Ga.Event("facebook", "open");
		}
		
		public function apparition(e:Event = null):void
		{
			logoWsd.apparition(DataLoader.tempsApparition, DataLoader.tempsApparition/2);
			logoMain.apparition(DataLoader.tempsApparition, DataLoader.tempsApparition);
			logoTitreWsd.apparition(DataLoader.tempsApparition, DataLoader.tempsApparition * 1.5);
		}
		
		public function resize(e:Event = null):void 
		{
			if (stage) {
				var Width:int = stage.stageWidth; 
				var Height:int = stage.stageHeight; 
				//
				if (logoMain && this.contains(logoMain)) {
					logoMain.x = 0;
					logoMain.y = Height;
				}
				//
				if (logoTitreWsd && this.contains(logoTitreWsd)) {
					logoTitreWsd.x = Width;
					logoTitreWsd.y = Height;
				}
			}
		}
		
	}

}
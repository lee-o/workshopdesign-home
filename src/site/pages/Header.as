package site.pages 
{
	import com.greensock.TweenMax;
	import com.shic.displayObjects.Square2;
	import com.shic.displayObjects.TextFieldMultiLines;
	import site.gfx.logoFaceB;
	import site.gfx.TitreTypo;
	import MainWorkshopDesign;
	import site.navigation.DataLoader;
	import site.navigation.Menu;
	import site.navigation.Navigation;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author lee-o
	 */
	public class Header extends Sprite
	{
		private var conteneur_mc:Sprite;
		private var fond_mc:Square2;
		private var logo_mc:logoFaceB;
		//private var titre_txt:TextFieldMultiLines;
		private var titre_txt:TitreTypo;
		private var desc_txt:TextFieldMultiLines;
		private var largeurPage:uint = DataLoader.largeurGlobale;
		private var hauteurPage:uint = 168;
		private var marge:int = DataLoader.margeGlobale;
		private var xml:XML;
		private var largeurTexte:int = 580;
		
		public function Header(_xml:XML) 
		{
			//alpha = 0;
			//visible = false;
			//
			xml = _xml;
			//
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
			
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, removeFromStage);
			//
			conteneur_mc = new Sprite();
			fond_mc = new Square2(largeurPage, hauteurPage, DataLoader.couleurTexteGrisClair, 0);
			conteneur_mc.addChild(fond_mc);
			//
			logo_mc = new logoFaceB();
			//logo_mc.x = 77;
			logo_mc.scaleX = logo_mc.scaleY = 0.8;
			logo_mc.x = 8;
			logo_mc.y = 16;
			conteneur_mc.addChild(logo_mc);
			logo_mc.buttonMode = true;
			logo_mc.addEventListener(MouseEvent.MOUSE_OVER, overLogo);
			logo_mc.addEventListener(MouseEvent.MOUSE_OUT, outLogo);
			logo_mc.addEventListener(MouseEvent.CLICK, clikLogo);
			//
			/*titre_txt = new TextFieldMultiLines("", DataLoader.couleurTexteNoir);
			titre_txt.alpha = 0;
			titre_txt.name = "titre_txt";
			titre_txt.width = largeurTexte;
			//titre_txt.x = 336;
			titre_txt.x = 158;
			titre_txt.htmlText = xml.title.name;
			DataLoader.xmlStyleLoader.appliqueFormat(titre_txt, "AvantGarde-bk-20");
			conteneur_mc.addChild(titre_txt);*/
			titre_txt = new TitreTypo();
			titre_txt.alpha = 0;
			titre_txt.name = "titre_txt";
			titre_txt.x = 158;
			conteneur_mc.addChild(titre_txt);
			//
			if(xml.title.desc != ""){
				desc_txt = new TextFieldMultiLines("", DataLoader.couleurTexteNoir);
				desc_txt.alpha = 0;
				desc_txt.name = "desc_txt";
				desc_txt.width = largeurTexte;
				desc_txt.x = 158;
				desc_txt.htmlText = xml.title.desc;
				DataLoader.xmlStyleLoader.appliqueFormat(desc_txt, "AvantGarde-bk-14");
				conteneur_mc.addChild(desc_txt);
			}
			if (desc_txt) {
				desc_txt.y = hauteurPage - (marge + desc_txt.height + 4);
				titre_txt.y = desc_txt.y - (int(marge/3) + titre_txt.height);
			}else{
				titre_txt.y = hauteurPage - (marge + 4 + titre_txt.height);
			}
			//
			addChild(conteneur_mc);
			//
			resize();
			//
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function clikLogo(e:MouseEvent):void 
		{
			/*var url:String = DataLoader.racine;
			var request:URLRequest = new URLRequest(url);
			navigateToURL(request, '_blank');*/
			if (Navigation.TYPE != "Home") {
				Navigation.menu.loadHomeFromLogo();
			}
		}
		
		private function outLogo(e:MouseEvent):void 
		{
			//MainWorkshopDesign.shifterStop();
		}
		
		private function overLogo(e:MouseEvent):void 
		{
			//MainWorkshopDesign.shifterPlay();
		}
		
		public function resize(e:Event = null):void
		{
			if (conteneur_mc && this.contains(conteneur_mc)) {
				conteneur_mc.x =  stage.stageWidth / 2 - largeurPage / 2;
			}
		}
		
		public function apparition():void
		{
			logo_mc.apparition(DataLoader.tempsApparition, 0, 1);
			TweenMax.to(titre_txt, DataLoader.tempsApparition, { delay:0.4, alpha:1 } );
			if(desc_txt){
				TweenMax.to(desc_txt, DataLoader.tempsApparition, { delay:0.8, alpha:1 } );
			}
		}
		
		private function removeFromStage(e:Event):void
		{
		}
		
	}

}
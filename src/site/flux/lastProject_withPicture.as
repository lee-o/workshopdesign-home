package site.flux 
{
	import com.shic.displayObjects.Square2;
	import FaceB.site.gfx.cartoucheTitre;
	import FaceB.site.gfx.invCartoucheTitre;
	import FaceB.site.navigation.DataLoader;
	import FaceB.site.ui.Scroll;
	import com.greensock.*;
	import com.shic.displayObjects.TextFieldMultiLines;
	import com.shic.utils.Utils;
	import com.shic.utils.EasyLoader;
	import FaceB.site.MainFaceB;
	import flash.display.LineScaleMode;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author lee-o
	 */
	public class lastProject extends Sprite
	{
		[Event(name = "complete", type = "flash.events.Event")]
		//
		private var rss_Loader:URLLoader = new URLLoader();
		private var rss_URL:URLRequest;
		private var project_XML:XML = new XML();
		private var _textFormat:TextFormat;
		public var conteneur_txt:Sprite;
		public var titre:cartoucheTitre;
		private var endSquare:invCartoucheTitre;
		//
		public var largeurTexte:uint;
		public var hauteurTexte:uint;
		public var reelHeight:uint;
		//
		private var fluxLoaded:uint = 0;
		private var fluxToLoad:uint;
		//
		private var decalageTri:uint = 24;
		private var margeGlobale:int = DataLoader.margeGlobale;
		//
		private var fondConteneur_txt:Square2;
		//
		//scroller
		public var sc:Scroll;
		//
		//
		//
		public function lastProject(_xml:XML,_largeur:uint = 400,_hauteur:uint = 400) 
		{
			this.visible = false;
			this.alpha = 0;
			//
			largeurTexte = _largeur;
			hauteurTexte = _hauteur;
			//
			project_XML = _xml;
			project_Loaded();
		}
		
		private function project_Loaded(e:Event = null):void
		{
			conteneur_txt = new Sprite();
			//
			project_XML.ignoreWhitespace = true;
			//
			var conteneurProjectXml:XMLList = project_XML.last_project;
			fluxToLoad = conteneurProjectXml.project.length();
			//
			titre = new cartoucheTitre(conteneurProjectXml.name, "AvantGarde-bk-16", DataLoader.couleurTexteBlanc, DataLoader.couleurTexteNoir, decalageTri, false, true);
			endSquare = new invCartoucheTitre(largeurTexte - (titre.width + margeGlobale / 2), titre.height, decalageTri, DataLoader.couleurTexteNoir);
			//
			for (var item:String in conteneurProjectXml.project) {
				var blocText_mc:MovieClip = new MovieClip();
				blocText_mc.id = item;
				//
				var titre_txt:TextFieldMultiLines = new TextFieldMultiLines("", DataLoader.couleurTexteNoir);
				titre_txt.name = "titre_txt";
				titre_txt.width = largeurTexte - margeGlobale;
				//
				var type_txt:TextFieldMultiLines = new TextFieldMultiLines("", DataLoader.couleurTexteNoir);
				type_txt.name = "type_txt";
				type_txt.width = largeurTexte - margeGlobale;
				//
				var description_txt:TextFieldMultiLines = new TextFieldMultiLines("", DataLoader.couleurTexteGris);
				description_txt.name = "description_txt";
				description_txt.width = largeurTexte;
				//
				var lien_txt:TextFieldMultiLines = new TextFieldMultiLines("", DataLoader.couleurTexteLien);
				lien_txt.name = "lien_txt";
				lien_txt.width = largeurTexte - margeGlobale;
				//
				var trait:Shape = new Shape();
				trait.name = "trait";
				trait.graphics.lineStyle(0, DataLoader.couleurTexteGris, 1, true,LineScaleMode.NONE);
				trait.graphics.moveTo(0, 0);
				trait.graphics.lineTo(largeurTexte - margeGlobale, 0);
				//
				var title:String = conteneurProjectXml.project[item].name;
				var link:String = conteneurProjectXml.project[item].link;
				var linkTxt:String = Utils.strReplace(link,"http://","");
				var description:String = conteneurProjectXml.project[item].desc;
				var type:String = conteneurProjectXml.project[item].type;
				var image_Thumb:String = conteneurProjectXml.project[item].picture;
				//
				titre_txt.htmlText = type + " | " + title;
				description_txt.htmlText = description;
				lien_txt.htmlText = "<a href='" + link + "'target='_blank'>" + linkTxt + "</a>";
				//
				DataLoader.xmlStyleLoader.appliqueFormat(titre_txt, "AvantGarde-bk-16");
				DataLoader.xmlStyleLoader.appliqueFormat(description_txt, "arial-12");
				DataLoader.xmlStyleLoader.appliqueFormat(lien_txt, "arial-12-italic");
				//
				titre_txt.textColor = DataLoader.couleurTexteNoir;
				description_txt.textColor = DataLoader.couleurTexteGris;
				description_txt.mouseWheelEnabled = false;
				lien_txt.textColor = DataLoader.couleurTexteLien;
				lien_txt.mouseWheelEnabled = false;
				lien_txt.selectable = true;
				lien_txt.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
				lien_txt.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
				//
				description_txt.y = titre_txt.y + titre_txt.height;
				description_txt.text.length == 0 ? lien_txt.y = description_txt.y : lien_txt.y = description_txt.y + description_txt.height - 2;
				trait.y = lien_txt.y + lien_txt.height + 16;
				//
				blocText_mc.addChild(titre_txt);
				blocText_mc.addChild(description_txt);
				blocText_mc.addChild(lien_txt);
				blocText_mc.addChild(trait);
				conteneur_txt.addChild(blocText_mc);
				//
				//TRIX: on passe l url des images a "" histoire de pas les charger
				//image_Thumb = "";
				if (image_Thumb.length != 0) {
					var thumb:EasyLoader = new EasyLoader(image_Thumb, true);
					thumb.name = "thumb";
					thumb.addEventListener(Event.COMPLETE, thumb_Loader);
					blocText_mc.addChild(thumb);
				}else {
					resize();
					checkIfAllLoaded();
				}
			}
		}
		/**
		 * quand tous les flux sont chergés on affiche le tout 
		 */
		private function checkIfAllLoaded():void
		{
			fluxLoaded++;
			if (fluxLoaded >= fluxToLoad) {
				//
				var clearConteneur_txt:Square2 = new Square2(largeurTexte - margeGlobale, 1, 0xFF0000, 0);
				conteneur_txt.addChild(clearConteneur_txt);
				//
				resize();
				buildConteneur_txt();
			}
		}
		
		//	+	retrieve img src from a tag img
		private function extractImgsrc(input:String):String
		{
			var pattern:RegExp =  /\< *[img][^\>]*[src] *= *[\"\']{0,1}([^\"\'\ >]*)/i;
			return pattern.exec(input)[1];
		}
				
		private function thumb_Loader(e:Event):void 
		{
			resize();
			checkIfAllLoaded();			
		}
		
		private function buildConteneur_txt():void
		{
			//
			fondConteneur_txt = new Square2(largeurTexte, hauteurTexte, 0xffffff, 0);
			addChild(fondConteneur_txt);
			addEventListener(MouseEvent.MOUSE_OVER, blockMainScroll);
			addEventListener(MouseEvent.MOUSE_OUT, unBlockMainScroll);
			//
			var maskConteneur_txt:Square2 = new Square2(largeurTexte, hauteurTexte, 0x999999, 0);
			maskConteneur_txt.visible = false;
			addChild(maskConteneur_txt);
			//
			addChild(conteneur_txt);
			//
			addChild(titre);
			addChild(endSquare);
			endSquare.x = titre.width + margeGlobale/2;
			//
			conteneur_txt.y = titre.height + margeGlobale / 2;
			fondConteneur_txt.y = conteneur_txt.y;
			maskConteneur_txt.y = conteneur_txt.y;
			//scroll pomper du web aussi :(
			sc = new Scroll(conteneur_txt, maskConteneur_txt, maskConteneur_txt, false, 6,false, DataLoader.couleurTexteNoir, DataLoader.couleurTexteGris, DataLoader.couleurTexteGrisClair);
			sc.name = "lastProject_scroll";
			sc.x = largeurTexte - sc.width;
			MainFaceB.scrollVector.push(sc);
			addChild(sc);
			//
			sc.y = conteneur_txt.y;
			//
			reelHeight = hauteurTexte + titre.height + 8;
			//
			scrollRect = new Rectangle(0, 0, sc.x + sc.width, reelHeight);
			//
			//le module est construit on renvoi u complete 
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function blockMainScroll(e:MouseEvent):void 
		{
			MainFaceB.scrollGlobal.blocked = true;
		}
		
		private function unBlockMainScroll(e:MouseEvent):void 
		{
			if (fondConteneur_txt.hitTestPoint(stage.mouseX, stage.mouseY, false)) {
			}else {
				MainFaceB.scrollGlobal.blocked = false;
			}
		}
		
		private function mouseOver(e:MouseEvent):void 
		{
			e.target.textColor = DataLoader.couleurTexteGris;
		}
		
		private function mouseOut(e:MouseEvent):void 
		{
			e.target.textColor = DataLoader.couleurTexteLien;
		}
		
		public function apparition(time:Number = 1,_delay:Number = 0, value:Number = 1):void
		{
			TweenMax.to(this, time, {delay:_delay, autoAlpha:value } );
		}
					
		private function resize():void
		{
			for (var i:uint = 0; i < conteneur_txt.numChildren; i++) {
				var precedent:uint = conteneur_txt.getChildIndex(conteneur_txt.getChildAt(i));
				//
				var _text_mc:* = conteneur_txt.getChildAt(i);
				//
				if (_text_mc.getChildByName("thumb")) {
					_text_mc.getChildByName("thumb").y = 30;
					_text_mc.getChildByName("description_txt").x = _text_mc.getChildByName("thumb").width + 4;
					_text_mc.getChildByName("description_txt").width = (largeurTexte - margeGlobale) - (_text_mc.getChildByName("thumb").width + 4);
					_text_mc.getChildByName("lien_txt").y = Math.max(_text_mc.getChildByName("description_txt").y + _text_mc.getChildByName("description_txt").height, _text_mc.getChildByName("thumb").y + _text_mc.getChildByName("thumb").height + 4);
					_text_mc.getChildByName("trait").y = _text_mc.getChildByName("lien_txt").y + _text_mc.getChildByName("lien_txt").height + 16;
				}
				//
				if(precedent == 0){
					_text_mc.y = 0;
				}else {
					_text_mc.y = conteneur_txt.getChildAt(precedent - 1).y + conteneur_txt.getChildAt(precedent - 1).height + 16;
				}
			}
		}
		
	}

}
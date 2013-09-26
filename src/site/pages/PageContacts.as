package site.pages 
{
	import com.greensock.TweenMax;
	import com.shic.displayObjects.Square2;
	import com.shic.displayObjects.TextFieldMultiLines;
	import site.gfx.cartoucheTitre;
	import site.gfx.invCartoucheTitre;
	import site.imageConteneur.ImageConteneur;
	import site.navigation.DataLoader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author lee-o
	 */
	public class PageContacts extends Page
	{
		private static var This:Page;
		private var largeurPage:uint = DataLoader.largeurGlobale;
		private var marge:int = DataLoader.margeGlobale;
		private var largeurCartouche:uint = DataLoader.largeurEncart;
		private var hauteurCartouche:uint = DataLoader.hauteurEncart;
		private var leadingTitre:Number = DataLoader.leadingTitre;
		private var leadingTexte:Number = DataLoader.leadingTexte;
		public var hauteurPage:uint = 316;
		private var conteneur_mc:Square2;
		private var pageXML:XMLList;
		private var numLoaded:uint = 0;
		private var numToLoad:uint;
		private var numAdress:uint;
		//barre de titre noire
		private var titre:cartoucheTitre;
		private var endSquare:invCartoucheTitre;
		private var decalageTri:uint = 24;
		
		public function PageContacts() 
		{
			pageXML = DataLoader.xmlFacebLoader.xml.navigation.contacts;
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE,init)
			}
			This = this;
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
			//
			alpha = 0;
			visible = false;
			//
			//fond de page
			conteneur_mc = new Square2(largeurPage, hauteurPage, DataLoader.couleurTexteNoir, 0);
			addChild(conteneur_mc);
			//
			resize();
			//
			numToLoad = pageXML.contact.length();
			numAdress = pageXML.adress.length();
			//
			for (var t:uint = 0; t < numToLoad; t++) {
				var profilConteneur:Sprite = new Sprite();
				profilConteneur.name = "profilConteneur_" + t;
				conteneur_mc.addChild(profilConteneur);
				profilConteneur.x = t * (largeurCartouche + marge);
				//
				profilConteneur.scrollRect = new Rectangle(0, 0, largeurCartouche, largeurCartouche);
				//
				var picture_mc:ImageConteneur = new ImageConteneur(DataLoader.racine + pageXML.contact[t].picture, largeurCartouche, largeurCartouche);
				picture_mc.name = "picture";
				profilConteneur.addChild(picture_mc);
				picture_mc.addEventListener(Event.COMPLETE, checkIfAllLoaded);
				//
				//on cree le cadre ici
				var cadre:Shape = cadre = new Shape();
				cadre.alpha = 0;
				cadre.name = "cadre";
				cadre.graphics.beginFill(DataLoader.couleurTexteNoir, 0);
				cadre.graphics.lineStyle(marge/8, DataLoader.couleurTexteGrisClair);
				cadre.graphics.drawRect(0, 0, largeurCartouche, largeurCartouche);
				cadre.graphics.endFill();
				profilConteneur.addChild(cadre);
				//
				//fond des textes
				var infoTxt_mc:Sprite = new Sprite();
				infoTxt_mc.name = "infoTxt_mc";
				profilConteneur.addChild(infoTxt_mc);
				var fondInfoTxt_mc:Square2 = new Square2(largeurCartouche, 50, DataLoader.couleurTexteNoir, 0.8);
				fondInfoTxt_mc.name = "fondInfoTxt_mc";
				infoTxt_mc.addChild(fondInfoTxt_mc);
				//
				//nom page
				var nom_txt:TextFieldMultiLines = new TextFieldMultiLines("", DataLoader.couleurTexteNoir);
				nom_txt.name = "nom";
				nom_txt.width = largeurCartouche - marge;
				nom_txt.text = unescape(pageXML.contact[t].name);
				DataLoader.xmlStyleLoader.appliqueFormat(nom_txt, "AvantGarde-bk-16");
				nom_txt.textColor = DataLoader.couleurTexteBlanc;
				infoTxt_mc.addChild(nom_txt);
				nom_txt.x = marge/2;
				//nom_txt.y = 258;
				//nom_txt.rotation = -1;
				//
				//mail page
				var mail_txt:TextFieldMultiLines = new TextFieldMultiLines("", DataLoader.couleurTexteNoir);
				mail_txt.name = "mail";
				mail_txt.width = largeurCartouche - marge;
				mail_txt.htmlText = "<a href='mailto:" + pageXML.contact[t].mail + "'target='_blank'>" + pageXML.contact[t].mail + "</a>";
				DataLoader.xmlStyleLoader.appliqueFormat(mail_txt, "arial-12-italic");
				mail_txt.textColor = DataLoader.couleurTexteBlanc;
				infoTxt_mc.addChild(mail_txt);
				mail_txt.x = marge / 2;
				//
				//tel page
				var tel_txt:TextFieldMultiLines = new TextFieldMultiLines("", DataLoader.couleurTexteNoir);
				tel_txt.name = "tel";
				tel_txt.width = largeurCartouche - marge;
				tel_txt.text = pageXML.contact[t].tel;
				DataLoader.xmlStyleLoader.appliqueFormat(tel_txt, "arial-12");
				tel_txt.textColor = DataLoader.couleurTexteBlanc;
				if (pageXML.contact[t].tel == "") {
					tel_txt.scaleY = 0.1;
				}
				infoTxt_mc.addChild(tel_txt);
				tel_txt.x = marge / 2;
				//
				//tel page
				var link_txt:TextFieldMultiLines = new TextFieldMultiLines("", DataLoader.couleurTexteNoir);
				link_txt.name = "link";
				link_txt.width = largeurCartouche - marge;
				link_txt.htmlText = "<a href='http://" + pageXML.contact[t].link + "'target='_blank'>" + pageXML.contact[t].link + "</a>";
				DataLoader.xmlStyleLoader.appliqueFormat(link_txt, "arial-12-italic");
				link_txt.textColor = DataLoader.couleurTexteBlanc;
				if (pageXML.contact[t].link == "") {
					link_txt.scaleY = 0.1;
				}
				infoTxt_mc.addChild(link_txt);
				link_txt.x = marge / 2;
				//
				//desc page
				var desc_txt:TextFieldMultiLines = new TextFieldMultiLines("", DataLoader.couleurTexteNoir);
				desc_txt.name = "desc";
				desc_txt.width = largeurCartouche - marge;
				desc_txt.text = pageXML.contact[t].desc;
				DataLoader.xmlStyleLoader.appliqueFormat(desc_txt, "arial-12");
				desc_txt.textColor = DataLoader.couleurTexteBlanc;
				if (pageXML.contact[t].desc == "") {
					desc_txt.scaleY = 0.1;
				}
				infoTxt_mc.addChild(desc_txt);
				desc_txt.x = marge / 2;
				//
			}
			
			for (var g:uint = 0; g < numAdress; g++) {
				var adressConteneur:Sprite = new Sprite();
				adressConteneur.name = "adressConteneur_" + g;
				conteneur_mc.addChild(adressConteneur);
				adressConteneur.x = g * (largeurCartouche + marge);
				//
				titre = new cartoucheTitre(pageXML.adress[g].name, "AvantGarde-bk-16", DataLoader.couleurTexteBlanc, DataLoader.couleurTexteNoir, decalageTri, false, true);
				titre.name = "titre";
				endSquare = new invCartoucheTitre(largeurCartouche - (titre.width + marge / 2), titre.height, decalageTri, DataLoader.couleurTexteNoir);
				adressConteneur.addChild(titre);
				adressConteneur.addChild(endSquare);
				endSquare.x = titre.width + marge/2;
				//
				//desc page
				var descA_txt:TextFieldMultiLines = new TextFieldMultiLines("", DataLoader.couleurTexteNoir);
				descA_txt.name = "desc";
				descA_txt.width = largeurCartouche - marge;
				descA_txt.condenseWhite = true;
				descA_txt.htmlText = pageXML.adress[g].desc;
				DataLoader.xmlStyleLoader.appliqueFormat(descA_txt, "arial-12");
				descA_txt.textColor = DataLoader.couleurTexteGris;
				adressConteneur.addChild(descA_txt);
				descA_txt.x = marge / 2;
			}
		}
		
		private function checkIfAllLoaded(e:Event):void
		{
			numLoaded ++;
			if (numLoaded == numToLoad) {
				for (var g:int = 0; g < numToLoad;g++ ) {
					var conteneur:Sprite = conteneur_mc.getChildByName("profilConteneur_" + g) as Sprite;
					var conteneur2:Sprite = conteneur.getChildByName("infoTxt_mc") as Sprite;
					//conteneur.getChildByName("nom").y = conteneur.getChildByName("picture").height + marge / 2;
					//conteneur.getChildByName("desc").y = conteneur.getChildByName("nom").y + leadingTitre;
					//conteneur.getChildByName("tel").y = conteneur.getChildByName("desc").y + leadingTexte;
					//conteneur.getChildByName("mail").y = conteneur.getChildByName("tel").y + (conteneur.getChildByName("tel").scaleY != 0.1 ? leadingTexte: 0);
					//conteneur.getChildByName("link").y = conteneur.getChildByName("mail").y + (conteneur.getChildByName("mail").scaleY != 0.1 ? leadingTexte: 0);
					conteneur2.getChildByName("nom").y = marge / 2;
					conteneur2.getChildByName("desc").y = conteneur2.getChildByName("nom").y + leadingTitre;
					conteneur2.getChildByName("tel").y = conteneur2.getChildByName("desc").y + leadingTexte;
					conteneur2.getChildByName("mail").y = conteneur2.getChildByName("tel").y + (conteneur2.getChildByName("tel").scaleY != 0.1 ? leadingTexte: 0);
					conteneur2.getChildByName("link").y = conteneur2.getChildByName("mail").y + (conteneur2.getChildByName("mail").scaleY != 0.1 ? leadingTexte: 0);
					//
					conteneur2.getChildByName("fondInfoTxt_mc").height = conteneur2.getChildByName("link").y + leadingTexte + marge / 2;
					conteneur.getChildByName("infoTxt_mc").y = largeurCartouche;
					//
					conteneur.addEventListener(MouseEvent.MOUSE_OVER, overCartouche);
					conteneur.addEventListener(MouseEvent.MOUSE_OUT, outCartouche);
					
				}
				//
				for (var s:int = 0; s < numToLoad;s++ ) {
					var conteneurA:Sprite = conteneur_mc.getChildByName("adressConteneur_" + s) as Sprite;
					conteneurA.y = conteneur_mc.getChildByName("profilConteneur_" + s).height + marge;
					//conteneurA.getChildByName("desc").y = conteneurA.getChildByName("nom").y + conteneurA.getChildByName("nom").height;
					conteneurA.getChildByName("desc").y = conteneurA.getChildByName("titre").y + conteneurA.getChildByName("titre").height + marge/2;
				}
				//
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		private function overCartouche(e:MouseEvent):void 
		{
			//TweenMax.to(e.currentTarget, DataLoader.tempsApparition / 2, { colorMatrixFilter: { saturation:1.2 }} );
			TweenMax.to(e.currentTarget.getChildByName("cadre"), DataLoader.tempsApparition / 2, { alpha:1} );
			if(e.currentTarget.getChildByName("infoTxt_mc")){
				TweenMax.to(e.currentTarget.getChildByName("infoTxt_mc"), DataLoader.tempsApparition / 2, { y:e.currentTarget.height - e.currentTarget.getChildByName("infoTxt_mc").height } );
			}
		}
		
		private function outCartouche(e:MouseEvent):void 
		{
			//TweenMax.to(e.currentTarget, DataLoader.tempsApparition / 2, { colorMatrixFilter: { saturation:1 }} );
			TweenMax.to(e.currentTarget.getChildByName("cadre"), DataLoader.tempsApparition / 2, { alpha:0} );
			if(e.currentTarget.getChildByName("infoTxt_mc")){
				TweenMax.to(e.currentTarget.getChildByName("infoTxt_mc"), DataLoader.tempsApparition, { y:e.currentTarget.height } );
			}
		}
		
		public override function apparition(e:Event = null):void 
		{
			TweenMax.to(This, DataLoader.tempsApparition, { autoAlpha:1 } );
		}
		
		public override function resize(e:Event = null):void
		{
			if (conteneur_mc && this.contains(conteneur_mc)) {
				conteneur_mc.x =  stage.stageWidth / 2 - largeurPage / 2;
			}
		}
		
		private function destroy(e:Event):void 
		{
			TweenMax.killTweensOf(this);
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
		}
		
	}

}
package site.pages 
{
	import com.greensock.TweenMax;
	import com.shic.displayObjects.Square2;
	import com.shic.displayObjects.TextFieldMultiLines;
	import site.imageConteneur.ImageConteneur;
	import site.navigation.DataLoader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Rectangle;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author lee-o
	 */
	public class PageReferences extends Page
	{
		private static var This:Page;
		private var largeurPage:uint = DataLoader.largeurGlobale;
		private var marge:int = DataLoader.margeGlobale;
		private var largeurCartouche:uint = DataLoader.largeurEncart;
		private var hauteurCartouche:uint = DataLoader.hauteurEncart;
		public var hauteurPage:uint = 50;
		private var conteneur_mc:Square2;
		private var pageXML:XMLList;
		private var numLoaded:uint = 0;
		private var numToLoad:uint;
		private var X:int = 0;
		//
		private var leadingTitre:Number = DataLoader.leadingTitre;
		private var leadingTexte:Number = DataLoader.leadingTexte;
		//ICI Y EST HERITEE DE PAGE.AS
		//public var Y:int = 0;
		//
		//
		private var hauteurLineTxt:int = DataLoader.hauteurLineTxt;
		
		public function PageReferences() 
		{
			pageXML = DataLoader.xmlFacebLoader.xml.navigation.references;
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
			numToLoad = pageXML.reference.length();
			//
			for (var t:uint = 0; t < numToLoad; t++) {
				var isInfoTxt_mc:Boolean = false;
				var profilConteneur:Sprite = new Sprite();
				profilConteneur.name = "profilConteneur_" + t;
				conteneur_mc.addChild(profilConteneur);
				if (X >= 3) {
					X = 0;
					Y++;
				}
				profilConteneur.x = X * (largeurCartouche + marge);
				profilConteneur.y = Y * (largeurCartouche + marge);
				X ++;
				//
				profilConteneur.scrollRect = new Rectangle(0, 0, largeurCartouche, largeurCartouche);
				//
				//var picture_mc:ImageConteneur = new ImageConteneur(DataLoader.racine + pageXML.reference[t].picture, largeurCartouche, largeurCartouche,true,DataLoader.margeGlobale,DataLoader.couleurTexteGrisClair);
				var picture_mc:ImageConteneur = new ImageConteneur(DataLoader.racine + pageXML.reference[t].picture, largeurCartouche, largeurCartouche);
				picture_mc.name = "picture";
				profilConteneur.addChild(picture_mc);
				picture_mc.addEventListener(Event.COMPLETE, checkIfAllLoaded);
				//
				//texte de encarts
				//
				//fond des textes
				var infoTxt_mc:Sprite = new Sprite();
				infoTxt_mc.name = "infoTxt_mc";
				profilConteneur.addChild(infoTxt_mc);
				//
				var fondInfoTxt_mc:Square2 = new Square2(largeurCartouche, 50, DataLoader.couleurTexteNoir, 0.8);
				fondInfoTxt_mc.name = "fondInfoTxt_mc";
				infoTxt_mc.addChild(fondInfoTxt_mc);
				//nom page
				var nom_txt:TextFieldMultiLines = new TextFieldMultiLines("", DataLoader.couleurTexteNoir);
				nom_txt.name = "nom";
				nom_txt.width = largeurCartouche - marge;
				nom_txt.text = unescape(pageXML.reference[t].name);
				infoTxt_mc.addChild(nom_txt);
				if (pageXML.reference[t].name == "") {
					nom_txt.scaleY = 0.1;
				}else {
					isInfoTxt_mc = true;
				}
				nom_txt.x = marge/2;
				//
				//type
				var type_txt:TextFieldMultiLines = new TextFieldMultiLines("", DataLoader.couleurTexteNoir);
				type_txt.name = "type";
				type_txt.width = largeurCartouche - marge;
				type_txt.htmlText = pageXML.reference[t].type;
				infoTxt_mc.addChild(type_txt);
				if (pageXML.reference[t].type == "") {
					type_txt.scaleY = 0.1;
				}else {
					isInfoTxt_mc = true;
				}
				type_txt.x = marge / 2;
				//
				//desc page
				var desc_txt:TextFieldMultiLines = new TextFieldMultiLines("", DataLoader.couleurTexteNoir);
				desc_txt.name = "desc";
				desc_txt.width = largeurCartouche - marge;
				desc_txt.htmlText = pageXML.reference[t].desc;
				infoTxt_mc.addChild(desc_txt);
				if (pageXML.reference[t].desc == "") {
					desc_txt.scaleY = 0.1;
				}else {
					isInfoTxt_mc = true;
				}
				desc_txt.x = marge / 2;
				//
				//realisation page
				var real_txt:TextFieldMultiLines = new TextFieldMultiLines("", DataLoader.couleurTexteNoir);
				real_txt.name = "real";
				real_txt.width = largeurCartouche - marge;
				if(pageXML.reference[t].lienRealisation != ""){
					real_txt.htmlText = "Réalisation:<a href='http://" + pageXML.reference[t].lienRealisation + "' target='_blank'> " + " " + pageXML.reference[t].realisation + "</a>";
				}else {
					real_txt.htmlText = "Réalisation: " + pageXML.reference[t].realisation;
				}
				real_txt.textColor = DataLoader.couleurTexteGrisClair;
				infoTxt_mc.addChild(real_txt);
				if (pageXML.reference[t].realisation == "") {
					real_txt.htmlText = "";
					real_txt.scaleY = 0.1;
				}else {
					isInfoTxt_mc = true;
				}
				real_txt.x = marge / 2;
				//
				//production page
				var prod_txt:TextFieldMultiLines = new TextFieldMultiLines("", DataLoader.couleurTexteNoir);
				prod_txt.name = "prod";
				prod_txt.width = largeurCartouche - marge;
				if(pageXML.reference[t].lienProduction != ""){
					prod_txt.htmlText = "Production:<a href='http://" + pageXML.reference[t].lienProduction + "' target='_blank'> " + " " + pageXML.reference[t].production + "</a>";
				}else {
					prod_txt.htmlText = "Production: " + pageXML.reference[t].production;
				}
				prod_txt.textColor = DataLoader.couleurTexteGrisClair;
				infoTxt_mc.addChild(prod_txt);
				if (pageXML.reference[t].production == "") {
					prod_txt.htmlText = "";
					prod_txt.scaleY = 0.1;
				}else {
					isInfoTxt_mc = true;
				}
				prod_txt.x = marge / 2;
				//
				//
				if (isInfoTxt_mc == false) {
					profilConteneur.removeChild(infoTxt_mc);
				}
				//
				var cadre:Shape = new Shape();
				cadre.alpha = 0;
				cadre.name = "cadre";
				cadre.graphics.beginFill(DataLoader.couleurTexteNoir, 0);
				cadre.graphics.lineStyle(marge/4, DataLoader.couleurTexteGrisClair);
				cadre.graphics.drawRect(0, 0, largeurCartouche, largeurCartouche);
				cadre.graphics.endFill();
				profilConteneur.addChild(cadre);
			}
			
		}
		
		private function checkIfAllLoaded(e:Event):void
		{
			//e.target.filters = [BW];
			TweenMax.to(e.target,0, {colorMatrixFilter:{saturation:0}});
			numLoaded ++;
			if (numLoaded == numToLoad) {
				for (var g:int = 0; g < numToLoad;g++ ) {
					var conteneur:Sprite = conteneur_mc.getChildByName("profilConteneur_" + g) as Sprite;
					//
					//
					if(conteneur.getChildByName("infoTxt_mc")){
						var conteneurTxt:Sprite = conteneur.getChildByName("infoTxt_mc") as Sprite;					
						var nom_txt:TextFieldMultiLines = conteneurTxt.getChildByName("nom") as TextFieldMultiLines;
						var type_txt:TextFieldMultiLines = conteneurTxt.getChildByName("type") as TextFieldMultiLines;
						var desc_txt:TextFieldMultiLines = conteneurTxt.getChildByName("desc") as TextFieldMultiLines;
						var real_txt:TextFieldMultiLines = conteneurTxt.getChildByName("real") as TextFieldMultiLines;
						var prod_txt:TextFieldMultiLines = conteneurTxt.getChildByName("prod") as TextFieldMultiLines;
						//
						/*nom_txt.y = marge / 2;
						type_txt.y = nom_txt.y + nom_txt.numLines * hauteurLineTxt;
						desc_txt.y = type_txt.y + type_txt.numLines * hauteurLineTxt;
						real_txt.y = desc_txt.y + desc_txt.numLines * hauteurLineTxt;
						prod_txt.y = real_txt.y + real_txt.numLines * hauteurLineTxt;*/
						//
						DataLoader.xmlStyleLoader.appliqueFormat(nom_txt, "AvantGarde-bk-16");
						DataLoader.xmlStyleLoader.appliqueFormat(type_txt, "arial-12");
						DataLoader.xmlStyleLoader.appliqueFormat(desc_txt, "arial-12");
						DataLoader.xmlStyleLoader.appliqueFormat(real_txt, "arial-12-italic");
						DataLoader.xmlStyleLoader.appliqueFormat(prod_txt, "arial-12-italic");
						//
						//nom_txt.border = type_txt.border = desc_txt.border = real_txt.border = prod_txt.border = true;
						//
						nom_txt.y = marge / 2;
						type_txt.y = nom_txt.y + leadingTitre;
						desc_txt.y = type_txt.y + leadingTexte;
						real_txt.y = desc_txt.y + leadingTexte;
						if (desc_txt.numLines > 1) {
							real_txt.y = desc_txt.y + leadingTexte*desc_txt.numLines;
						}else {
							if(desc_txt.htmlText.length != 0){
								real_txt.y = desc_txt.y + leadingTexte;
							}else {
								real_txt.y = desc_txt.y;
							}
						}
						if(real_txt.htmlText.length != 0){
							prod_txt.y = real_txt.y + leadingTexte;
						}else {
							prod_txt.y = real_txt.y;
						}
						if (prod_txt.htmlText.length == 0) prod_txt.height = 0;
						//
						//
						nom_txt.textColor = DataLoader.couleurTexteBlanc;
						type_txt.textColor = DataLoader.couleurTexteBlanc;
						desc_txt.textColor = DataLoader.couleurTexteBlanc;
						real_txt.textColor = DataLoader.couleurTexteBlanc;
						prod_txt.textColor = DataLoader.couleurTexteBlanc;
						//
						//conteneurTxt.getChildByName("fondInfoTxt_mc").height = prod_txt.y + prod_txt.numLines * hauteurLineTxt + marge / 2;
						conteneurTxt.getChildByName("fondInfoTxt_mc").height = prod_txt.y + prod_txt.height + marge / 2;
						conteneurTxt.y = largeurCartouche;
					}
					//
					//
					conteneur.addEventListener(MouseEvent.MOUSE_OVER, overCartouche);
					conteneur.addEventListener(MouseEvent.MOUSE_OUT, outCartouche);
					
				}
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		private function overCartouche(e:MouseEvent):void 
		{
			//e.currentTarget.getChildByName("picture").filters = [];
			TweenMax.to(e.currentTarget.getChildByName("picture"), DataLoader.tempsApparition / 2, { colorMatrixFilter: { saturation:1 }} );
			TweenMax.to(e.currentTarget.getChildByName("cadre"), DataLoader.tempsApparition / 2, { alpha:1} );
			if(e.currentTarget.getChildByName("infoTxt_mc")){
				TweenMax.to(e.currentTarget.getChildByName("infoTxt_mc"), DataLoader.tempsApparition / 2, { y:e.currentTarget.height - e.currentTarget.getChildByName("infoTxt_mc").height } );
			}
		}
		
		private function outCartouche(e:MouseEvent):void 
		{
			//e.currentTarget.getChildByName("picture").filters = [BW];
			TweenMax.to(e.currentTarget.getChildByName("picture"), DataLoader.tempsApparition / 2, { colorMatrixFilter: { saturation:0 }} );
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
			//
			for (var g:int = 0; g < numToLoad;g++ ) {
				var conteneur:Sprite = conteneur_mc.getChildByName("profilConteneur_" + g) as Sprite;
				conteneur.removeEventListener(MouseEvent.MOUSE_OVER, overCartouche);
				conteneur.removeEventListener(MouseEvent.MOUSE_OUT, outCartouche);
			}
			//
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
		}
		
	}

}
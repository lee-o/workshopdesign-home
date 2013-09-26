package site.pages 
{
	import com.shic.displayObjects.Square;
	import com.shic.utils.EasyLoader;
	import com.greensock.TweenMax;
	import com.shic.displayObjects.TextFieldMonoLine;
	import com.shic.utils.EasyLoaderEvent;
	import com.shic.utils.Utils;
	import com.thinkadelik.displayObjects.ImageConteneur;
	import com.thinkadelik.stat.Ga;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import site.navigation.DataLoader;
	import site.ui.simpleBtn;
	/**
	 * ...
	 * @author ...
	 */
	public class ModuleProduct extends ContenuPage
	{
		private var xml:XMLList;
		private var XX:uint = 0;
		private var YY:uint = 0;
		private var conteneur:Sprite;
		private var spaceX:uint = 192;
		private var spaceY:uint = 120;
		private var imgLoaded:uint = 0;
		private var contenuXml:XMLList;
		private	var nbreRefs:uint;
		
		public function ModuleProduct(_xml:XMLList) 
		{
			visible = false;
			alpha = 0;
			xml = _xml;
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
			
			contenuXml = xml.child("ref");
			//trace(contenuXml)
			nbreRefs = contenuXml.length();
			//
			var titre:TextFieldMonoLine = new TextFieldMonoLine(xml.name);
			//trace(xml.name)
			DataLoader.xmlStyleLoader.appliqueFormat(titre, "Helvetica-Neue-Lt-Std-Thin");
			var sizeTitreFormat:TextFormat = new TextFormat();
			sizeTitreFormat.size = sizeTitre;
			titre.setTextFormat(sizeTitreFormat);
			titre.textColor = DataLoader.couleurTexteBlanc;
			//
			var trait:Shape = new Shape();
			trait.graphics.beginFill(0xff0000, 1);
			trait.graphics.lineStyle(0, DataLoader.couleurTrait, 1);
			trait.graphics.lineTo(DataLoader.largeurPage - DataLoader.margeGlobale * 2,0);
			trait.graphics.endFill();
			//
			conteneur = new Sprite();
			//
			for (var p:uint = 0; p < nbreRefs; p++)
			{
				var contenu:MovieClip = new MovieClip();
				contenu.link = "http://" + contenuXml[p].link;
				contenu.type = contenuXml[p].@["type"];
				contenu.name = contenuXml[p].name;
				//
				var titre_mc:TextFieldMonoLine = new TextFieldMonoLine(contenuXml[p].name);
				DataLoader.xmlStyleLoader.appliqueFormat(titre_mc, "Helvetica-Neue-Lt-Std-Light");
				var sizeTitreMcFormat:TextFormat = new TextFormat();
				sizeTitreMcFormat.size = sizeTexte;
				titre_mc.setTextFormat(sizeTitreMcFormat);
				titre_mc.sharpness = 0;
				titre_mc.textColor = DataLoader.couleurTexteBlanc;
				//
				var sousTrait:Shape = new Shape();
				sousTrait.graphics.beginFill(0xff0000, 1);
				sousTrait.graphics.lineStyle(0, DataLoader.couleurTrait, 1);
				sousTrait.graphics.lineTo(spaceX,0);
				sousTrait.graphics.endFill();
				sousTrait.y = spaceY - 6;
				//
				var link_mc:TextFieldMonoLine = new TextFieldMonoLine("view");
				DataLoader.xmlStyleLoader.appliqueFormat(link_mc, "Helvetica-Neue-Lt-Std-Light");
				sizeTitreMcFormat.size = sizeTexte;
				link_mc.setTextFormat(sizeTitreMcFormat);
				link_mc.sharpness = 0;
				link_mc.textColor = DataLoader.couleurTexteLien;
				link_mc.x = spaceX - link_mc.width;
				link_mc.y = spaceY - link_mc.height / 2;
				//
				var link_btn:simpleBtn = new simpleBtn(link_mc.width, link_mc.height, "http://" + contenuXml[p].link);
				link_btn.alpha = 0;
				link_btn.x = link_mc.x;
				link_btn.y = link_mc.y;
				//
				var img:ImageConteneur = new ImageConteneur(DataLoader.racine + contenuXml[p].picture,10,10,true,false,0,0x000000);
				img.addEventListener(Event.COMPLETE, checkIfAllLoaded);
				img.y = titre_mc.height + 4;
				TweenMax.to(img, 0, { colorMatrixFilter: { colorize:0x000000, amount:0.4, saturation:0.7 }} );
				//
				link_btn.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				img.mouseChildren = false;
				img.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
				img.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
				img.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				//
				contenu.x = XX * spaceX + DataLoader.margeGlobale*XX;
				contenu.y = YY * spaceY;
				//
				if (XX >= 1) {
					XX = 0;
					YY ++;
				}else {
					XX ++;
				}
				//
				contenu.addChild(titre_mc);
				contenu.addChild(link_mc);
				contenu.addChild(sousTrait);
				contenu.addChild(img);
				contenu.addChild(link_btn);
				conteneur.addChild(contenu);
			}
			//
			titre.x = titre.y = trait.x = conteneur.x = DataLoader.margeGlobale;
			trait.y = titre.y + titre.height;
			conteneur.y = trait.y + 8;
			//
			addChild(titre);
			addChild(trait);
			addChild(conteneur);
		}
		
		private function checkIfAllLoaded(e:Event):void 
		{
			imgLoaded++;
			if (imgLoaded == nbreRefs) {
				//TweenMax.to(this, DataLoader.tempsApparition, { autoAlpha:1 } );
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		private function mouseUpHandler(e:MouseEvent):void 
		{
			MainWorkshopDesign.MainPause();
			Utils.openExternalPage(e.target.parent.link);
			/*var obj:Object = new Object();
			obj.type = e.target.parent.type;
			obj.name = e.target.parent.name;
			Ga.track("Event", obj);*/
			Ga.Event(e.target.parent.type, e.target.parent.name);
		}
		
		private function rollOutHandler(e:MouseEvent):void 
		{
			TweenMax.to(e.target, DataLoader.tempsApparition, { colorMatrixFilter: { colorize:0x000000, amount:0.4, saturation:0.7 }} );
		}
		
		private function rollOverHandler(e:MouseEvent):void 
		{
			TweenMax.to(e.target, DataLoader.tempsApparition/4, { colorMatrixFilter: { colorize:0x000000, amount:0, saturation:1 }} );
		}
		
		public override function apparition():void {
			TweenMax.to(this, DataLoader.tempsApparition, { autoAlpha:1 } );
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			TweenMax.killTweensOf(this);
			
		}
	}

}
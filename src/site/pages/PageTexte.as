package site.pages 
{
	import com.greensock.TweenMax;
	import com.shic.displayObjects.Square;
	import com.shic.displayObjects.TextFieldMonoLine;
	import com.shic.displayObjects.TextFieldMultiLines;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.text.TextFormat;
	import site.navigation.DataLoader;
	/**
	 * ...
	 * @author ...
	 */
	public class PageTexte extends ContenuPage
	{
		private var xml:XMLList;
		private var footer:Square;
		
		public function PageTexte(_xml:XMLList,_type:String) 
		{
			visible = false;
			alpha = 0;
			//trace("In --> PageTexte : " + _type);
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
			var contenuXml:XMLList = xml.children().(@type == TYPE);
			//
			var titre:TextFieldMonoLine = new TextFieldMonoLine(contenuXml.name);
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
			var txt:TextFieldMultiLines = new TextFieldMultiLines(contenuXml.description);
			DataLoader.xmlStyleLoader.appliqueFormat(txt, "Helvetica-Neue-Lt-Std-Light");
			var sizeTxtFormat:TextFormat = new TextFormat();
			sizeTxtFormat.size = sizeTexte;
			sizeTxtFormat.align = "justify";
			txt.setTextFormat(sizeTxtFormat);
			txt.sharpness = 0;
			txt.textColor = DataLoader.couleurTexteBlanc;
			txt.width = DataLoader.largeurPage - DataLoader.margeGlobale * 2;
			//
			titre.x = txt.x = titre.y = trait.x = DataLoader.margeGlobale;
			trait.y = titre.y + titre.height;
			txt.y = trait.y + 8;
			//
			addChild(titre);
			addChild(trait);
			addChild(txt);
			//
			footer = new Square(10, 50, 0x006699, 0.6);
			footer.y = txt.y + txt.height;
			footer.alpha = 0;
			addChild(footer);
			//
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public override function apparition():void {
			//trace("pageTexte apparition");
			TweenMax.to(this, DataLoader.tempsApparition, { autoAlpha:1 } );
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			TweenMax.killTweensOf(this);
			
		}
	}

}
package cc.shic.display.text{

	import cc.shic.xml.EasyXml;
	import cc.shic.xml.EasyXmlEvent;
	import flash.events.*;
	import flash.net.*;
	import flash.display.*;
	import flash.text.*;
	import flash.utils.*;
	
	/////////
	public class TextStyle extends Sprite
	{
		public var xmlUrl:String;
		public var xml:XML;
		public var styles:Vector.<TextStyleFormat> = new Vector.<TextStyleFormat>();
		
		[Event(name = "complete", type = "cc.shic.xml.EasyXmlEvent")]
		/**
		 * La classe TextStyle permet de charger des définition de styles mêlant TextFormat et Propriétés de champ texte depuis un xml.
		 */
		public function TextStyle() {
			
		}
		/**
		 * Charge le fichier xml de définition des styles depuis l'URL définie par xmlUrl.
		 * @param	xmlUrl
		 */
		public function loadStyles(xmlUrl:String):void {
			this.xmlUrl = xmlUrl;
			var xmlLoader:EasyXml = new EasyXml(xmlUrl);
			xmlLoader.addEventListener(EasyXmlEvent.COMPLETE, onXml);
		}
		/**
		 * réception
		 * @param	event
		 */
		public function onXml (e:EasyXmlEvent):void {
			
			e.target.removeEventListener ("complete", onXml);
			xml = e.xml;
			createStyles();
			dispatchEvent(e);
			
		}
		
		private function createStyles():void
		{
			var list:XMLList = xml.children();
			for (var i:int = 0; i < list.length(); i++) {
				var ts:TextStyleFormat = new TextStyleFormat(list[i]);
				styles.push(ts);
			}
		}
		/**
		 * retourne un TextStyleFormat à partir de son nom.
		 * @param	name
		 * @return
		 */
		public function getStyleByName(name:String):TextStyleFormat {
			for (var i:int; i < styles.length; i++) {
				if (styles[i].name == name) {
					return styles[i];
				}
			}
			return null;
		}
		
		/**
		 * applique le format style (défini sous le même nom dans le xml) à txt.
		 * @param	txt
		 * @param	style
		 */
		public function appliqueFormat (txt:TextField, style:String):void {
			
			var ts:TextStyleFormat = getStyleByName(style);
			if (!ts) {
				var error:TextFormat=new TextFormat;
				error.color=0xff0000;
				error.bold=true;
				error.size=12;
				txt.embedFonts=false;
				txt.text="style not defined in xml! "+txt.text;
				txt.setTextFormat (error);
				return;
			}else {
				ts.applyTo(txt);
			}
			/*
			if (xml[style].length()<=0) {
				var error:TextFormat=new TextFormat;
				error.color=0xff0000;
				error.bold=true;
				error.size=12;
				txt.embedFonts=false;
				txt.text="style not defined in xml! "+txt.text;
				txt.setTextFormat (error);
				return;
			}
			var tf:TextFormat=new TextFormat();
			txt.embedFonts=false;
			var i: int;
			var nodeName:String;
			for (i=0; i<xml[style].children().length(); i++) {
				nodeName = xml[style].children()[i].name();
				switch (nodeName) {
					case "italic" :
						tf[nodeName]=Utils.getBool(xml[style][nodeName]);
						break;

					case "bold" :
						tf[nodeName]=Utils.getBool(xml[style][nodeName]);
						break;

					case "underline" :
						tf[nodeName]=Utils.getBool(xml[style][nodeName]);
						break;

					case "bullet" :
						tf[nodeName]=Utils.getBool(xml[style][nodeName]);
						break;

					case "kerning" :
						tf[nodeName]=Utils.getBool(xml[style][nodeName]);
						break;

					case "font" :
						tf[nodeName]=unescape(xml[style][nodeName]);
						break;

					case "size" :
						tf[nodeName]=Number(xml[style][nodeName]);
						break;

					case "color" :
						tf[nodeName]=Number(xml[style][nodeName]);
						break;

					case "letterSpacing" :
						tf[nodeName]=Number(xml[style][nodeName]);
						break;


					case "leading" :
						tf[nodeName]=xml[style][nodeName];
						break;

					case "align" :
						tf[nodeName]=String(xml[style][nodeName]);
						break;

					case "leftMargin" :
						tf[nodeName]=Number(xml[style][nodeName]);
						break;

					case "rightMargin" :
						tf[nodeName]=Number(xml[style][nodeName]);
						break;

					case "tabStops" :
						tf[nodeName]=String(xml[style][nodeName]).split(",");
						break;

					case "indent" :
						tf[nodeName]=Number(xml[style][nodeName]);
						break;

					case "blockIndent" :
						tf[nodeName]=Number(xml[style][nodeName]);
						break;

					case "embedFonts" :
						txt[nodeName]=Utils.getBool(xml[style][nodeName]);					
						break;
						
					case "antiAliasType":
						txt[nodeName]=String(xml[style][nodeName]);
						break;
						
					case "gridFitType":
						txt[nodeName]=String(xml[style][nodeName]);
						break;
						
					case "sharpness":
						txt[nodeName]=Number(xml[style][nodeName]);
						break;
						
					case "border" :
						txt[nodeName]=Utils.getBool(xml[style][nodeName]);
						break;

					case "background" :
						txt[nodeName]=Utils.getBool(xml[style][nodeName]);
						break;

					case "borderColor" :
						txt[nodeName]=Number(xml[style][nodeName]);
						break;

					case "backgroundColor" :
						txt[nodeName]=Number(xml[style][nodeName]);
						break;
				}
			}
			txt.setTextFormat (tf);
			*/
		}
		
	}
}
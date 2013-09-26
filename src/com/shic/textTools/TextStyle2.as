package com.shic.textTools{

	import com.shic.utils.Utils;
	import flash.events.*;
	import flash.net.*;
	import flash.display.*;
	import flash.text.*;
	import flash.utils.*;
	
	/////////
	public class TextStyle2 extends Sprite
	{
		public var urlXML:String;
		public var styles_XML:XML;
		//
		[Event(name = "complete", type = "flash.events.Event")]
		//
		public function TextStyle2(styleUrl:String) {
			getStyles(styleUrl);
		}
		
		/////charger le xml des styles
		public function getStyles (p_urlXML:String):void {
			urlXML = p_urlXML;
			var myXML:XML = new XML();
			var myXMLURL:URLRequest = new URLRequest(urlXML);
			var myLoader:URLLoader = new URLLoader(myXMLURL);
			myLoader.addEventListener(Event.COMPLETE,on_XML);
		}
		/////réception du xml
		public function on_XML (event:Event):void {
			event.target.removeEventListener (Event.COMPLETE, on_XML);
			styles_XML = XML(event.target.data);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		//////appliquer un formatage
		public function appliqueFormat (t_txt:TextField, style:String):void {
			////
			if (styles_XML[style].length()<=0) {
				var error:TextFormat=new TextFormat;
				error.color=0xff0000;
				error.bold=true;
				error.size=12;
				t_txt.embedFonts=false;
				t_txt.text="style not defined in xml! "+t_txt.text;
				t_txt.setTextFormat (error);
				return;
			}
			////
			var tf:TextFormat=new TextFormat();
			t_txt.embedFonts=false;
			var i: int;
			var nom_noeud:String;
			for (i=0; i<styles_XML[style].children().length(); i++) {
				nom_noeud = styles_XML[style].children()[i].name();
				switch (nom_noeud) {
					case "italic" :
						tf[nom_noeud]=Utils.getBool(styles_XML[style][nom_noeud]);
						break;

					case "bold" :
						tf[nom_noeud]=Utils.getBool(styles_XML[style][nom_noeud]);
						break;

					case "underline" :
						tf[nom_noeud]=Utils.getBool(styles_XML[style][nom_noeud]);
						break;

					case "bullet" :
						tf[nom_noeud]=Utils.getBool(styles_XML[style][nom_noeud]);
						break;

					case "kerning" :
						tf[nom_noeud]=Utils.getBool(styles_XML[style][nom_noeud]);
						break;

					case "font" :
						tf[nom_noeud]=unescape(styles_XML[style][nom_noeud]);
						break;

					case "size" :
						tf[nom_noeud]=Number(styles_XML[style][nom_noeud]);
						break;

					case "color" :
						tf[nom_noeud]=Number(styles_XML[style][nom_noeud]);
						break;

					case "letterSpacing" :
						tf[nom_noeud]=Number(styles_XML[style][nom_noeud]);
						break;


					case "leading" :
						tf[nom_noeud]=styles_XML[style][nom_noeud];
						break;

					case "align" :
						tf[nom_noeud]=String(styles_XML[style][nom_noeud]);
						break;

					case "leftMargin" :
						tf[nom_noeud]=Number(styles_XML[style][nom_noeud]);
						break;

					case "rightMargin" :
						tf[nom_noeud]=Number(styles_XML[style][nom_noeud]);
						break;

					case "tabStops" :
						tf[nom_noeud]=String(styles_XML[style][nom_noeud]).split(",");
						break;

					case "indent" :
						tf[nom_noeud]=Number(styles_XML[style][nom_noeud]);
						break;

					case "blockIndent" :
						tf[nom_noeud]=Number(styles_XML[style][nom_noeud]);
						break;

					case "embedFonts" :
						t_txt[nom_noeud]=Utils.getBool(styles_XML[style][nom_noeud]);					
						break;
						
					case "antiAliasType":
						t_txt[nom_noeud]=String(styles_XML[style][nom_noeud]);
						break;
						
					case "gridFitType":
						t_txt[nom_noeud]=String(styles_XML[style][nom_noeud]);
						break;
						
					case "sharpness":
						t_txt[nom_noeud]=Number(styles_XML[style][nom_noeud]);
						break;
						
					case "border" :
						t_txt[nom_noeud]=Utils.getBool(styles_XML[style][nom_noeud]);
						break;

					case "background" :
						t_txt[nom_noeud]=Utils.getBool(styles_XML[style][nom_noeud]);
						break;

					case "borderColor" :
						t_txt[nom_noeud]=Number(styles_XML[style][nom_noeud]);
						break;

					case "backgroundColor" :
						t_txt[nom_noeud]=Number(styles_XML[style][nom_noeud]);
						break;

				}
			}
			t_txt.setTextFormat (tf);
		}
	}
}
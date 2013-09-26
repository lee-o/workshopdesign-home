package site.navigation 
{
	import com.shic.textTools.TextStyle2;
	import com.shic.utils.EasyXml;
	import com.shic.utils.EasyXmlEvent;
	import site.events.DataLoaderEvent;
	import MainWorkshopDesign;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author lee-o
	 */
	public class DataLoader  extends EventDispatcher
	{
		public static var racine:String;
		public static var langcode:String;
		private var xmlRssUrl:String;
		private var xmlStyleUrl:String;
		private var xmlWsdUrl:String;
		
		public static var xmlStyleLoader:TextStyle2;
		public static var xmlRssLoader:EasyXml;
		public static var xmlWsdLoader:EasyXml;
		
		private var filesLoaded:uint = 0;
		private var filesToLoad:uint = 2;
		
		public static var couleurTexteBlanc:Number = 0xFFFFFF;
		public static var couleurTexteNoir:Number = 0x000000;
		public static var couleurTexteGris:Number = 0x333333;
		public static var couleurTexteLien:Number = 0x999999;
		public static var couleurTexteGrisClair:Number = 0xEFEFEF;
		public static var couleurFond:Number = 0x111111;
		public static var alphaFond:Number = 0.85;
		public static var couleurTrait:Number = 0x666666;
		
		public static var tempsApparition:Number = 1;
		
		public static var largeurGlobale:uint = 992;
		public static var hauteurGlobale:uint = 680;
		public static var largeurEncart:uint = 320;
		public static var hauteurEncart:uint = 292;
		public static var largeurPage:uint = 430;
		public static var margeGlobale:uint = 16;
		public static var margeBordure:uint = 24;
		//defini la hauteur d une ligne moyenne pour les champ texte pour regler les prbs de decalage en hauteur
		public static var leadingTitre:Number = 22;
		public static var leadingTexte:Number = 20;
		public static var hauteurLineTxt:int = 24;
		//
		public static var gaCode:String;
		
		[Event(name = "ready", type = "flash.events.DataLoaderEvent")]
		
		public function DataLoader() 
		{
			defineInitVars();
			
		}
		
		private function loadData():void
		{
			//xml textes styles
			xmlStyleLoader = new TextStyle2(xmlStyleUrl);
			xmlStyleLoader.addEventListener(Event.COMPLETE, xmlStyleLoaderHandler);
			//
			//xml workshopdesign
			xmlWsdLoader = new EasyXml(xmlWsdUrl);
			xmlWsdLoader.addEventListener(EasyXmlEvent.COMPLETE, xmlWsdLoaderHandler);
			//
			//xml rss
			//xmlRssLoader = new EasyXml(xmlRssUrl);
			//xmlRssLoader.addEventListener(EasyXmlEvent.COMPLETE, fluxRSSLoaderHandler);
			//
		}
		
		/*private function fluxRSSLoaderHandler(e:Event):void 
		{
			checkIfAllLoaded();
		}*/
		
		private function xmlStyleLoaderHandler(e:Event):void 
		{
			checkIfAllLoaded();
		}
		
		private function xmlWsdLoaderHandler(e:Event):void 
		{
			checkIfAllLoaded();
		}
		
		private function checkIfAllLoaded():void
		{
			filesLoaded++;
			if (filesLoaded >= filesToLoad) {
				dispatchEvent(new DataLoaderEvent(DataLoaderEvent.READY));
			}
		}
		
		/**
		 * définit les variables afin de démarer l'application (lang code, xmls etc...)
		 */
		private function defineInitVars():void
		{
			if (MainWorkshopDesign.root.loaderInfo.parameters.racine) {
				racine = MainWorkshopDesign.root.loaderInfo.parameters.racine;
				langcode = MainWorkshopDesign.root.loaderInfo.parameters.langcode;
				//xmlRssUrl = racine + "blog/feed/";
				xmlStyleUrl = racine + "/xml/textsStyle." + langcode + ".xml";
				xmlWsdUrl = racine + "/php/getXML.php?langcode=" + langcode + "&foo=" + Math.random();
			}else {
				racine = "http://www.workshopdesign-home.com";
				langcode = "fr";
				//xmlRssUrl = racine + "blog/feed/";
				xmlStyleUrl = racine + "/xml/textsStyle." + langcode + ".xml";
				xmlWsdUrl = racine + "/php/getXML.php";
			}
			gaCode = "UA-20017065-1";
			//
			loadData();
		}
		
	}

}
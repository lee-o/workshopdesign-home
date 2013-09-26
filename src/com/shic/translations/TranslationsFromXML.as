package com.shic.translations 
{
	import com.shic.utils.EasyXml;
	import com.shic.utils.EasyXmlEvent;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author shic
	 */
	public class TranslationsFromXML extends EventDispatcher
	{
		/**
		 * l'objet xml contenant les traductions
		 */
		public var xml:XML;
		/**
		 * 
		 * @param	xmlURL
		 */
		public function TranslationsFromXML(xmlURL:String) 
		{
			var xmlLoader:EasyXml = new EasyXml(xmlURL);
			xmlLoader.addEventListener(EasyXmlEvent.COMPLETE, onXMLLoaded);
		}
		
		
		[Event(name="complete", type="flash.events.Event")]
		private function onXMLLoaded(e:EasyXmlEvent):void 
		{
			xml = e.xml;
			dispatchEvent(new Event("complete"));
		}
		
		/**
		 * retourne la valeur de textIdentifier trouvée dans le xml
		 * @param	textIdentifier le nom du noeud
		 * @return	la valeur trouvée dans le xml correspondante au paramètre textIdentifier
		 */
		public function getTerm(textIdentifier:String = null):String {
			
			if (!xml) {
				return "xml in TranslationsFromXML not loaded yet my friend";
			}
			
			var result:String=String(xml.descendants(textIdentifier)[0]);
			if (result) {
				return result;
			}else {
				return  textIdentifier+" do not exists in xml (TranslationsFromXML)...I'm sorry";
			}
			 
		}
		
		
		
	}
	

}
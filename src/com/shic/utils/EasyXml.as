package com.shic.utils 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import com.shic.utils.EasyXmlEvent;
	/**
	 * Un objet EasyXML est un URLLoader. La simple différence est qu'un EasyXML prend comme argument une URL d'où est téléchargé un XML. Le xml est disponible dans la propriété xml sur l'objet ou sur ses listeners. 
	 * Le contenu du xml étant téléchargé, il est donc fourni de manière asynchrone et n'est disponible qu'après lévènement EasyXxmlEvent.COMPLETE.
	 * @author shic
	 */
	public class EasyXml extends URLLoader
	{
		private var _xmlUrl:String;
		public var xml:XML;
		private var loader:URLLoader;
		
		public function EasyXml(xml:String) 
		{
			loadXml(xml);
			super();
		}
		/**
		 * 
		 * @param	xml
		 */
		private function loadXml(xml:String):void {
			//trace("loading Xml: " + xml);
			loader = new URLLoader();
            getXML_configureListeners(loader);
           	var request:URLRequest = new URLRequest(xml);
			try {
                loader.load(request);
            } catch (error:Error) {
                trace("Unable to load requested XML document. ( "+xml+" )");
            }
		}
		/**
		 * Configure les listeners
		 * @param	dispatcher
		 */
		private function getXML_configureListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.COMPLETE, getXmlComplete);
			dispatcher.addEventListener(Event.OPEN, openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }	
		private function openHandler(event:Event):void {
            //trace("openHandler: " + event);
        }
        private function progressHandler(event:ProgressEvent):void {
          //  trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
        }
		[Event(name = "error", type = "com.shic.utils.EasyXmlEvent")]
       
		private function securityErrorHandler(event:SecurityErrorEvent):void {
           // trace("securityErrorHandler: " + event);
			dispatchEvent(new EasyXmlEvent(EasyXmlEvent.ERROR,xml));
        }
        private function httpStatusHandler(event:HTTPStatusEvent):void {
           // trace("httpStatusHandler: " + event);
			dispatchEvent(new EasyXmlEvent(EasyXmlEvent.ERROR,xml));
        }
        private function ioErrorHandler(event:IOErrorEvent):void {
            trace("EasyXML a détecté une erreur --> ioErrorHandler: " + event);
			dispatchEvent(new EasyXmlEvent(EasyXmlEvent.ERROR,xml));
        }
		
		
		/**
		* Invoqué quand le xml de est chargé
		*
		* @param	event	l'event complete du XML loadé
		*/
		[Event(name = "complete", type = "com.shic.utils.EasyXmlEvent")]
        private function getXmlComplete(event:Event):void {
			//var loader:URLLoader = URLLoader(event.target);
			xml = new XML(loader.data);
			//xml.ignoreWhite = true;
			xml.ignoreWhitespace  = true;
			//
			loader.removeEventListener(Event.OPEN, openHandler);
			loader.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			//
			dispatchEvent(new EasyXmlEvent(EasyXmlEvent.COMPLETE, xml));
			//
			loader.removeEventListener(Event.COMPLETE, getXmlComplete);
		}
		
		
		
	}

}
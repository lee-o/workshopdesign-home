package com.shic.utils 
{
	import com.shic.utils.CacheEvent
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.SoundTransform;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.URLLoader;
	/**
	 * ...
	 * @author David
	 * à terminer...
	 * petite classe qui permet de précharger différents types de fichiers et de les récupérer par la suite dans les objets adéquats.
	 */
	public class Cache extends EventDispatcher
	{
		public static var files:Object = new Object();
		
		public var url:String;
		
		/**
		 * chaine representant le type du fichier à charger les valeurs acceptées sont video, image ou sound:<br>
		 * - video: resultObject sera un objet NetStream<br> 
		 * - image: resultObject sera un objet Loader<br> 
		 * - sound: resultObject sera un objet Sound<br> 
		 */
		public var type:String;
		/**
		 * objet résultant des opérations effectuées, cet objet peut être un objet NetStream, Loader ou Sound
		 */
		public var resultObject:*;
		public var resultObjectNetStream:NetStream;
		/**
		 * indique si le fichier est téléchargé ou pas
		 */
		public var loaded:Boolean = false;
		
		/**
		 * indique si le fichier est en cours de téléchargement
		 */
		public var loading:Boolean = false;
		
		public var bytesLoaded:Number;
		public var bytesTotal:Number;
		
		
		
		
		
		private var connection:NetConnection;
		private var obj:Sprite;
		
		
		
		/**
		 * Quand le fichier est entièrement téléchargé
		 */
		[Event(name = "loadedComplete", type = "com.shic.utils.CacheEvent.as")]
		
		/**
		 * Objet constructeur. Si vous voulez utiliser 
		 * @param	_url
		 * @param	_type
		 * @param	preloadDirectly fait appel immédiatement à la fonction preload démarant ainsi le téléchargement directement.
		 */
		public function Cache(_url:String,_type:String,preloadDirectly:Boolean=true) 
		{
			url = _url;
			type = _type;
			if (preloadDirectly) {
				preload();
			}
			
			//indexe l'objet
			files[url] = this;
			
			trace("::: new Cache " + type + " " + url);
			
		}
		/**
		 * renvoue tue si un objet cache relatif au fichier indiqué par le paramètre url existe
		 * @param	url
		 * @return
		 */
		public static function exists(url:String):Boolean {
			if (files[url]) {
				return true
			}else {
				return false;
			}
		}
		
		/**
		 * charge le fichier indiqué
		 */
		
		public function preload():void {
			if (type=="video") {
				connection = new NetConnection();
				connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				connection.connect(null);
			}else {
				trace("Cache error: Le type "+type+" n'est pas reconnu, les valeurs valides sont video, Loader ou Sound");
			}
		}
		
		//-----méthodes vidéo----
		
		private function netStatusHandler(event:NetStatusEvent):void {
			trace("netStatusHandler="+event.info.code);
            switch (event.info.code) {
                case "NetConnection.Connect.Success":
                    connectStream();
                    break;
                case "NetStream.Play.StreamNotFound":
                    trace("Unable to locate video: " + url);
                    break;
            }
        }
		private function securityErrorHandler(event:SecurityErrorEvent):void {
            trace("securityErrorHandler: " + event);
        }
		private function asyncErrorHandler(event:AsyncErrorEvent):void {
            // ignore AsyncErrorEvent events.
        }
		
		private function connectStream():void {
          //  if (files[url] && files[url].loaded) {
			//	trace("cache video yet loaded");
		//	}else {
				trace("cache video has to be loaded");
				resultObjectNetStream = new NetStream(connection);
				resultObject = resultObjectNetStream;
				resultObjectNetStream.client = new CustomClient();
				resultObjectNetStream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				resultObjectNetStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
		//	}
			
			//chargement
			
			resultObjectNetStream.play(url, 0, 0, true);
			resultObjectNetStream.pause();
			
			loading = true;
			
			//volume à 0
			var soundTrans:SoundTransform = new SoundTransform();
			soundTrans.volume = 0;
			resultObjectNetStream.soundTransform = soundTrans;
			//stream.addEventListener(NetStatusEvent.NET_STATUS, playingstateHandler);
            
			obj = new Sprite();
			obj.addEventListener(Event.ENTER_FRAME, videoLoop);
        }

		
		public function videoLoop(e:Event):void 
		{
			trace("cache video loop");
			if (resultObjectNetStream.bytesLoaded >= resultObjectNetStream.bytesTotal && !loaded) {
				loaded = true;
				loading = false;
				trace("cache video loaded "+resultObjectNetStream.bytesLoaded+"/"+resultObjectNetStream.bytesTotal);
				dispatchEvent(new CacheEvent(CacheEvent.LOADED_COMPLETE));
				obj.removeEventListener(Event.ENTER_FRAME, videoLoop);
			}else{
				trace("cache preloding video "+resultObjectNetStream.bytesLoaded+"/"+resultObjectNetStream.bytesTotal);
			}
		}
		
	}

}

/**
 * client metada personnalisé
 */
class CustomClient {
	
	public var duration:Number;
	public var preferedWidth:Number;
	public var preferedHeight:Number;
	public var frameRate:Number;
	
	public function onMetaData(info:Object):void {
		//trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
		duration = info.duration;
		preferedWidth = info.width;
		preferedHeight = info.height;
		frameRate = info.frameRate;
	}
	public function onCuePoint(info:Object):void {
		//trace("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
	}
	public function onXMPData(infoObject:Object):void 
	{ 
		var key:String; 
		/*
		for (key in infoObject) 
		{ 
			trace(key + ": " + infoObject[key]); 
		} 
		*/
	}
}
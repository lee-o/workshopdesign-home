package com.shic.utils 
{
	import com.greensock.TweenMax;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author shic
	 */
	public class EasyLoader extends Loader
	{
		public var file:String;
		private var fadeIn:Boolean;
		private var fadeInDuration:Number;
		private var useCache:Boolean;
		private static var cacheBitmapData:Object = new Object();
		

		private var chargeur:URLLoader = new URLLoader ();

		
		public function EasyLoader(_file:String,_fadeIn:Boolean=false,_fadeInDuration:Number=0.5,_useCache:Boolean=true) 
		{
			
			
			file = _file;
			fadeIn = _fadeIn;
			fadeInDuration = _fadeInDuration;
			useCache = _useCache;
			
			chargeur.dataFormat=URLLoaderDataFormat.BINARY;
			
			if (fadeIn) {
				alpha = 0;
			}
			
			
			if (cacheBitmapData[file] && useCache) {
				//on affiche à partir du cache et le fichier est déjà chargé
				onComplete();		
			}else if (useCache) {
				//on affiche à partir du cache mais le fichier n'est pas encore chargé
				chargeur.load(new URLRequest(file));
				chargeur.addEventListener(Event.COMPLETE, onComplete);
				chargeur.addEventListener(IOErrorEvent.IO_ERROR, onError);
			}else {
				//on ne s'occupe pas du cache on loade le fichier simplement
				this.load(new URLRequest(file));
				this.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
				this.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
				//trace("----------- load "+file);
			}
			
		}
		
		/**
		 * En cas d'erreur de chargement...
		 * @param	e
		 */
		private function onError(e:IOErrorEvent):void 
		{
			trace("Easy loader a rencontré une erreur: " + e.text);
			dispatchEvent(new EasyLoaderEvent(EasyLoaderEvent.ERROR));
		}
		
		
		
		
		[Event(name="complete", type="flash.events.Event")]
		/**
		 * Quand le fichier et fini d'être chargé
		 * @param	e
		 */
		private function onComplete(e:Event=null):void 
		{
			
			
			if (useCache) {
				if(e){
					cacheBitmapData[file] = e.target.data;
				}
				this.loadBytes(cacheBitmapData[file]);
			}
			
			this.addEventListener(Event.ENTER_FRAME, ready);
			
		}
		
		
		private function ready(e:Event=null):void 
		{
			//trace("loadiiiiiiiiiiiiiig "+file);
			if (this.width > 0) {
				this.removeEventListener(Event.ENTER_FRAME, ready);
				//trace("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee "+file);
				//trace(this.width);
				dispatchEvent(new Event(Event.COMPLETE));
				
				if (fadeIn) {
					TweenMax.to(this, fadeInDuration, { 
					alpha:1 
					} 
				);
				}
			}
		}
	}
}
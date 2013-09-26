////////////////////////// CONFIG /////////////////////////////////////////  -------------- a changer au niveau de l'integration
package com.shic.utils {
	/////
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	/////
	public dynamic class stackXML {
		////
		private var tabStack:Array;
		private var sequential:Number;
		private var totalArray:Number;
		private var incNumber:Number = 0;
		private var tabQueueXML:Array = new Array();
		private var externalXML:XML;
		/////
		public var onLoad:Function;
		//public static  var onFinished:Function;
		public var onFinished:Function;
		////
		function stackXML(p_array:Array,p_sequential:Number):void {
			tabStack = p_array;
			totalArray = tabStack.length;
			sequential = p_sequential;
			trace("*********** stackXML *************");
			loadByStack()
			/*if (sequential == "SEQUENTIAL") {
				initSequential();
			}else {
				trace("********************* ALL *******************");
				init();
			}*/
			
		}
		////
		private function loadByStack():void {			
			for (var i:int = 0; i < sequential; i++) 			{
				next();			
			}
		}
			private function next():void
		{
			var index:Number = incNumber;
			////////////////////////////
			var request:URLRequest = new URLRequest(tabStack[index]);
			var loader:URLLoader = new URLLoader();
			loader.load(request);
			loader.addEventListener(Event.COMPLETE, onComplete);
			///
		}	
		
		private function onComplete(e:Event):void {
			var loader:URLLoader = e.target as URLLoader;
			if (loader != null) {
				////
				externalXML = new XML(loader.data);
				var lng:uint = tabStack.length;
				/////////////////////////////////////////////		
				//var m_mc:MovieClip = new MovieClip();
				//m_mc.data = loader;
				//m_mc.id = incNumber;
				trace("hop ---> " + incNumber);
				onLoad(loader.data,incNumber);
				incNumber++;		
				if (incNumber < lng ) {				
					next();												
				}else {
					onFinished();
				}
			
			}else{
				trace("loader is not a URLLoader!");
			}
			
		}		
		
		
		
	
	
		
	}
}
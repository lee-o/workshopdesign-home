////////////////////////// CONFIG /////////////////////////////////////////  -------------- a changer au niveau de l'integration
package com.shic.utils {
	/////
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import com.shic.utils.stackLoader;
	/////
	public dynamic class stackImages extends MovieClip{
		////
		private var sequential:Number;
		private var tabStack:Array;
		private var tabStockSequence:Array;
		private var totalImages:Number;
		private var imagesNumber:Number = 0;
		private var tabQueueImages:Array = new Array();
		private var myTimer:Timer;		
		/////
		public var onLoad:Function;
		//public static  var onFinished:Function;
		public var onFinished:Function;
		////
		function stackImages( p_array:Array,p_sequential:Number):void {
			//contener = p_contener;
			tabStack = p_array;		
			sequential = p_sequential;
			trace("*********** stackImages *************");
			totalImages = tabStack.length;
			/////
			loadByStack();
			/////
		}
		////////////////////////////
		private function loadByStack():void{			
			for (var i:int = 0; i < sequential; i++) 	{
				imagesNumber = i;
				next();			
			}
		}
		//////
		private function next():void{
			////////////////////////////
			var index:Number = imagesNumber;
			////////////////////////////
			var m_mc:String = tabStack[index]["FILE"];
			var loaderImage:stackLoader = new stackLoader(m_mc);
			//loaderImage.NAME = tabStack[index]["NAME"];
			loaderImage.obj = tabStack[index]["OBJET"];
			////////////////////////////
			loaderImage.contentLoaderInfo.addEventListener(Event.COMPLETE, completeSequentialHandler); 
			////////////////////////////
			var requestLoadMovie:URLRequest = new URLRequest(m_mc);
			// load l'url dans l'objet loader
			loaderImage.load(requestLoadMovie);
			///
		}
		//////////////////////////////////
		private function completeSequentialHandler(e:Event):void {
			var lng:uint = tabStack.length;
			/////////////////////////////////////////////	
			//trace(e.target.content.parent.obj.TEXTE1);
			/////////////////////////////////////////////
			onLoad(e.target.content.parent);
			imagesNumber++;		
			if (imagesNumber < lng - 1) {				
				next();												
			}else {
				onFinished(e.target.content.parent);
			}
		}		
	}
}
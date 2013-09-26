////////////////////////// CONFIG /////////////////////////////////////////  -------------- a changer au niveau de l'integration
package com.shic.utils {
	/////
	import flash.display.MovieClip;
	import com.shic.utils.stackImages;
	//import com.shic.utils.stackXML;
	import flash.utils.describeType;
	/////
	public class fileStack {
		////
		public var type:String;
		public var node:*;
		public var xmlStack:*;
		public var tabStack:Array;
		public var numberItemToLoad:Number;
		public var onFinished:Function;
		public var onLoad:Function;
		public static var instances:Array = new Array();
		////
		public var stackImage_mc:stackImages;
		public var stackXML_mc:stackXML;
		///
		function fileStack(p_xml:Array, p_type:String,p_number:Number=0) {
			/////
			type = p_type;
			numberItemToLoad = p_number;
			////
			xmlStack = p_xml;
			/////
			//fileStack.instances.push(this);
			/////
			trace("*********** fileStack *************");
			/////
			init();
			/////			
		}
		////
		private function init():void {
			/////
			//stackFilesInArray()
			/////
			if (type == "IMAGE") {
				//trace("xmlStack ---> " + xmlStack);
				stackImage_mc = new stackImages(xmlStack,numberItemToLoad);
				stackImage_mc.onFinished = Finished;
				stackImage_mc.onLoad = Load;
				
			}else if (type == "XML") {
				xmlStack = xmlStack as Array;
				//trace("xmlStack --- " + xmlStack);
				//trace("sequential --- " + sequential);
				stackXML_mc = new stackXML(xmlStack,numberItemToLoad);
				stackXML_mc.onFinished = Finished;
				stackXML_mc.onLoad = Load;
			}else if (type == "UPLOAD") {
				
			}else if (type == "DOWNLOAD") {
				
			}
			
		}
		
		public function Load(p_movie:* = null,p_number:Number = 0):void
		{
			onLoad(p_movie,p_number);		
		}
		
		public function Finished(p_movie:* = null):void
		{		
			onFinished();
		}
		////
		
	}
}
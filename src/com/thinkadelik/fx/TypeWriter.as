package com.thinkadelik.fx
{
	import FaceB.site.navigation.DataLoader;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	public class TypeWriter
	{
		public var txtTimer:Timer;
		private var textArray:Array = new Array();
		private var t1:String;
		private var counter:Number = 0;
		private var textPath:TextField;
		private var textStyle:String;
		private var char:int;
		private var ready:Boolean = true;
		
		public function TypeWriter() {

		}
		
		public function writeIt(_inputTxt:String, _textPath:TextField, _char:int,_appendInt:int, _textStyle:String = null):void {
			if(ready == true) {
				textPath = _textPath;
				textStyle = _textStyle;
				char = _char;
				var inputTxt:String = _inputTxt;
				var appendInt:Number = _appendInt;
				textArray = [];
				textArray.length = 0;
				t1 = inputTxt;
				textArray = t1.split("");
				counter = 0;
				textPath.text = "";
				txtTimer = new Timer(appendInt, textArray.length);
				txtTimer.addEventListener(TimerEvent.TIMER, appendText);
				txtTimer.addEventListener(TimerEvent.TIMER_COMPLETE, txtTimerStop);
				txtTimer.start();
				ready = false;
			}
		}
		private function appendText(event:TimerEvent):void {
			textPath.appendText(textArray[counter]);
			if(textStyle != null){
				DataLoader.xmlStyleLoader.appliqueFormat(textPath, textStyle);
			}
			//trace(textArray[counter]);
			counter ++;
		}
		
		public function txtTimerStop(e:TimerEvent):void {
			ready = true;
			trace("typeWrited");
		}
	}
}
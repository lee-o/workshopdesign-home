package com.shic.display.text 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author david@shic.fr
	 */
	public class EasyTextField extends TextField
	{
		private var _textFormat:TextFormat;
		private var _text:String;
		
		public function EasyTextField() 
		{
			
		}
		
		public function get textFormat():TextFormat { return _textFormat; }
		public function set textFormat(value:TextFormat):void 
		{
			_textFormat = value;
			if(_textFormat){
				this.setTextFormat(_textFormat);
			}
		}
		
		public override function get text():String { return _text; }
		public override function set text(value:String):void 
		{
			_text = value;
			super.text = _text;
			textFormat = textFormat;
		}
		
		
	}

}
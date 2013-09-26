package com.shic.displayObjects 
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author shic
	 */
	public class TextFieldMultiLines extends TextField
	{
		
		private var _textFormat:TextFormat;
		
		public function TextFieldMultiLines(text:String,textColor:uint=0x808080,textFormat:TextFormat=null,embedFonts:Boolean=false,html:Boolean = true) 
		{
			this.autoSize = TextFieldAutoSize.LEFT;
			this.textColor = 0x000000;
			this.multiline = true;
			this.wordWrap = true;
			this.embedFonts = embedFonts;
			this.selectable = false;
			this.type = TextFieldType.DYNAMIC;
			
			this.textColor = textColor;
			
			if(textFormat){
				_textFormat = textFormat;
			}else {
				_textFormat= new TextFormat();
				_textFormat.size = 12;
				_textFormat.font = "_sans";
				
			}
			this.defaultTextFormat = _textFormat;
			//
			html ? this.htmlText = text : this.text = text;
			super();
		}
		
		public function get textFormat():TextFormat { return _textFormat; }
		
		public function set textFormat(value:TextFormat):void 
		{
			_textFormat = value;
			this.defaultTextFormat = _textFormat;
			this.setTextFormat(_textFormat);
		}
		
	}

}
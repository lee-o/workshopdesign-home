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
	public class TextFieldMonoLine extends TextField
	{
		
		public function TextFieldMonoLine(text:String,html:Boolean = false) 
		{
			this.autoSize = TextFieldAutoSize.LEFT;
			this.textColor = 0x000000;
			
			this.multiline = false;
			this.wordWrap = false;
			this.embedFonts = false;
			this.selectable = false;
			this.type=TextFieldType.DYNAMIC;
			
			var tf:TextFormat = new TextFormat();
			tf.size = 12;
			tf.font = "_sans";
			this.defaultTextFormat = tf;
			//
			html ? this.htmlText = text : this.text = text;
			super();
		}
		
	}

}
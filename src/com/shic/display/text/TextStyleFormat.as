package cc.shic.display.text 
{
	import cc.shic.Utils;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author david@shic.fr
	 */
	public class TextStyleFormat
	{
		/**
		 * Le nom du text style
		 */
		public var name:String;
		public var textFormat:TextFormat;
		
		private var _italic:Boolean = false;
		private var _bold:Boolean = false;
		private var _underline:Boolean = false;
		private var _bullet:Boolean = false;
		private var _kerning:Boolean = false;
		private var _font:String;
		private var _size:Number;
		private var _color:uint;
		private var _letterSpacing:Number;
		private var _leading:Number;
		private var _align:String;
		private var _leftMargin:Number;
		private var _rightMargin:Number;
		private var _tabStops:Array;
		private var _indent:Number;
		private var _blockIndent:Number;
		
		public var embedFonts:Boolean;
		public var antiAliasType:String;
		public var gridFitType:String;
		public var sharpness:Number;
		public var background:Boolean;
		public var backgroundColor:uint;
		public var border:Boolean;
		public var borderColor:uint;
		
		public function TextStyleFormat(xml:XML) 
		{
			name = xml.name();
			textFormat = new TextFormat();
			
			var nodeName:String;
			for (var i:int=0; i<xml.children().length(); i++) {
				
				nodeName = xml.children()[i].name();
				//trace(nodeName);
				switch (nodeName) {
					case "italic" :
						textFormat.italic = Utils.getBool(xml[nodeName]);
						
						break;
						
					case "bold" :
						textFormat.bold=Utils.getBool(xml[nodeName]);
						break;

					case "underline" :
						textFormat.underline=Utils.getBool(xml[nodeName]);
						break;

					case "bullet" :
						textFormat.bullet=Utils.getBool(xml[nodeName]);
						break;

					case "kerning" :
						textFormat.kerning=Utils.getBool(xml[nodeName]);
						break;

					case "font" :
						textFormat.font=unescape(xml[nodeName]);
						break;

					case "size" :
						textFormat.size=Number(xml[nodeName]);
						break;

					case "color" :
						textFormat.color=Number(xml[nodeName]);
						break;

					case "letterSpacing" :
						textFormat.letterSpacing=Number(xml[nodeName]);
						break;


					case "leading" :
						textFormat.leading=xml[nodeName];
						break;

					case "align" :
						textFormat.align=String(xml[nodeName]);
						break;

					case "leftMargin" :
						textFormat.leftMargin=Number(xml[nodeName]);
						break;

					case "rightMargin" :
						textFormat.rightMargin=Number(xml[nodeName]);
						break;

					case "tabStops" :
						textFormat.tabStops=String(xml[nodeName]).split(",");
						break;

					case "indent" :
						textFormat.indent=Number(xml[nodeName]);
						break;

					case "blockIndent" :
						textFormat.blockIndent=Number(xml[nodeName]);
						break;

					case "embedFonts" :
						embedFonts=Utils.getBool(xml[nodeName]);					
						break;
						
					case "antiAliasType":
						antiAliasType=String(xml[nodeName]);
						break;
						
					case "gridFitType":
						gridFitType=String(xml[nodeName]);
						break;
						
					case "sharpness":
						sharpness=Number(xml[nodeName]);
						break;
						
					case "border" :
						border=Utils.getBool(xml[nodeName]);
						break;

					case "background" :
						background=Utils.getBool(xml[nodeName]);
						break;

					case "borderColor" :
						borderColor=Number(xml[nodeName]);
						break;

					case "backgroundColor" :
						backgroundColor=Number(xml[nodeName]);
						break;
				}
			}
		
		}
		/**
		 * applique les propriété au champ texte défini par txt
		 * @param	txt
		 */
		public function applyTo(txt:TextField):void {
			txt.embedFonts = embedFonts;
			if(antiAliasType){
				txt.antiAliasType = antiAliasType;
			}
			if(gridFitType){
			txt.gridFitType = gridFitType;
			}
			if(sharpness){
			txt.sharpness = sharpness;
			}
			if(border){
			txt.border = border;
			}
			if(background){
			txt.background = background;
			}
			if(borderColor){
			txt.borderColor = borderColor;
			}
			if(backgroundColor){
			txt.backgroundColor = backgroundColor;
			}
			txt.setTextFormat(textFormat);
		}
		
		public function get italic():Boolean { return _italic; }
		
		public function set italic(value:Boolean):void 
		{
			_italic = value;
			textFormat.italic = _italic;
		}
		
		public function get bold():Boolean { return _bold; }
		
		public function set bold(value:Boolean):void 
		{
			_bold = value;
			textFormat.bold = _bold;
		}
		
		public function get underline():Boolean { return _underline; }
		
		public function set underline(value:Boolean):void 
		{
			_underline = value;
			textFormat.underline = underline;
		}
		
		public function get bullet():Boolean { return _bullet; }
		
		public function set bullet(value:Boolean):void 
		{
			_bullet = value;
			textFormat.bullet = _bullet;
		}
		
		public function get kerning():Boolean { return _kerning; }
		
		public function set kerning(value:Boolean):void 
		{
			_kerning = value;
			textFormat.kerning = _kerning;
		}
		
		public function get font():String { return _font; }
		
		public function set font(value:String):void 
		{
			_font = value;
			textFormat.font = _font;
		}
		
		public function get size():Number { return _size; }
		
		public function set size(value:Number):void 
		{
			_size = value;
			textFormat.size = _size;
		}
		
		public function get color():uint { return _color; }
		
		public function set color(value:uint):void 
		{
			_color = value;
			textFormat.color = _color;
		}
		
		public function get letterSpacing():Number { return _letterSpacing; }
		
		public function set letterSpacing(value:Number):void 
		{
			_letterSpacing = value;
			textFormat.letterSpacing=_letterSpacing;
		}
		
		public function get leading():Number { return _leading; }
		
		public function set leading(value:Number):void 
		{
			_leading = value;
			textFormat.leading = _leading;
		}
		
		public function get align():String { return _align; }
		
		public function set align(value:String):void 
		{
			_align = value;
			textFormat.align = _align;
		}
		
		public function get leftMargin():Number { return _leftMargin; }
		
		public function set leftMargin(value:Number):void 
		{
			_leftMargin = value;
			textFormat.leftMargin = _leftMargin;
		}
		
		public function get rightMargin():Number { return _rightMargin; }
		
		public function set rightMargin(value:Number):void 
		{
			_rightMargin = value;
			textFormat.rightMargin = _rightMargin;
		}
		
		public function get tabStops():Array { return _tabStops; }
		
		public function set tabStops(value:Array):void 
		{
			_tabStops = value;
			textFormat.tabStops = _tabStops;
		}
		
		public function get indent():Number { return _indent; }
		
		public function set indent(value:Number):void 
		{
			_indent = value;
			textFormat.indent = _indent;
		}
		
		public function get blockIndent():Number { return _blockIndent; }
		
		public function set blockIndent(value:Number):void 
		{
			_blockIndent = value;
			textFormat.blockIndent = blockIndent;
		}
	}

}
package cc.shic.display.text
{
	import com.arabicode.text.Flaraby.FlarabyAS3Flex;
	import com.arabicode.text.Flaraby.ExtraWidthEvent;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	import flash.text.TextFormat;
	
	/**
	 * Cette classe nécessite le composant FlarabyAS3Flex.swc. Le but de cette classe est de simplifier l'utilisation du composant au moyen de la méthode setText qui a pour rôle de simplement appliquer le texte donné en paramètre au champ de texte.
	 * @author 
	 */
	
	 
	
	public class InternationalTextField extends FlarabyAS3Flex
	{
		/**
		 * le vrai texte avant ue les inversions de caractères ne soient faites
		 */
		public var realText:String;
		
		public function InternationalTextField() 
		{	
			super();
			this.condenseWhite = true;
			this.extraCharWidth = 0;
			this.autoSize = TextFieldAutoSize.LEFT;
		}
		public function hasArabic(p_string:String):Boolean {
			for (var i:* in p_string.split("")) {
				if (p_string.charCodeAt(i) >= 1578 && p_string.charCodeAt(i) <= 1650) {				
					return true;
				}				
			}
			
			return false;
		}
		/**
		 * Applique le texte donné au champ texte
		 * @param	text
		 */
		public function setText(text:String):void {
			var tf:TextFormat = this.getTextFormat();
			var isArabic:Boolean = false;
			if (hasArabic(text)) {
				isArabic = true;
				this.dir = "RTL";
			}else {
				this.dir = "LTR";
			}
			realText = text;
			this.text = this.convertArabicString(text, this.width, tf);		
			this.setTextFormat(tf);
			
			if(isArabic) {
				var tf2:TextFormat = new TextFormat();
				tf2.align = TextFormatAlign.RIGHT;
				this.setTextFormat(tf2);
			}
			
		}
		/**
		 * il est fortement conseillé d'appeller cette méthode après avoir modifié les dimensions d'un champ texte sans quoi les retours à la ligne ne fonctionneront pas correctement.
		 */
		public function update(e:ExtraWidthEvent = null):void {
			if (!realText) {
				realText = text;
			}
			setText(realText);	
		}
		
		/**
		 * le formatage appliqué au champ texte.<br/> 
		 * Il est fortement conseillé de n'appliquer cette pripirété qu'après avoir spécifié une valeur de texte pour le champ
		 */
		/*public function get textFormat():TextFormat { return _textFormat; }		
		public function set textFormat(value:TextFormat):void 
		{
			_textFormat = value;
			this.setTextFormat(_textFormat);
			update();
		}*/
	}

}
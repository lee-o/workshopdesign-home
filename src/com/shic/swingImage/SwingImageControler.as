package com.shic.swingImage 
{
	import com.shic.ui.Slider;
	import com.shic.ui.SliderEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import com.shic.swingImage.SwingImageUtils;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.display.*
	import flash.filters.ShaderFilter

	/**
	 * un swingImageControleur est une interface utilisateur qui permet à l'utilisateur de modifier le filtre "filter" appliqué sur le display object "targetObject"
	 * @param	targetObject	displayObject sur lequel est appliqué le filtre
	 * @return 	une interface utilisateur permettant de modifier le filtre
	 * @author david m
	 */
	public class SwingImageControler extends Sprite
	{
		private var _targetMovie:DisplayObject;
		private var _filter:*;
		private var _windowTitle:String
		private var _width:uint = 310;
		private var _marge:uint = 4;
		/**
		 * liste des composants utilisateurs
		 */
		private var controleurs:Array = new Array();
		public var title:TextField;
		public var textFormat:TextFormat;
		/**
		 * 
		 * @param	filter le filtre appliqué
		 * @param	targetObject le display objet auquel est appliqué le filtre
		 * @param	p_windowTitle titre de la fenêtre
		 * @param	params tableau de paramètres de type SwingImageControlerParam qui permètent de générer le composant utilisateur adéquat
		 */
		public function SwingImageControler(filter:*,targetObject:DisplayObject,p_windowTitle:String,params:Array) 
		{
			_windowTitle = p_windowTitle;
			_filter = filter;
			_targetMovie = targetObject;
			super();
			
			if(!textFormat){
				textFormat = new TextFormat();
				textFormat.font = "_sans";
				textFormat.size = 12;
			}
			
			title = new TextField();
			title.x = _marge;
			title.y = _marge;
			title.autoSize = TextFieldAutoSize.LEFT;
			title.wordWrap = true;
			title.multiline = true;
			title.width = _width - _marge * 2;
			title.textColor = 0x222222;
			//title.border = true;
			setWindowTitle();
			

			
			this.addChild(title);
			var item:DisplayObject;
			var itemParams:SwingImageControlerParam;
			for (var i:uint = 0; i < params.length; i++) {
				itemParams = params[i];
				item = getItem(itemParams);
				item.name = itemParams.variable;
				item.x = _marge;
				this.addChild(item);
				controleurs.push(item);
				item.y = i * 25+(title.height+_marge*2);
				item.addEventListener(SliderEvent.CHANGE, updateFilter);
			}
			

			
			this.scrollRect = new Rectangle(0, 0, _width, height + _marge * 2);
			this.opaqueBackground = 0xeeeeee;
			
			
			
		}
		private function getItem(itemParams:SwingImageControlerParam):DisplayObject {
			switch(itemParams.uiType) {
				case "Slider":
				return new Slider(itemParams.params.minValue, itemParams.params.maxValue, itemParams.InitValue, _width-_marge*2, 24, itemParams.variable,null,itemParams.variable,itemParams.params.roundMultiplicator);
				break;
			}
		}
		/**
		 * met à jour la propriété sur le slider correspondant à variableName et sur le filtre par la même occasion
		 * @param	variableName proriété à modifier
		 * @param	itemValue valeur à donner à la propriété
		 */
		public function setValue(variableName:String, itemValue:*):void {
			if (this.getChildByName(String(variableName))) {
				this.getChildByName(String(variableName)).value = itemValue;
			}
		}
		
		
		/**
		 * mets à jour le filtre à partir d'un paramètre fourni par un slider event et l'applique au display Object cible
		 * @param	e
		 */
		public function updateFilter(e:SliderEvent):void {
			/*trace("updateFilter");
			trace(_targetMovie)
			trace(e)
			trace(e.value)
			trace(e.variable);
			*/
			if (_targetMovie && e && e.variable) {
				//trace("update: "+e.variable+"="+e.value);
				var oldFilter:*= _filter;
				var new_filter:* = _filter.clone2();
				new_filter[e.variable] = e.value;
				//trace("new "+e.variable+" = "+new_filter[e.variable]);
				//_targetMovie.filters = [_filter];
				SwingImageUtils.replaceFilterInObject(_targetMovie, new_filter, oldFilter);
				_filter = new_filter;
				
			}
		}
		
		private function updateAll() :void{
			var item:Slider;
			_filter = _filter.clone2();
			for (var i:uint = 0; i < controleurs.length; i++) {
				item = controleurs[i];
				_filter[item.variable] = item.value;
			}
			_targetMovie.filters = [_filter];
		}
		
		public function get targetMovie():DisplayObject { return _targetMovie; }
		public function set targetMovie(value:DisplayObject):void 
		{
			_targetMovie = value;
			updateAll();
		}
		
		public function get filter():Object { return _filter; }	
		public function set filter(value:Object):void 
		{
			_filter = value;
		}
		
		/**
		 * Titre de la fenêtre
		 */
		public function get windowTitle():String { return _windowTitle; }
		public function set windowTitle(value:String):void 
		{
			_windowTitle = value;
			setWindowTitle();
			
		}
		private function setWindowTitle():void{
			title.text = _windowTitle;
			title.setTextFormat(textFormat);
		}
		
	}

}
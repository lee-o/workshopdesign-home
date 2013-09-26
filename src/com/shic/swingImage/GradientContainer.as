package com.shic.swingImage 
{
	import com.shic.swingImage.img.GradientsShapes;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import com.shic.swingImage.img.GradientCircle;
	import com.shic.swingImage.img.Square;
	/**
	 * ...
	 * @author david m
	 */
	public class GradientContainer extends Sprite
	{
		public var maskObject:GradientsShapes;
		public var GradientType:String;
		private var _displayObject:DisplayObject;
		private var _gradientRatio:uint;

		
		public function GradientContainer(displayObject:DisplayObject,_GradientType:String="Square",gradientRatio:uint=1) 
		{
			_displayObject = displayObject;
			GradientType = _GradientType;
			_gradientRatio = gradientRatio;
			
			update();
		}
		
		//---get set gradientRatio
		public function set gradientRatio(__gradientRatio:uint):void {
			_gradientRatio = __gradientRatio;
			maskObject.gradientRatio = _gradientRatio;
		}
		public function get gradientRatio():uint {
			if (!maskObject) {
				return null;
			}
			return maskObject.gradientRatio;
		}
		
		//----get set diplayObject
		public function set displayObject(displayObject:DisplayObject):void {
			_displayObject = displayObject;
			update();
		}
		public function get displayObject():DisplayObject {
			return _displayObject
		}
		/**
		 * met à jour l'objet en fonction des paramètres enregistrés
		 */
		public function update():void {
			
			nettoyage();
			
			this.addChild(_displayObject);
			
			maskObject = null;
			var w:Number = width;
			var h:Number = height;
			switch (GradientType) {
				case "GradientCircle":
					maskObject = new GradientCircle(_gradientRatio);
					break;
				default:
					maskObject = new GradientCircle(_gradientRatio);
					trace("Attention: "+GradientType+" n'est pas un argument valide pour GradientType dans le contructeur GradientContainer. Le masque par défaut est donc GradientCircle.");	
			}
			maskObject.width = w;
			maskObject.height = h;
			this.addChild(maskObject);
			maskObject.cacheAsBitmap = true;
			_displayObject.cacheAsBitmap = true;
			_displayObject.mask = maskObject;
			
			trace("update "+this.numChildren);
		}
		/**
		 * efface tous les clips contenus dans l'objet
		 */
		private function nettoyage() :void {
			
			while(this.numChildren>0) {
				this.removeChildAt(0);
			}
			
		}

		
		
	}

}
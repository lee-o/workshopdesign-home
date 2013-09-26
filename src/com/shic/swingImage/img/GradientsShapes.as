package com.shic.swingImage.img 
{
	import flash.display.MovieClip;
	/**
	 * Les objets GradientsShape sont des movieClips qui contiennent 100 images qui font évoluer un dégradé au fil des frames.
	 * La propriété gradientRatio comprise entre 1 et 100 represente la valeur d'évolution du dégradé. 
	 * Un gradientRatio de 1 donnera une forme allant d'un alpha 0 pour son contour à un alpha 100 pour son centre.
	 * Un gradientRatio de 100 donnera une forme allant d'un alpha 100 pour son contour à un alpha 100 pour son centre, autrement dit une forme ne comportant pas de transparence.
	 * @author david m
	 */
	public class GradientsShapes extends MovieClip
	{
		/**
		 * valeur d'évolution du dégradé comprise entre 1 et 100
		 */
		private var _gradientRatio:uint;
		
		public function GradientsShapes(_gradientRatio:uint=20 ) 
		{
			gradientRatio=_gradientRatio;
		}
		
		public function set gradientRatio(__gradientRatio:uint):void {
			_gradientRatio = __gradientRatio;
			this.gotoAndStop(_gradientRatio);
			trace("gotoAndStop "+_gradientRatio);
			
		}
		public function get gradientRatio():uint {
			return uint(currentFrame);
		}
		
	}

}
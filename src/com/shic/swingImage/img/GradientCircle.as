package com.shic.swingImage.img 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author david m
	 */
	
	[Embed(source='degrades.swf', symbol='degrade_radial_alpha')]
	public class GradientCircle extends GradientsShapes
	{
		
		public function GradientCircle(gradientRatio:uint=1) 
		{
			super(gradientRatio);
		}

		
	}

}
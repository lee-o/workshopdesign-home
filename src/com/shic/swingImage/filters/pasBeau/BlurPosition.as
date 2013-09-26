package com.shic.swingImage 
{
	/**
	 * ...
	 * @author david m
	 */
	

	import flash.filters.ConvolutionFilter;
	import flash.geom.*
	import flash.filters.BitmapFilter;

	
	import flash.display.Sprite;
	 
	public class BlurPosition
	{
		/**
		 * le filtre résultant
		 */
		public var filter:BitmapFilter;
		
		

		
		
		
		public function BlurPosition() 
		{


			filter = getFilter();
			
			
		}
		public function getFilter() :ConvolutionFilter
		{
		/*	
					var aMat:Array = [0,  1, 0,
									 1, -4, 1,
									 0,  1, 0]; //edge detect
				   a.filters = [new ConvolutionFilter(3, 3, aMat)];
				   var bMat:Array = [ 0, -1,  0,
									 -1,  5, -1,
									  0, -1,  0]; //sharpen
				   b.filters = [new ConvolutionFilter(3, 3, bMat)];
				   var cMat:Array = [1, 1, 1,
									 1, 1, 1,
									1, 1, 1]; //blur
				   c.filters = [new ConvolutionFilter(3, 3, cMat, 9)];
			var dMat:Array = [-2, -1, 0,                        -1,  1, 1,
								   0,  1, 2]; //emboss
				  d.filters = [new ConvolutionFilter(3, 3, dMat)];
			
		*/	
		//blur
		var cMat:Array = [
						1, 1, 1,
						1, 1, 1,
						1, 1, 1
						];
		var filtre:ConvolutionFilter = new ConvolutionFilter(3, 3, cMat, 9);
		/*
		//edge detect
		var aMat:Array = [0,  1, 0,
                         1, -4, 1,
                         0,  1, 0]; 
		
		 var filtre:ConvolutionFilter = new ConvolutionFilter(3, 3, aMat);
		 */
		
		return filtre;
			
			
		}
		
	}

}
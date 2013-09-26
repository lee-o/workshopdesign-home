package com.shic.swingImage 
{
	/**
	 * ...
	 * @author david m
	 */
	
	import com.shic.swingImage.img.Spherise;
	import flash.display.BitmapData;
	import flash.filters.BitmapFilter;
	import flash.display.BitmapDataChannel
	import flash.filters.DisplacementMapFilterMode
	import flash.filters.DisplacementMapFilter
	import flash.geom.*
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	
	import com.tests.img.Spherize_img;
	
	import flash.display.Sprite;
	 
	public class Spherize
	{
		/**
		 * le filtre résultant
		 */
		public var filter:BitmapFilter;
		
		/**
		 * le bitmapData généré utilisé pour la déformation
		 */
		public var bitmapDistort:BitmapData;
		
		/**
		 * largeur de la sphere
		 */
		public var width:Number;
		
		/**
		 * heuteur de la sphere
		 */
		public var height:Number;
		
		/**
		 * le facteur de déformation
		 */
		public var deformFactor:Number;
		
		public var deformWidth:int;
		public var deformHeight:int;
		public var deformX:int;
		public var deformY:int;
		

		
		
		
		public function Spherize(width_p:Number,height_p:Number,deformFactor_p:int,deformWidth_p:int,deformHeight_p:int,deformX_p:int,deformY_p:int) 
		{

			deformFactor = deformFactor_p;
			
			height = height_p;
			width = width_p;
			deformWidth = deformWidth_p;
			deformHeight = deformHeight_p;
			deformX = deformX_p;
			deformY = deformY_p;
			filter = getFilter();
			
			
		}
		public function getFilter() :BitmapFilter
		{
			bitmapDistort = new BitmapData(width, height, false, 0x808080);

			var degrade:Sprite = new Sprite();
			var forme:Spherise = new Spherise();
			forme.width = deformWidth;
			forme.height = deformHeight;
			forme.x = deformX;
			forme.y = deformY;
			degrade.addChild(forme);
			
			bitmapDistort.draw(degrade,null,null,null,null,true);
			
			//----
			
			
            var mapPoint:Point       = new Point(0, 0);
            var componentX:uint      = BitmapDataChannel.RED;
            var componentY:uint      = BitmapDataChannel.GREEN;
            var scaleX:Number        = deformFactor;
            var scaleY:Number        = deformFactor;
            var mode:String          = DisplacementMapFilterMode.WRAP ;
            var color:uint           = 0;
            var alpha:Number         = 0;
            
			//bitmapDistort = new com.tests.img.Spherize_img(200, 200, false, 0xffff00);
			//bitmapDistort = map;
			
			var filtre:DisplacementMapFilter = new DisplacementMapFilter(
											bitmapDistort,
                                            mapPoint,
                                            componentX,
                                            componentY,
                                            scaleX,
                                            scaleY,
                                            mode,
                                            color,
                                            alpha);
											
			//pt = null;
			//point = null;
			return filtre;
			
			
		}
		
	}

}
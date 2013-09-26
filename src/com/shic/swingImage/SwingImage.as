package com.shic.swingImage 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	/**
	 * ...
	 * @author david m
	 */
	public class SwingImage extends BitmapData
	{
		
		private var bmpdOrigin:BitmapData;
		public var distorsions:Array
		
		public function SwingImage(bmpd:BitmapData,distorsions_p:Array) 
		{
			super(bmpd.width, bmpd.height);
			bmpdOrigin = bmpd;
			distorsions = distorsions_p;
			refresh();
			
		}
		public function refresh():void {
			this.draw(bmpdOrigin);
			//trace("refresh");
			
			for (var i:uint = 0; i < distorsions.length; i++) {
				this.applyFilter(this, this.rect, new Point(0, 0), distorsions[i]);
				//trace(i+"_"+distorsions[i].deplacementX);
			}
			
		}
		
	}


}
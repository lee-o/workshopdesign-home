package com.shic.utils 
{
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	/**
	 * ...
	 * @author ...
	 */
	public class StageUtils
	{
		
		public function StageUtils() 
		{
			
		}
		public static function TopLeftNoScale(stage:Stage):void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		
	}

}
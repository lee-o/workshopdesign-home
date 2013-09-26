package com.shic.displayObjects
{
	import flash.display.LineScaleMode;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author david m
	 */
	public class Square extends Sprite
	{
		public var optionnalParameters:Object = new Object();
		/**
		 retourne un carré rouge de 100 / 100 pixels
		 */
		public function Square(p_width:Number = 100, p_height:Number = 100, p_color:uint = 0x808080, p_alpha:Number = 1, border:Boolean = false, borderWidth:uint = 0, borderColor:Number = 0x000000,borderAlpha:Number = 1 ) 
		{
			this.graphics.beginFill(p_color, p_alpha);
			border ? this.graphics.lineStyle(borderWidth, borderColor, borderAlpha,false,LineScaleMode.NONE):null;
			this.graphics.drawRect(0, 0, p_width, p_height);
			this.graphics.endFill();
		}
		
	}

}
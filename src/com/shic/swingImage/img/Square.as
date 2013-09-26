package com.shic.swingImage.img 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author david m
	 */
	public class Square extends Sprite
	{
		/**
		 * retourne un carré rouge de 100 / 100 pixels
		 */
		public function Square(p_width:Number=100,p_height:Number=100,p_color:uint=0x808080,p_alpha:Number=1) 
		{
			this.graphics.beginFill(p_color, p_alpha);
			this.graphics.drawRect(0, 0, p_width, p_height);
		}
		
	}

}
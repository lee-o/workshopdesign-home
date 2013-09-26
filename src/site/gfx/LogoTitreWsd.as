package site.gfx 
{
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	
	[Embed(source='bibliotheque.swf', symbol='logoTxt_wsd')]
	/**
	 * ...
	 * @author lee-o
	 */
	public class LogoTitreWsd extends Sprite
	{
		
		public function LogoTitreWsd() 
		{
			this.visible = false;
			this.alpha = 0;
		}
		
		public function apparition(time:Number = 1,_delay:Number = 0, value:Number = 1):void
		{
			TweenMax.to(this, time, {delay:_delay, autoAlpha:value } );
		}
		
	}

}
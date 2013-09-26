package site.gfx 
{
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	
	[Embed(source='bibliotheque.swf', symbol='logoLarge_mc')]
	/**
	 * ...
	 * @author lee-o
	 */
	public class LogoWsdLarge extends Sprite
	{
		
		public function LogoWsdLarge() 
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
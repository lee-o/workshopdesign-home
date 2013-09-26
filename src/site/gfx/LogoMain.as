package site.gfx 
{
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.FullScreenEvent;
	
	[Embed(source='bibliotheque.swf', symbol='logo_main')]
	/**
	 * ...
	 * @author lee-o
	 */
	public class LogoMain extends Sprite
	{
		public var LogoFbClick:Sprite;
		public var LogoFsClick:Sprite;
		public var LogoTwitClick:Sprite;
		public var LogoPinClick:Sprite;
		public var LogoStoreClick:Sprite;
		public var fs_true:Sprite;
		public var fs_false:Sprite;
		//
		public function LogoMain() 
		{
			this.visible = false;
			this.alpha = 0;
			fs_false.visible = false;
		}
		
		public function onFullScreen(e:FullScreenEvent):void 
		{
			if (MainWorkshopDesign.root.stage.displayState == StageDisplayState.FULL_SCREEN) {
				fs_true.visible = false;
				fs_false.visible = true;
			}else {
				fs_true.visible = true;
				fs_false.visible = false;
			}
		}
		
		public function apparition(time:Number = 1,_delay:Number = 0, value:Number = 1):void
		{
			TweenMax.to(this, time, {delay:_delay, autoAlpha:value } );
		}
		
	}

}
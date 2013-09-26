package site.pages 
{
	import FaceB.site.gfx.gradientBackground;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author lee-o
	 */
	public class Vignetting extends Sprite
	{
		private var gradientBackground_mc:gradientBackground;
		
		public function Vignetting() 
		{
			init();
		}
		
		private function init(e:Event = null):void 
		{
			gradientBackground_mc = new gradientBackground();
			addChild(gradientBackground_mc);
			resize();
			gradientBackground_mc.apparition(2, 1, 1);
		}
		
		public function resize(e:Event = null):void
		{
			if(stage){
				if (gradientBackground_mc && this.contains(gradientBackground_mc))
				{
					gradientBackground_mc.width = stage.stageWidth *2;
					gradientBackground_mc.height = stage.stageHeight *2;
					gradientBackground_mc.x = stage.stageWidth / 2 - gradientBackground_mc.width / 2;
					gradientBackground_mc.y = stage.stageHeight / 2 - gradientBackground_mc.height / 2;
				}
			}
		}
		
	}

}
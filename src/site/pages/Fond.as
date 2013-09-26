package site.pages 
{
	import site.gfx.noisePattern;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author lee-o
	 */
	public class Fond extends Sprite
	{
		[Event(name = "complete", type = "flash.events.Event")]
		//
		public var noisePattern_mc:noisePattern;
		private var largeurPattern:uint = 5;
		private var hauteurPattern:uint = 5;
		private var filesConstruct:uint = 0;
		private var filesToWait:uint = 1;
		
		public function Fond() 
		{
			init();
		}
		
		private function init(e:Event = null):void 
		{
			//
			noisePattern_mc = new noisePattern(largeurPattern, hauteurPattern, 4, 3,190,255);
			noisePattern_mc.addEventListener(Event.COMPLETE, noisePatternLoaded);
		}
		
		private function noisePatternLoaded(e:Event):void 
		{
			e.target.removeEventListener(Event.COMPLETE, noisePatternLoaded);
			checkIfAllConstruct();
		}
		
		
		private function checkIfAllConstruct(e:Event = null):void
		{
			
			filesConstruct++;
			if (filesConstruct == filesToWait) {
			//if (filesConstruct == 1) {
				addChild(noisePattern_mc);
				//
				resize();
				//
				//le module est construit on renvoi un complete 
				dispatchEvent(new Event(Event.COMPLETE));
				//
				noisePattern_mc.apparition(2, 0, 1);
			}
		}
		
		public function resize(e:Event = null):void
		{
			if(stage){
				if (noisePattern_mc && this.contains(noisePattern_mc))
				{
					noisePattern_mc.width = stage.stageWidth;
					noisePattern_mc.height = stage.stageHeight;
				}
			}
		}
		
	}

}
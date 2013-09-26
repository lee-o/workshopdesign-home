package site.pages 
{
	import com.greensock.TweenMax;
	import com.shic.displayObjects.Square2;
	import com.shic.displayObjects.TextFieldMonoLine;
	import site.events.FluxEvent;
	import site.flux.fluxRss;
	//import FaceB.site.flux.lastProject;
	import site.flux.lastProjectWithContact;
	import site.gfx.gradientBackground;
	import site.gfx.logoFaceB;
	import site.gfx.noisePattern;
	import MainWorkshopDesign;
	import site.navigation.DataLoader;
	import site.navigation.Navigation;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author lee-o
	 */
	public class Footer extends Sprite
	{
		//separation 1/3 <> 2/3 du rss et du last project sur une grille de 960 de large : 312 + 12 + (312 + 12 + 312)
		public var fluxRss_mc:fluxRss;
		//public var lastProject_mc:lastProject;
		public var lastProject_mc:lastProjectWithContact;
		private var largeurGlobale:int = DataLoader.largeurGlobale;
		private var margeGlobale:int = DataLoader.margeGlobale;
		private var largeurLecteurRSS:uint = DataLoader.largeurEncart;
		private var hauteurLecteurRSS:uint = DataLoader.hauteurEncart;
		private var largeurLastProject:uint = DataLoader.largeurEncart*2 + margeGlobale;
		private var hauteurLastProject:uint = DataLoader.hauteurEncart;
		private var filesConstruct:uint = 0;
		private var filesToWait:uint = 2;
		private var trait:Shape;
		
		public function Footer() 
		{
			
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			fluxRss_mc = new fluxRss(DataLoader.xmlRssLoader.xml, largeurLecteurRSS, hauteurLecteurRSS);
			fluxRss_mc.addEventListener(FluxEvent.READY_TO_PLAY, fluxRssLoaded);
			//
			lastProject_mc = new lastProjectWithContact(DataLoader.xmlFacebLoader.xml, largeurLastProject, hauteurLastProject);
			lastProject_mc.addEventListener(Event.COMPLETE, lastProjectLoaded);
		}
		
		private function lastProjectLoaded(e:Event):void 
		{
			//trace("lastProjectLoaded");
			e.target.removeEventListener(Event.COMPLETE, lastProjectLoaded);
			checkIfAllConstruct();
		}
		
		private function fluxRssLoaded(e:Event):void 
		{
			//trace("fluxRssLoaded");
			e.target.removeEventListener(FluxEvent.READY_TO_PLAY, fluxRssLoaded);
			checkIfAllConstruct();
		}
		
		private function checkIfAllConstruct(e:Event = null):void
		{
			filesConstruct++;
			if (filesConstruct == filesToWait) {
				addChild(fluxRss_mc);
				addChild(lastProject_mc);
				//
				lastProject_mc.x = DataLoader.largeurEncart + DataLoader.margeGlobale;
				//
				trait = new Shape();
				trait.alpha = 0;
				trait.name = "trait";
				trait.graphics.lineStyle(0, DataLoader.couleurTexteGris, 1, true,LineScaleMode.NONE);
				trait.graphics.moveTo(0, 0);
				trait.graphics.lineTo(DataLoader.largeurGlobale, 0);
				trait.y = int(fluxRss_mc.reelHeight + margeGlobale/2 + 1);
				addChild(trait);
				//
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		public function apparition():void 
		{
			fluxRss_mc.apparition(DataLoader.tempsApparition, 0, 1);
			lastProject_mc.apparition(DataLoader.tempsApparition, 1, 1);
			TweenMax.to(trait,DataLoader.tempsApparition,{alpha:1});
		}
		
	}

}
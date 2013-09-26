package site.navigation
{
	import com.greensock.*;
	import com.thinkadelik.stat.Ga;
	import flash.events.Event;
	import site.pages.ContenuPage;
	import site.pages.Page;
	import site.pages.PageHome;
	import site.pages.PageTexte;
	/**
	 * ...
	 * @author 
	 */
	public class Navigation
	{
		public static var currentPage:ContenuPage;
		
		public static var TYPE:String;
		
		public function Navigation() 
		{
			
		}
		
		public static function setLoading(etat:Boolean):void {
			MainWorkshopDesign.loading.visible = etat;
		}
		
		private static function fadeOk(xmlList:XMLList, type:String):void
		{
			//trace("Navigation --> fct --> fadeOk");
			TweenMax.killDelayedCallsTo(currentPage.apparition);
			TweenMax.killTweensOf(currentPage);
			MainWorkshopDesign.page.removeChild(currentPage);
			currentPage = null;
			//
			openPage(xmlList,type);
		}
		
		public static function openPage(xmlList:XMLList, type:String):void {
			//trace("Navigation --> fct --> openPage");
			if (currentPage == null)
			{
				//trace("Navigation --> currentPage == null");
				if (type == "Home") {
					currentPage = new PageHome(xmlList,type);
				}
				if (type == "About") {
					currentPage = new PageTexte(xmlList,type);
				}
				if (type == "Contact") {
					currentPage = new PageTexte(xmlList,type);
				}
				currentPage.addEventListener(Event.COMPLETE, affichePage);
				MainWorkshopDesign.page.addChild(currentPage);
				/*var obj:Object = new Object();
				obj.name = type;
				Ga.track("Page", obj);*/
				Ga.Page(type);
				MainWorkshopDesign.page.scrollGlobal.dragged = currentPage;
				MainWorkshopDesign.page.scrollGlobal.reset();
				//TweenMax.delayedCall(DataLoader.tempsApparition/2,showScroll);
				//
				TYPE = type;
			}else {
				if (type != currentPage.TYPE)
				{
					currentPage.removeEventListener(Event.COMPLETE, affichePage);
					TweenMax.to(currentPage, DataLoader.tempsApparition / 2, { autoAlpha:0, onComplete: fadeOk, onCompleteParams:[xmlList, type] } );
					TweenMax.to(MainWorkshopDesign.page.scrollGlobal, DataLoader.tempsApparition / 2, { autoAlpha:0} );
				}
			}
		}
		
		public static function showScroll():void
		{
			TweenMax.to(MainWorkshopDesign.page.scrollGlobal, DataLoader.tempsApparition / 2, { autoAlpha:1} );
		}
		
		public static function affichePage(e:Event):void
		{
			//trace("Navigation --> fct --> affichePage");
			currentPage.removeEventListener(Event.COMPLETE, affichePage);
			TweenMax.killDelayedCallsTo(currentPage.apparition);
			TweenMax.killDelayedCallsTo(showScroll);
			
			//MainWorkshopDesign.resize();
			TweenMax.delayedCall(DataLoader.tempsApparition / 4, currentPage.apparition);
			TweenMax.delayedCall(DataLoader.tempsApparition*2,showScroll);
		}	
		
	}

}
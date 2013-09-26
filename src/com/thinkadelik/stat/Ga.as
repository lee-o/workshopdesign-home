package com.thinkadelik.stat 
{
	//import com.google.analytics.AnalyticsTracker;
	//import com.google.analytics.GATracker;
	import com.greensock.TweenMax;
	//import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	//import flash.utils.Timer;
	//import site.navigation.DataLoader;
	/**
	 * ...
	 * @author lee-o
	 */
	public class Ga 
	{
		static private var _p:String;
		static private var _p1:String;
		static private var _p2:String;
		//public static var tracker:AnalyticsTracker;
		
		public function Ga() 
		{
			/*try{
				tracker = new GATracker( MainWorkshopDesign.root, DataLoader.gaCode, "Bridge", false );
			}catch (e:Error) {
				
			}*/
		}
		
		/*public static function track(type:String,param:Object = null):void
		{
			if (type == "Page") {
				tracker.trackPageview(param.name);
			}else if (type == "Event") {
				TweenMax.delayedCall(1,tracker.trackEvent,[param.type, param.name]);
			}
		}*/
		
		/**
		 * Fait appel au js embbed sur l index pour le taguage
		 * Taguage de page
		 * @param	p		le nom de la page
		 */
		public static function Page(p:String):void
		{
			try{
				ExternalInterface.call("Page", p);
			}catch (e:Error) {
				
			}
		}
		/**
		 * Fait appel au js embbed sur l index pour le taguage
		 * Taguage d'Event
		 * @param	p1		le type d'objet
		 * @param	p2		l'event sur l'objet
		 */
		public static function Event(p1:String,p2:String):void
		{
			_p1 = p1;
			_p2 = p2;
			TweenMax.delayedCall(0.5,extCall);
		}
		
		static private function extCall():void 
		{
			try{
				ExternalInterface.call("Event", _p1, _p2);
			}catch (e:Error) {
				
			}
		}
		
	}

}


		 
		
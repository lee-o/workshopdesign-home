package cc.shic.display.text 
{
	import cc.shic.events.CustomEvent;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.Security;
	import flash.text.Font;
	import flash.display.LoaderInfo;
	
	/**
	 * ...
	 * @author david@shic.fr
	 */
	public class FontLoader extends EventDispatcher
	{
		public var fontName:String;
		private var loader:Loader;
		
		public function FontLoader(swfUrl:String,fontName:String) 
		{
			Security.allowDomain("*");
			
			this.fontName = fontName;
			
			loader = new Loader();
			loader.load(new URLRequest(swfUrl));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoad);
		}
		[Event(name="onDownloadComplete", type="cc.shic.events.CustomEvent")]
		private function onLoad(e:Event):void 
		{
			var policeIntegrees:Array = Font.enumerateFonts();
			
			// énumération des polices intégrées
			trace( policeIntegrees.length );
			//trace(policeIntegrees[0].fontName);
			//trace(fontName);
			
			trace(loader.content);
			
			for (var i:String in e.target.content) {
				trace("----" + i);
			}
		
			var domain:ApplicationDomain = loader.contentLoaderInfo.applicationDomain;
			var font:Class = domain.getDefinition(fontName) as Class;
			Font.registerFont(font);

		
			
			
			
			// affiche : 0
			policeIntegrees = Font.enumerateFonts();
			trace( policeIntegrees.length );
			Font.registerFont ( font );
			policeIntegrees = Font.enumerateFonts();
			// affiche : 1
			trace( policeIntegrees.length );
			// affiche : [object Lovitz]
			//trace( policeIntegrees[0] );
			
			dispatchEvent(new CustomEvent(CustomEvent.ON_DOWNLOAD_COMPLETE));
		}
		
	}

}
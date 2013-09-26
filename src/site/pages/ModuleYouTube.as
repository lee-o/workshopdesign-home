package site.pages 
{
	import com.greensock.TweenMax;
	import com.shic.displayObjects.Square;
	import com.shic.displayObjects.TextFieldMonoLine;
	import com.shic.utils.Utils;
	import com.thinkadelik.stat.Ga;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.text.TextFormat;
	import site.navigation.DataLoader;
	//
	[Embed(source='../gfx/bibliotheque.swf', symbol='picto_player')]
	/**
	 * ...
	 * @author yo
	 */
	public class ModuleYouTube extends ContenuPage 
	{
		private var player:Object;
		private var loader:Loader = new Loader();
		private var contenuXml:XMLList;
		private	var nbreRefs:uint;
		private var xml:XMLList;
		private var posPlayerY:uint;
		private var ratioVideo:Number;
		private	var largeurVideo:uint;
		private	var hauteurVideo:uint;
		public var hauteurModule:uint;
		private var setToMedium:Boolean = false;
		private var playing:Boolean = false;
		//BTN
		public var playButton:Sprite;
		public var pauseButton:Sprite;
		public var soundButton:Sprite;
		public var soundStopButton:Sprite;
		private var zoneSensible:Square;
		private var youTubeBtn:Square;
		//VAR
		private var isWidescreen:Boolean;
		// CONSTANTS.
		private static var DEFAULT_VIDEO_URL:String;
		private static var EMBED_VIDEO_URL:String;
		private static const PLAYER_URL:String = "http://www.youtube.com/apiplayer?version=3";
		private static const SECURITY_DOMAIN:String = "http://www.youtube.com";
		private static const YOUTUBE_API_PREFIX:String = "http://gdata.youtube.com/feeds/api/videos/";
		private static const YOUTUBE_API_VERSION:String = "2";
		private static const YOUTUBE_API_FORMAT:String = "5";
		private static const WIDESCREEN_ASPECT_RATIO:String = "widescreen";
		private static const QUALITY_TO_PLAYER_WIDTH:Object = { small: 320, medium: 640, large: 854, hd720: 1280};
		private static const STATE_ENDED:Number = 0;
		private static const STATE_PLAYING:Number = 1;
		private static const STATE_PAUSED:Number = 2;
		private static const STATE_CUED:Number = 5;
		

		
		public function ModuleYouTube(_xml:XMLList):void 
		{
			visible = false;
			alpha = 0;
			xml = _xml;
			EMBED_VIDEO_URL = xml.ref.url;
			DEFAULT_VIDEO_URL = xml.ref.video;
			//
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			//
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			contenuXml = xml.child("ref");
			nbreRefs = contenuXml.length();
			//
			var titre:TextFieldMonoLine = new TextFieldMonoLine(xml.name);
			DataLoader.xmlStyleLoader.appliqueFormat(titre, "Helvetica-Neue-Lt-Std-Thin");
			var sizeTitreFormat:TextFormat = new TextFormat();
			sizeTitreFormat.size = sizeTitre;
			titre.setTextFormat(sizeTitreFormat);
			titre.textColor = DataLoader.couleurTexteBlanc;
			//
			var trait:Shape = new Shape();
			trait.graphics.beginFill(0xff0000, 1);
			trait.graphics.lineStyle(0, DataLoader.couleurTrait, 1);
			trait.graphics.lineTo(DataLoader.largeurPage - DataLoader.margeGlobale * 2,0);
			trait.graphics.endFill();
			//
			//for (var p:uint = 0; p < nbreRefs; p++) {
				//YOUTUBE PLAYER
				loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit);
				loader.load(new URLRequest("http://www.youtube.com/apiplayer?version=3"));
			//}
			titre.x = titre.y = trait.x = DataLoader.margeGlobale;
			trait.y = titre.y + titre.height;
			posPlayerY = trait.y + 8;
			//
			addChild(titre);
			addChild(trait);
			//
			// Create a Button for playing the cued video.
			//playButton = new Square(20, 20, 0x006699, 1);
			playButton.addEventListener(MouseEvent.CLICK, playButtonClickHandler);
			addChild(playButton);
			playButton.mouseChildren = false;
			playButton.buttonMode = true;
			//playButton.alpha = 0;
			//
			// Create a Button for pausing the cued video.
			//pauseButton = new Square(20, 20, 0xff0000, 1);
			pauseButton.addEventListener(MouseEvent.CLICK, pauseButtonClickHandler);
			addChild(pauseButton);
			pauseButton.mouseChildren = false;
			pauseButton.buttonMode = true;
			pauseButton.alpha = 0;
			//
			// Create a Button for pausing the cued video.
			//soundButton = new Square(20, 20, 0x00ff00, 1);
			soundButton.addEventListener(MouseEvent.CLICK, soundButtonClickHandler);
			soundButton.addEventListener(MouseEvent.MOUSE_OUT, hideBtn);
			addChild(soundButton);
			soundButton.mouseChildren = false;
			soundButton.buttonMode = true;
			soundButton.alpha = 0;
			//
			soundStopButton.addEventListener(MouseEvent.CLICK, soundButtonClickHandler);
			soundStopButton.addEventListener(MouseEvent.MOUSE_OUT, hideBtn);
			addChild(soundStopButton);
			soundStopButton.mouseChildren = false;
			soundStopButton.buttonMode = true;
			soundStopButton.alpha = 0;
			//
			youTubeBtn = new Square(60, 30, 0x00ff00, 0);
			addChild(youTubeBtn);
			youTubeBtn.addEventListener(MouseEvent.CLICK, youTubeBtnHandler);
			youTubeBtn.addEventListener(MouseEvent.MOUSE_OUT, hideBtn);
			youTubeBtn.mouseChildren = false;
			youTubeBtn.buttonMode = true;
		}
		
		private function outHandler(e:MouseEvent):void 
		{
			
		}
		
		private function youTubeBtnHandler(e:MouseEvent):void 
		{
			MainWorkshopDesign.MainPause();
			Utils.openExternalPage(EMBED_VIDEO_URL);
		}

		private function playButtonClickHandler(e:MouseEvent):void {
			//trace("---> " + player.getPlaybackQuality());
			player.playVideo();
			if (!setToMedium)
			{
				setToMedium = true;
				player.setPlaybackQuality("medium");
			}
		}

		public function pauseButtonClickHandler(e:MouseEvent = null):void {
			//trace("---> " + player.getPlaybackQuality());
			player.pauseVideo();
			if (!setToMedium)
			{
				setToMedium = true;
				player.setPlaybackQuality("medium");
			}
		}
		
		public function soundButtonClickHandler(e:MouseEvent = null):void {
			if (player.isMuted())
			{
				player.unMute();
				soundButton.visible = true;
				soundStopButton.visible = false;
				soundButton.alpha = 1;
			}else {
				player.mute();
				soundButton.visible = false;
				soundStopButton.visible = true;
				soundStopButton.alpha = 1;
			}
		}
		
		private function onLoaderInit(event:Event):void {
			addChild(loader);
			loader.content.addEventListener("onReady", onPlayerReady);
			loader.content.addEventListener("onError", onPlayerError);
			loader.content.addEventListener("onStateChange", onPlayerStateChange);
			loader.content.addEventListener("onPlaybackQualityChange", onVideoPlaybackQualityChange);
		}
		
		private function onVideoPlaybackQualityChange(event:Event):void {
			//trace("Current video quality:", Object(event).data);
			//trace("onVideoPlaybackQualityChange");
			resizePlayer(Object(event).data);
		}

		private function resizePlayer(qualityLevel:String):void {
			//trace("resizePlayer");
			player.setSize(largeurVideo, hauteurVideo );
			player.x = DataLoader.margeGlobale;
			player.y = posPlayerY;
		}

		private function onPlayerReady(event:Event):void {
			
			player = loader.content;
			player.loadVideoByUrl(DEFAULT_VIDEO_URL);
			//player.pauseVideo();
			//
			ratioVideo = (xml.ref.largeur_player / xml.ref.hauteur_player);
			largeurVideo = DataLoader.largeurPage - 2 * DataLoader.margeGlobale;
			hauteurVideo = largeurVideo / ratioVideo;
			//
			hauteurModule = posPlayerY + hauteurVideo;
			//
			player.setSize(largeurVideo, hauteurVideo);
			//
			player.x = DataLoader.margeGlobale;
			player.y = posPlayerY;
			//
			//
			zoneSensible = new Square(largeurVideo,hauteurVideo,0x00ff00,0);
			addChild(zoneSensible);
			zoneSensible.x = player.x;
			zoneSensible.y = player.y;
			//
			youTubeBtn.x = zoneSensible.x + zoneSensible.width - youTubeBtn.width;
			youTubeBtn.y = zoneSensible.y + zoneSensible.height - youTubeBtn.height;
			//
			zoneSensible.addEventListener(MouseEvent.MOUSE_OVER, showBtn);
			zoneSensible.addEventListener(MouseEvent.MOUSE_OUT, hideBtn);
			zoneSensible.mouseChildren = false;
			player.mouseChildren = false;
			//
			resize();
			//trace(":: " , this.height);
			//MainWorkshopDesign.resize();
			SetSize();
		}
		
		private function SetSize():void
		{
			setToMedium = true;
			player.setPlaybackQuality("medium");
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function hitTest(e:Event):void 
		{
			trace(e.target.hitTestPoint(MainWorkshopDesign.root.mouseX, MainWorkshopDesign.root.mouseY,true));
		}
		
		private function showBtn(e:MouseEvent):void 
		{
			playButton.visible ? TweenMax.to(playButton, DataLoader.tempsApparition / 2, { alpha:1 } ):TweenMax.to(pauseButton, DataLoader.tempsApparition / 2, { alpha:1 } );
			player.isMuted() ? TweenMax.to(soundStopButton, DataLoader.tempsApparition / 2, { autoAlpha:1 } ):TweenMax.to(soundButton, DataLoader.tempsApparition / 2, { autoAlpha:1 } );
		}
		
		private function hideBtn(e:MouseEvent):void 
		{
			if (!e.target.hitTestPoint(MainWorkshopDesign.root.mouseX, MainWorkshopDesign.root.mouseY, true))
			{
				if (playing == true)
				{
					playButton.visible ? TweenMax.to(playButton, DataLoader.tempsApparition / 2, { alpha:0 } ):TweenMax.to(pauseButton, DataLoader.tempsApparition / 2, { alpha:0 } );
					player.isMuted() ? TweenMax.to(soundStopButton, DataLoader.tempsApparition / 2, { autoAlpha:0 } ):TweenMax.to(soundButton, DataLoader.tempsApparition / 2, { autoAlpha:0 } );
				}
			}
		}

		private function onPlayerError(event:Event):void {
			// Event.data contains the event parameter, which is the error code
			//trace("player error:", Object(event).data);
		}

		private function onPlayerStateChange(event:Event):void {
			// Event.data contains the event parameter, which is the new player state
			//trace("player state: ",Object(event).data);
			var obj:Object = new Object();
			switch (Object(event).data) {
				case STATE_PLAYING:
					playing = true;
					//trace("playing");
					playButton.visible = false;
					pauseButton.visible = true;
					obj.type = "video";
					obj.name = "play";
					//Ga.track("Event", obj);
					Ga.Event("video", "play");
					break;
				case STATE_PAUSED:
					playing = false;
					//trace("paused");
					playButton.visible = true;
					pauseButton.visible = false;
					obj.type = "video";
					obj.name = "paused";
					//Ga.track("Event", obj);
					Ga.Event("video", "paused");
					break;
				case STATE_ENDED:
					playing = false;
					playButton.visible = true;
					pauseButton.visible = false;
					obj.type = "video";
					obj.name = "end";
					//Ga.track("Event", obj);
					Ga.Event("video", "end");
					break;
				/*case STATE_PLAYING:
					//playButton.visible = false;
					//pauseButton.visible = true;
				case STATE_PAUSED:
					//playButton.visible = true;
					//pauseButton.visible = false;
					break;*/
			}
		}
		
		private function checkIfAllLoaded(e:Event):void 
		{
			/*imgLoaded++;
			if (imgLoaded == nbreRefs) {
				//TweenMax.to(this, DataLoader.tempsApparition, { autoAlpha:1 } );
				dispatchEvent(new Event(Event.COMPLETE));
			}*/
		}
		
		public override function resize():void {
			playButton.x = pauseButton.x = largeurVideo/2 + DataLoader.margeGlobale;
			playButton.y = pauseButton.y = hauteurVideo/2 + player.y;
			soundButton.x = soundStopButton.x = DataLoader.margeGlobale;
			soundButton.y = soundStopButton.y = hauteurVideo + player.y;
			soundStopButton.visible = false;
			//
			addChild(pauseButton);
			addChild(playButton);
			addChild(soundButton);
			addChild(soundStopButton);
			addChild(youTubeBtn);			
		}
		
		public override function apparition():void {
			//
			resize();
			//
			/*var toto:Square = new Square(width, height, 0x00ff00, 0.3);
			toto.y = toto.x = DataLoader.margeGlobale
			addChild(toto);*/
			//
			TweenMax.to(this, DataLoader.tempsApparition, { autoAlpha:1 } );
			//trace("--> ", this.height);
		}
		
		private function destroy(e:Event):void 
		{
			player.destroy();
			loader.content.removeEventListener("onReady", onPlayerReady);
			loader.content.removeEventListener("onError", onPlayerError);
			loader.content.removeEventListener("onStateChange", onPlayerStateChange);
			loader.content.removeEventListener("onPlaybackQualityChange", onVideoPlaybackQualityChange);
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			TweenMax.killTweensOf(this);
			
		}
		
	}
	
}
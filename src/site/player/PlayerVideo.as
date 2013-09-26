package site.player 
{
	/////
	//import com.shic.stats.ga;
	//import com.shic.share.share_window;
	import com.greensock.easing.Circ;
	import com.shic.displayObjects.Square2;
	import com.shic.utils.EasyLoaderEvent;
	import MainWorkshopDesign;
	import flash.ui.Mouse;
	//import com.shic.share.share_window;
	import com.shic.utils.EasyLoader;
	import com.shic.utils.Utils;
	import com.greensock.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import com.thinkadelik.sharedObject.MySharedObject;
	[Embed(source='bibliotheque.swf', symbol='playerTemplate')]
	/////
	public class PlayerVideo extends Sprite
	{
		/////
		[Event(name = "ready_to_play", type = "FaceB.site.player.PlayerEvent")]
		[Event(name = "stop", type = "FaceB.site.player.PlayerEvent")]
		//
		//SPRITES IMPORTES
		public var timing_btn:Sprite;
		public var sound_btn:Sprite;
		public var playPausePlay_bmp:Sprite;
		public var playPausePause_bmp:Sprite;
		public var grosPlay_btn:Sprite;
		public var fullscreenTrue_bmp:Sprite;
		public var fullscreenFalse_bmp:Sprite;
		public var forme_carree_blanc:Sprite;
		public var no_fs_bmp:Sprite;
		public var fs_bmp:Sprite;
		public var pictoSeek:Sprite;
		//
		//
		//SPRITES CREES
		//conteneur global du player
		private var conteneur_mc:Sprite;
		//video_mc: le clip qui contient l'objet video, c'est lui qui est redimenssioné
		private var video_mc:Sprite;
		//v_video: l'objet video dans video_mc
		private var v_video:Video; 
		//photo_mc : clip qui contient l image d attente
		private var photo_mc:Sprite; 
		//easyloader qui charge la photo d'attente
		private var conteneurImage:EasyLoader
		//sprite navigation_mc, barre de menu pour la nav du player
		private var navigation_mc:Sprite;
		private var total:Square2;
		private var stream:Square2;
		private var seekClik:Square2;
		private var seek:Square2;
		private var fondNavigation_mc:Square2;
		private var fullscreen_btn:Sprite;
		private var playPause_btn:Sprite;
		public var fondPlayer_mc:Square2;
		public var maskVideo:Rectangle;
		
		//
		//VARIABLES
		//video plein ecran
		public var isFullscreen:Boolean = false;
		//lecture automatique ou pas
		private var autoPlay:String;
		//lecture en boucle
		private var boucle:String;
		//defini si on crop la video ou si on affiche tout
		private var crop:String;
		//defini si le player s adapte a la taille du stage au resize ou pas
		private var alwaysResize:String;
		//defini si le son est actif ou pas
		private var sound:String;
		//defini le niveau de volume
		private var soundVolume:Number;
		//defini la taille du picto son, pas beau mais pas envie de reflechir
		private var couleurAudioWidth:Number;
		//coordonees X ou on lache le clik souris sur le picto son
		private var outPictoSound:Number;
		//Shared Object pour le son
		private var SO:MySharedObject = new MySharedObject();
		//adresse de la video
		private var videoURL:String;
		//adresse de l image d accueil
		private var pictureURL:String;
		//defini si le bouton share ets activé ou pas, false par defaut
		private var isShareable:Boolean;
		//les dif. attributs distribué par onMetaData
		private var proprieteVideo:Object;
		//flux ns lancé ou pas
		private var nsLaunch:Boolean = false;
		//defini si on a atteint la fin de la video
		private var stopped:Boolean = false;
		//obj netConnection
		private var nc:NetConnection;
		//obj netStream
		private var ns:NetStream;
		//obj metadata
		private var customClient:Object;
		//position de la souris pour voir si elle bouge
		private var Xmouse:Number;
		private var Ymouse:Number;
		//temporisation de verification de position de la souris
		private var chekMousePos:int;
		//definition des temps avant disparition de la barre de nav du player mutliplié par la valeur atribuee a chekMousePos
		private var dureeTemporisation:int = 15;
		private var compteurTemporisation:int = 0;
		//obj sound
		public var video_sound:SoundTransform;
		//definition de la hauteur de la barre de menu
		public var hauteurBarre:uint = 36;
		//variable memoire temporaire son 
		public var tempVolume:Number;
		//lecture : play ou pause / on sait si la video est deja jouee ou pas 
		private var isPlaying:Boolean = false;
		//firstPlay 
		private var firstPlay:Boolean = true;
		//indique si on a cliquer sur la barre de seek pour rechercher un moment du stream, permet de relancer la video si on arrive cliqué sur la barre
		private var seeker:Boolean;
		//si meta data deja charge
		public var isMetaData:Boolean = false;
		//les couleurs
		private var color_level_1:Number = 0xcacaca;
		private var color_level_2:Number = 0x666666;
		private var color_level_3:Number = 0xffffff;
		private var color_background:Number = 0x000000;
		private var colorTransform_level_1:ColorTransform = new ColorTransform();
		private var colorTransform_level_2:ColorTransform = new ColorTransform();
		private var colorTransform_level_3:ColorTransform = new ColorTransform();
		//
		public var videoWidth:uint;
		public var videoHeight:uint;
		//
		private var idPlayer:int = Math.random() * 1000;
		//
		//LES ELEMENTS DES SOUS CLIPS DES CLIPS IMPORTES
		private var textTiming_mc:TextField;
		private var couleurAudio:Sprite;
		private var fondAudio:Sprite;
		private var textSeek:TextField;
		private var fondPictoSeek:Sprite;
		private var play_mc:Sprite;
		//
		//marge de decalage des pictos
		private var margePicto:uint = 6;
		//
		/////
		/**
		 * Player vidéo			tout est dit
		 * @param	pUrl		chemin du fichier video
		 * @param	pPict		chemin de l image a telecharger en lieu et place de la video si autoplay == false
		 * @param 	pLargeur	largeur de base de la video, donc du player
		 * @param 	pHauteur	hauteur de base de la video, donc du player
		 * @param	pAutoPlay	lance la video des que le player est configuré ou pas | false par defaut
		 * @param	pBoucle		boucle la video une fois terminée ou pas | false par defaut
		 * @param	pColor1		
		 * @param	pColor2		
		 * @param	pColor3		
		 */
		public function PlayerVideo(pUrl:String, pPict:String, pLargeur:uint, pHauteur:uint, pAutoPlay:String = "false", pBoucle:String = "false",pCrop:String = "true", pAlwaysResize:String = "false", pColor1:Number = 0, pColor2:Number = 0, pColor3:Number = 0, pColor4:Number = 0) {
			//
			//trace(idPlayer + "--> *1 | PlayerVideo()");
			autoPlay = pAutoPlay;
			boucle = pBoucle;
			crop = pCrop;
			alwaysResize = pAlwaysResize;
			videoURL = pUrl;
			pictureURL = pPict;
			videoWidth = pLargeur;
			videoHeight = pHauteur;
			pColor1 == 0 ? color_level_1 : color_level_1 = pColor1;
			pColor2 == 0 ? color_level_2 : color_level_2 = pColor2;
			pColor3 == 0 ? color_level_3 : color_level_3 = pColor2;
			pColor4 == 0 ? color_background : color_background = pColor4;
			//
			colorTransform_level_1.color = color_level_1;
			colorTransform_level_2.color = color_level_2;
			colorTransform_level_3.color = color_level_3;
			//
			//DEFINITION DES SOUS CLIPS IMPORTES
			textTiming_mc = timing_btn.getChildByName("t_txt") as TextField;
			couleurAudio = sound_btn.getChildByName("couleurAudio") as Sprite;
			fondAudio = sound_btn.getChildByName("fondAudio") as Sprite;
			textSeek = pictoSeek.getChildByName("t_txt") as TextField;
			textSeek.autoSize = TextFieldAutoSize.CENTER;
			fondPictoSeek = pictoSeek.getChildByName("fondPictoSeek") as Sprite;
			play_mc = grosPlay_btn.getChildByName("play_mc") as Sprite;
			//
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE,init)
			}
		}
		
		private function init(e:Event = null):void 
		{
			//trace(idPlayer + "--> *2 | init()");
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, REMOVED_FROM_STAGE_Handler);
			//stage.addEventListener(Event.MOUSE_LEAVE, mouseLeave);
			//
			this.alpha = 0;
			this.visible = false;
			//
			chargePhoto();
		}
		/////
		private function chargePhoto():void {
			//
			//trace(idPlayer + "--> *3 | chargePhoto()");
			if(pictureURL != "" && pictureURL != null){
				conteneurImage = new EasyLoader(pictureURL, true,0.5,false);
				conteneurImage.name = "conteneurImage";
				conteneurImage.addEventListener(Event.COMPLETE, pictureLoaded);
				conteneurImage.addEventListener(EasyLoaderEvent.ERROR, pictureError);
			}else {
				buildPlayer();
			}
			
		}
		/////
		private function pictureLoaded(e:Event):void 
		{
			Utils.smoothRecursive(conteneurImage);
			buildPlayer();
		}
		/////
		private function pictureError(e:EasyLoaderEvent):void
		{
			pictureURL = "";
			buildPlayer();
		}
		/////
		public function buildPlayer(e:Event = null):void {
			//
			//trace(idPlayer + "--> *4 | buildPlayer()");
			if(conteneurImage){
				conteneurImage.removeEventListener(Event.COMPLETE, buildPlayer);
				conteneurImage.removeEventListener(EasyLoaderEvent.ERROR, pictureError);
			}
			//
			//GESTION NS ET NC
			nc = new NetConnection();
			nc.connect(null);
			ns = new NetStream(nc);
			ns.addEventListener(IOErrorEvent.IO_ERROR, IO_ERROR_Handler);
			ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, ASYNC_ERROR_Handler); 
			ns.addEventListener(NetStatusEvent.NET_STATUS, NET_STATUS_Handler);
			customClient = new Object();
			customClient.onMetaData = METADATA_Handler; 
			ns.client = customClient;
			//
			//
			//GESTION CREATION CLIP PLAYER ET CONTENEUR
			v_video = new Video(); 
			v_video.deblocking = 1;
			v_video.smoothing = true;
			v_video.attachNetStream(ns);
			//
			//
			//GESTION ET CREATION DE LA BARRE DE NAVIGATION ET DU PLAYER
			conteneur_mc = new Sprite();
			video_mc = new Sprite();
			photo_mc = new Sprite();
			navigation_mc = new Sprite();
			navigation_mc.name = "navigation_mc";
			fullscreen_btn = new Sprite();
			playPause_btn = new Sprite();
			fondNavigation_mc = new Square2(1,hauteurBarre,color_background,0.5);
			total = new Square2(1000,2,color_background,1);
			stream = new Square2(1000,2,color_level_2,1);
			seekClik = new Square2(1000, hauteurBarre, color_background, 0);
			seek = new Square2(1000, 2, color_level_1, 1);
			fondPlayer_mc = new Square2(videoWidth, videoHeight, color_background, 1);
			TweenMax.to(fondAudio, 0, { tint: color_level_2 } );
			//
			//
			//GESTION SOUND AVEC LE SHARED OBJECT
			video_sound = ns.soundTransform;
			couleurAudioWidth = couleurAudio.width;
			//
			var soundOnCookie:* = SO.getValue("soundOn");
			var soundVolumeCookie:* = SO.getValue("soundVolume");
			if(soundOnCookie != undefined){
				sound = soundOnCookie;
			}else {
				sound = "true";
				SO.setValue("soundOn", sound);
			}
			//
			if(soundVolumeCookie != undefined){
				soundVolume = soundVolumeCookie;
			}else {
				if(sound == "true"){
					soundVolume = 1;
				}else {
					soundVolume = 0;
				}
				SO.setValue("soundVolume", soundVolume);
			}
			video_sound.volume = soundVolume;
			couleurAudio.width = soundVolume * couleurAudioWidth;
			//
			ns.soundTransform = video_sound;
			//
			//
			//ATTRIBUTIONS DES FONCTION BTN
			total.mouseEnabled = false;
			seek.mouseEnabled = false;
			fullscreen_btn.buttonMode = true;
			fullscreen_btn.mouseChildren = false;
			fullscreenTrue_bmp.visible = true;
			fullscreenFalse_bmp.visible = false;
			grosPlay_btn.buttonMode = true;
			grosPlay_btn.mouseChildren = false;
			playPause_btn.buttonMode = true;
			playPause_btn.mouseChildren = false;
			playPausePlay_bmp.visible = true;
			playPausePause_bmp.visible = false;
			sound_btn.buttonMode = true;
			sound_btn.mouseChildren = false;
			//
			//
			//ATTRIBUTIONS DES COULEURS AUX BTN
			fullscreenTrue_bmp.transform.colorTransform = colorTransform_level_1;
			fullscreenFalse_bmp.transform.colorTransform = colorTransform_level_1;
			playPausePlay_bmp.transform.colorTransform = colorTransform_level_1;
			playPausePause_bmp.transform.colorTransform = colorTransform_level_1;
			couleurAudio.transform.colorTransform = colorTransform_level_1;
			fondPictoSeek.transform.colorTransform = colorTransform_level_3;
			textSeek.transform.colorTransform = colorTransform_level_2;
			//
			//
			//ATTACHEMENT SUR LA SCENE
			fullscreen_btn.addChild(fullscreenTrue_bmp);
			fullscreen_btn.addChild(fullscreenFalse_bmp);
			playPause_btn.addChild(playPausePause_bmp);
			playPause_btn.addChild(playPausePlay_bmp);
			navigation_mc.addChild(fondNavigation_mc);
			navigation_mc.addChild(total);
			navigation_mc.addChild(stream);
			navigation_mc.addChild(seek);
			navigation_mc.addChild(pictoSeek);
			navigation_mc.addChild(seekClik);
			navigation_mc.addChild(playPause_btn);
			navigation_mc.addChild(timing_btn);
			navigation_mc.addChild(fullscreen_btn);
			navigation_mc.addChild(sound_btn);
			if(conteneurImage){
				photo_mc.addChild(conteneurImage);
			}
			video_mc.addChild(v_video);
			conteneur_mc.addChild(fondPlayer_mc);
			//on attache la video plus tard pour eviter des erreurs sandbox
			//conteneur_mc.addChild(video_mc);
			conteneur_mc.addChild(photo_mc);
			conteneur_mc.addChild(navigation_mc);
			conteneur_mc.addChild(grosPlay_btn);
			addChild(conteneur_mc);
			//POSITIONNEMENT DES ELEMENTS QUI NE VARIENT PAS AU RESIZE
			playPause_btn.x = margePicto;
			timing_btn.x = playPause_btn.x + playPause_btn.width;
			total.x = timing_btn.x + timing_btn.width + margePicto;
			stream.x = seekClik.x = seek.x = total.x;
			//
			//
			//MASK
			maskVideo = new Rectangle(0, 0, videoWidth, videoHeight);
			conteneur_mc.scrollRect = maskVideo;
			//
			//
			//ON ASSOCIE LES ECOUTEURS AU DIFFERENTS BOUTONS
			video_mc.doubleClickEnabled = true;
			video_mc.addEventListener(MouseEvent.DOUBLE_CLICK, toggleFullScreen_Handler);
			//
			fullscreen_btn.addEventListener(MouseEvent.MOUSE_OVER, overBtn);
			fullscreen_btn.addEventListener(MouseEvent.MOUSE_OUT, outBtn);
			fullscreen_btn.addEventListener(MouseEvent.MOUSE_UP, toggleFullScreen_Handler); 
			//
			grosPlay_btn.addEventListener(MouseEvent.MOUSE_OVER, overGbpBtn);
			grosPlay_btn.addEventListener(MouseEvent.MOUSE_OUT, outGbpBtn);
			grosPlay_btn.addEventListener(MouseEvent.MOUSE_DOWN, PLAY_PAUSE_Handler);
			//
			playPause_btn.addEventListener(MouseEvent.MOUSE_OVER, overBtn);
			playPause_btn.addEventListener(MouseEvent.MOUSE_OUT, outBtn);
			playPause_btn.addEventListener(MouseEvent.CLICK, PLAY_PAUSE_Handler);
			//
			navigation_mc.addEventListener(Event.ENTER_FRAME, timerHandler);
			//
			sound_btn.addEventListener(MouseEvent.ROLL_OVER, overSoundBtn);
			sound_btn.addEventListener(MouseEvent.ROLL_OUT, outSoundBtn);
			sound_btn.addEventListener(MouseEvent.MOUSE_DOWN, volumeDownHandler);
			sound_btn.addEventListener(MouseEvent.MOUSE_UP, volumeUpHandler);
			//
			seekClik.addEventListener(MouseEvent.MOUSE_OVER, overSeekBtn);
			seekClik.addEventListener(MouseEvent.MOUSE_OUT, outSeekBtn);
			seekClik.addEventListener(MouseEvent.MOUSE_DOWN, seek_Handler);
			seekClik.addEventListener(MouseEvent.MOUSE_UP, replay_Handler);
			//
			//
			//RESIZE
			resize();
			//
			//
			//TRIX: on cache la barre de seek, sinon on voie un pixel qui depasse
			seek.alpha = 0;
			seek.visible = false;
			stream.alpha = 0;
			stream.visible = false;
			pictoSeek.alpha = 0;
			pictoSeek.visible = false;
			//
			//
			//LE PLAYER EST PRET, ON DISTRIBUE  L'EVENEMENT
			dispatchEvent(new PlayerEvent(PlayerEvent.READY_TO_PLAY));
			//
			//
			if (autoPlay == "true") {
				photo_mc.visible = false;
				photo_mc.alpha = 0;
				grosPlay_btn.visible = false;
				grosPlay_btn.alpha = 0;
				PLAY_PAUSE_Handler();
			}
			//			
		}
		/////
		private function overGbpBtn(e:MouseEvent):void 
		{
			TweenMax.to(play_mc, 0.3, {tint:color_level_3 } );
		}
		/////
		private function outGbpBtn(e:MouseEvent):void 
		{
			TweenMax.to(play_mc, 0.3, {tint:color_level_1 } );
		}
		/////play_mc
		private function overSeekBtn(e:MouseEvent):void 
		{
			if (isMetaData == true) {
				if(isPlaying == true){
					TweenMax.to(pictoSeek, 0.3, {autoAlpha:1 } );
					seek.addEventListener(Event.ENTER_FRAME, pictoSeek_Handler);
				}
			}
			TweenMax.to(seek, 0.3, {tint:color_level_3 } );
		}
		/////
		private function outSeekBtn(e:MouseEvent = null):void 
		{
			if (isMetaData == true) {
				//if(isPlaying == true){
					TweenMax.to(pictoSeek, 0.1, {autoAlpha:0 } );
					seek.removeEventListener(Event.ENTER_FRAME, pictoSeek_Handler);
					compteurTemporisation = 0;
					replay_Handler();
				//}
			}
			TweenMax.to(seek, 0.2, {tint:color_level_1 } );
		}
		/////
		private function overBtn(e:MouseEvent):void 
		{
			TweenMax.to(e.target, 0.3, {tint:color_level_3 } );
		}
		/////
		private function outBtn(e:MouseEvent):void 
		{
			TweenMax.to(e.target, 0.3, {tint:null } );
		}
		/////fondAudio
		private function IO_ERROR_Handler(e:IOErrorEvent):void{ 
			trace("IO_Handler");  
		}
		/////
		private function ASYNC_ERROR_Handler(e:AsyncErrorEvent):void{ 
			trace("asyncError_Handler");  
		}
		/////
		private function NET_STATUS_Handler(e:NetStatusEvent):void {
			switch (e.info.code){ 
				case "NetStream.Play.StreamNotFound":
					break;
				case "NetStream.Play.Start":
					//trace("NetStream.Play.Start");
					break;
				case "NetStream.Play.Stop": 
					//trace("NetStream.Play.Stop");
					if(seeker == false){
						if (boucle == "false") {
							ns.seek(0);
							seek.alpha = 0;
							PLAY_PAUSE_Handler();
							outSeekBtn();
							//stopped = true;
							//
							TweenMax.to(photo_mc, 0.3, { autoAlpha:1 } );
							TweenMax.to(grosPlay_btn, 0.3, { autoAlpha:1 } );
							//
							TweenMax.to(navigation_mc, 1, { y:maskVideo.height - hauteurBarre, ease:Circ.easeOut } );
							//
							if (stage.displayState == StageDisplayState.FULL_SCREEN) {
								toggleFullScreen_Handler();
							}
							//on decleche la function onfinished qui renseigne le root de l arret de la video
							dispatchEvent(new PlayerEvent(PlayerEvent.STOP));
						}else {
							ns.seek(0);
						}
					}
					break;
			} 
		}
		/////
		private function METADATA_Handler(infoObject:Object):void { 
			//trace("metaData_Handler");
			if (isMetaData == false) {
				proprieteVideo = new Object();
				var key:String;
				for (key in infoObject) 
				{ 
					//PROPRIETE DISPONIBLE: moovposition, videocodecid, width, seekpoints, trackinfo, duration, avcprofile, avclevel, height, videoframerate
					proprieteVideo[key] = infoObject[key];
					//trace(infoObject[key]);
				} 
				v_video.width = infoObject.width;
				v_video.height = infoObject.height;
				//
				isMetaData = true;
				//
				resize();
				//
				addEventListener(Event.ENTER_FRAME, stream_Handler);
				ns.resume();
				//
				//TRIX: on affiche la barre de seek, sinon on voie un pixel qui depasse
				TweenMax.to(seek, 0.3, {delay:0.2, autoAlpha:1 } );
				TweenMax.to(stream, 0.3, {delay:0.2, autoAlpha:1 } );
			}
		}
		/////
		private function stream_Handler(evt:Event):void {
			//GESTION DE LA BARRE DE STREAM
			if(nsLaunch == true){
			//if(stopped == false){
				stream.width = Utils.rapport(ns.bytesLoaded, ns.bytesTotal, total.width, 0, 0);
				seek.width = Utils.rapport(ns.time, proprieteVideo.duration, total.width, 0, 0);
				seekClik.width = stream.width;
				//
				//textTiming_mc.text = Utils.secondesToMinutes(ns.time);
				textTiming_mc.text = Utils.secondesToMinutesInv(proprieteVideo.duration,ns.time);
			}else {
				stream.width = 0;
				seek.width = 0;
				seekClik.width = 0;
				textTiming_mc.text = Utils.secondesToMinutes(0);
			}
		}
		/////
		private function timerHandler(e:Event):void {
			if (isPlaying == true) {
				if (chekMousePos ++ == 5) {
					//if (hitTestPoint(x + mouseX, y + mouseY)) {
					//TRICKS propre a l include du player dans un autre swf
					if (hitTestPoint(x + mouseX, this.getBounds(MainWorkshopDesign.root).y + mouseY)) {
						if (mouseX == Xmouse && mouseY == Ymouse) {
							if (compteurTemporisation ++ == dureeTemporisation) {
								if(e.target.hitTestPoint(x + mouseX,y + mouseY)){
								}else {
									if(e.target.y <= maskVideo.height){
										TweenLite.killTweensOf(e.target, false);
										TweenLite.to(e.target, 0.7, { y:maskVideo.height + 1} );
										if (stage.displayState == StageDisplayState.FULL_SCREEN) {
											Mouse.hide();
										}
									}
								}
							}
						}else {
							compteurTemporisation = 0;
							Mouse.show();
							if (e.target.y > (maskVideo.height - hauteurBarre)) {
								TweenLite.killTweensOf(e.target, false);
								TweenLite.to(e.target, 1, { y:maskVideo.height - hauteurBarre, ease:Circ.easeOut } );
							}
						}
						//
					}else {
						if(e.target.y <= maskVideo.height){
							TweenLite.killTweensOf(e.target, false);
							TweenLite.to(e.target, 0.7, { y:maskVideo.height + 1} );
							if (stage.displayState == StageDisplayState.FULL_SCREEN) {
								Mouse.hide();
							}
						}
					}
					
					chekMousePos = 0;
					Xmouse = mouseX;
					Ymouse = mouseY;
					
				}
			}
		}
		/////
		private function seek_Handler(evt:MouseEvent):void {
			if (nsLaunch == true) {
				if (isPlaying == true) {
					seeker = true;
					ns.togglePause();
					playPausePlay_bmp.visible = !playPausePlay_bmp.visible;
					playPausePause_bmp.visible = !playPausePause_bmp.visible;
					//navigation_mc.removeEventListener(Event.ENTER_FRAME, timerHandler);
				}
				//
				//navigation_mc.removeEventListener(Event.ENTER_FRAME, timerHandler);
				//removeEventListener(Event.ENTER_FRAME, stream_Handler);
				//stage.addEventListener(MouseEvent.MOUSE_UP, replay_Handler);
				//fondPlayer_mc.addEventListener(MouseEvent.MOUSE_UP, replay_Handler);
				//stage.addEventListener(MouseEvent.MOUSE_OUT, replay_Handler);
				//fondPlayer_mc.addEventListener(MouseEvent.MOUSE_OUT, replay_Handler);
			}
		}
		/////
		//private function mouseLeave(e:Event):void 
		//{
			//trace("mouse leave");
			//replay_Handler();
		//}
		/////
		private function pictoSeek_Handler(e:Event):void { 
			var toReach:Number = Utils.rapport(stream.mouseX * stream.scaleX, total.width, proprieteVideo.duration, 0, 0);
			textSeek.text = Utils.secondesToMinutes(ns.time);
			//pictoSeek.x = total.x + (total.mouseX * total.scaleX);
			//
			if(seeker == true){
				seek.width = Math.min(stream.width,stream.mouseX * stream.scaleX);
				ns.seek(Math.min(toReach,proprieteVideo.duration - 1));
			}
			pictoSeek.x = seek.x + seek.width - 1;
		}
		/////
		private function replay_Handler(evt:MouseEvent = null):void {
			if (nsLaunch == true) {
				if (isPlaying == true && seeker == true) {
					var toReach:Number = Utils.rapport(stream.mouseX * stream.scaleX, total.width, proprieteVideo.duration, 0, 0);
					ns.seek(toReach);
					seeker = false;
					ns.togglePause();
					playPausePlay_bmp.visible = !playPausePlay_bmp.visible;
					playPausePause_bmp.visible = !playPausePause_bmp.visible;
					//navigation_mc.addEventListener(Event.ENTER_FRAME, timerHandler);
				}
				//compteurTemporisation = 0;
				//navigation_mc.addEventListener(Event.ENTER_FRAME, timerHandler);
				//addEventListener(Event.ENTER_FRAME, stream_Handler);
				//stage.removeEventListener(MouseEvent.MOUSE_UP, replay_Handler);
				//fondPlayer_mc.removeEventListener(MouseEvent.MOUSE_UP, replay_Handler);
				//stage.removeEventListener(MouseEvent.MOUSE_OUT, replay_Handler);
				//fondPlayer_mc.removeEventListener(MouseEvent.MOUSE_OUT, replay_Handler);
			}
			
		}
		/////
		private function overSoundBtn(e:MouseEvent):void 
		{
			TweenMax.to(couleurAudio, 0.3, {tint:color_level_3 } );
		}
		/////
		private function outSoundBtn(e:MouseEvent):void 
		{
			TweenMax.to(couleurAudio, 0.3, { tint:color_level_1 } );
		}
		/////
		private function volumeDownHandler(e:MouseEvent):void {
			fondAudio.addEventListener(Event.ENTER_FRAME, deplaceAudioCurseur);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpAudio);
		}
		/////
		private function volumeUpHandler(e:MouseEvent = null):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpAudio);
			fondAudio.removeEventListener(Event.ENTER_FRAME, deplaceAudioCurseur);
			//
			SO.setValue("soundOn", sound);
			SO.setValue("soundVolume", soundVolume);
		}
		/////
		private function deplaceAudioCurseur(e:Event):void {
			couleurAudio.width = fondAudio.mouseX;
			//
			video_sound.volume = Utils.rapport(fondAudio.mouseX, fondAudio.width, 1, 0, 0);
			ns.soundTransform = video_sound;
			//
			//var soundTemp:String = sound;
			//var soundVolumeTemp:Number = soundVolume;
			if (fondAudio.mouseX < 0.5) {
				couleurAudio.width = 0;
				video_sound.volume = 0;
				ns.soundTransform = video_sound;
				sound = "false";
				soundVolume = 0;
			}else {
				sound = "true";
				soundVolume = 1 / (couleurAudioWidth / couleurAudio.width)
			}
		}
		/////
		public function mouseUpAudio(e:MouseEvent):void {
			volumeUpHandler();
		}
		/////
		private function PLAY_PAUSE_Handler(event:MouseEvent = null):void {
			if (!conteneur_mc.contains(video_mc)) {
				//HACK : on attache le conteneur video_mc seulement apres le play, sinon l'effet RGB_SHIFT ne fonctionne pas --> security sandbox
				//trace("on attache le containeur video");
				conteneur_mc.addChild(video_mc);
				//on repasse la barre de nav devant
				conteneur_mc.addChild(photo_mc);
				conteneur_mc.addChild(navigation_mc);
				conteneur_mc.addChild(grosPlay_btn);
				
			}
			if (nsLaunch != true) {
				nsLaunch = true;
				ns.play(videoURL);
				ns.pause();
			}else {
				ns.togglePause();
				seek.alpha = 1;
			}
			compteurTemporisation = 0;
			isPlaying = !isPlaying;
			playPausePlay_bmp.visible = !playPausePlay_bmp.visible;
			playPausePause_bmp.visible = !playPausePause_bmp.visible;
			//
			if (photo_mc.visible == true && photo_mc.alpha == 1) {
				TweenMax.to(photo_mc, 0.3, { autoAlpha:0 } );
				TweenMax.to(grosPlay_btn, 0.3, { autoAlpha:0 } );
			}
		}
		/////
		private function toggleFullScreen_Handler(e:MouseEvent = null):void {
			switch(stage.displayState) {
				case StageDisplayState.NORMAL:
					isFullscreen = true;
					stage.displayState = StageDisplayState.FULL_SCREEN;
					fullscreenTrue_bmp.visible = false;
					//
					break;
				case StageDisplayState.FULL_SCREEN:
					isFullscreen = false;
					//FCT PROPRE AU SITE FACEB
					//Navigation._pageBase.noisePattern_mc.replayPattern();
					//
					stage.displayState = StageDisplayState.NORMAL;
					fullscreenTrue_bmp.visible = true;
					break;
			}
			fullscreenFalse_bmp.visible = !fullscreenTrue_bmp.visible;
			resize();
		}
		/////
		public function resize(e:Event = null):void {
			Mouse.show();
			if (stage && video_mc && photo_mc) {
				if (stage.displayState == StageDisplayState.FULL_SCREEN) {
					maskVideo = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
					conteneur_mc.scrollRect = maskVideo;
				}else {
					if(alwaysResize == "true"){
						maskVideo = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
						conteneur_mc.scrollRect = maskVideo;
					}else {
						maskVideo = new Rectangle(0, 0, videoWidth, videoHeight);
						conteneur_mc.scrollRect = maskVideo;
					}
					
				}
				fondPlayer_mc.width = maskVideo.width;
				fondPlayer_mc.height = maskVideo.height;
				video_mc.width = maskVideo.width;
				//
				video_mc.scaleY = video_mc.scaleX;
				photo_mc.width = maskVideo.width;
				photo_mc.scaleY = photo_mc.scaleX;
				//
				if(crop == "true"){
					if(video_mc.height < maskVideo.height){
						video_mc.height = maskVideo.height;
						video_mc.scaleX = video_mc.scaleY;
						video_mc.x = (maskVideo.width - video_mc.width)/2;
						video_mc.y = 0;
					}else{
						video_mc.x = 0;
						video_mc.y = (maskVideo.height - video_mc.height)/2;
					}
					if(photo_mc.height < maskVideo.height){
						photo_mc.height = maskVideo.height;
						photo_mc.scaleX = photo_mc.scaleY;
						photo_mc.x = (maskVideo.width - photo_mc.width)/2;
						photo_mc.y = 0;
					}else{
						photo_mc.x = 0;
						photo_mc.y = (maskVideo.height - photo_mc.height)/2;
					}
				}else {
					if(video_mc.height > maskVideo.height){
						video_mc.height = maskVideo.height;
						video_mc.scaleX = video_mc.scaleY;
						video_mc.x = (maskVideo.width - video_mc.width)/2;
						video_mc.y = 0;
					}else{
						video_mc.x = 0;
						video_mc.y = (maskVideo.height - video_mc.height)/2;
					}
					//
					if(photo_mc.height > maskVideo.height){
						photo_mc.height = maskVideo.height;
						photo_mc.scaleX = photo_mc.scaleY;
						photo_mc.x = (maskVideo.width - photo_mc.width)/2;
						photo_mc.y = 0;
					}else{
						photo_mc.x = 0;
						photo_mc.y = (maskVideo.height - photo_mc.height)/2;
					}
				}
				if (grosPlay_btn != null) {
					grosPlay_btn.x = maskVideo.width / 2;
					//grosPlay_btn.x = videoWidth / 2;
					grosPlay_btn.y = maskVideo.height / 2;
					//grosPlay_btn.y = videoHeight / 2;
				}
				if (navigation_mc != null) {
					TweenMax.killTweensOf(navigation_mc, false);
					compteurTemporisation = 0;
					//
					navigation_mc.y = maskVideo.height - hauteurBarre;
					fondNavigation_mc.width = maskVideo.width;
					//
					fullscreen_btn.x = maskVideo.width - (fullscreen_btn.width + margePicto);
					sound_btn.x = fullscreen_btn.x - sound_btn.width;
					//
					total.y = (hauteurBarre - total.height) / 2;
					pictoSeek.y = stream.y = seek.y = total.y;
					total.width = maskVideo.width - (total.x + sound_btn.width + fullscreen_btn.width + margePicto*2);
				}
				/////
			
				switch(stage.displayState) {
					case StageDisplayState.NORMAL:
						isFullscreen = false;
						fullscreenTrue_bmp.visible = true;
						break;
					case StageDisplayState.FULL_SCREEN:
						isFullscreen = true;
						fullscreenTrue_bmp.visible = false;
						break;
				}
				fullscreenFalse_bmp.visible = !fullscreenTrue_bmp.visible;
			}
			
		}
		/**
		 * Permet de piloter l apparaition du player depuis l exterieur
		 * @param
		 */
		public function apparition(time:Number = 1,_delay:Number = 0,value:Number = 1):void
		{
			TweenMax.to(this, time, {delay:_delay,autoAlpha:value } );
		}
		/**
		 * invoqué une fois le clip playerVideo detruit de son parent
		 * @param	e
		 */
		private function REMOVED_FROM_STAGE_Handler(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, REMOVED_FROM_STAGE_Handler);			
			TweenMax.killTweensOf(navigation_mc, true);
			navigation_mc.removeEventListener(Event.ENTER_FRAME, timerHandler);
			removeEventListener(Event.ENTER_FRAME, stream_Handler);
			seek.removeEventListener(Event.ENTER_FRAME, pictoSeek_Handler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpAudio);
			fondAudio.removeEventListener(Event.ENTER_FRAME, deplaceAudioCurseur);
			//stage.removeEventListener(MouseEvent.MOUSE_UP, replay_Handler);
			//stage.removeEventListener(MouseEvent.MOUSE_OUT, replay_Handler);
			nc.connect(null);
			ns.removeEventListener(IOErrorEvent.IO_ERROR, IO_ERROR_Handler);
			ns.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, ASYNC_ERROR_Handler); 
			ns.removeEventListener(NetStatusEvent.NET_STATUS, NET_STATUS_Handler);
			ns.close();
			ns = null;
			Mouse.show();
		}
	}
}
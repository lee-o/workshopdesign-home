package cc.shic.display.video 
{
	
	import cc.shic.events.CustomEvent;
	import cc.shic.Utils;
	import flash.display.Sprite;
    import flash.events.*;
    import flash.media.Video;
    import flash.net.NetConnection;
    import flash.net.NetStream;

	
	
	/**
	 * ...
	 * @author david@shic.fr
	 */
	public class EasyVideo extends Sprite
	{
		public var videoURL:String;
        private var connection:NetConnection;
        public var stream:NetStream;
		public var client:VideoClient;
		private var video:Video;
		private var _smooting:Boolean = true;
		private var _time:Number;
		
		public function EasyVideo(videoURL:String) 
		{
			this.videoURL = videoURL;
			
			connection = new NetConnection();
            connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            connection.connect(null);
		}
		
		private function netStatusHandler(event:NetStatusEvent):void {
			//trace(event.info.code);
			switch (event.info.code) {
                case "NetConnection.Connect.Success":
                    connectStream();
                    break;
                case "NetStream.Play.StreamNotFound":
                    trace("Unable to locate video: " + videoURL);
                    break;
				case "NetStream.Play.Stop":
					if (client.duration-1 <= stream.time) {
						trace("end video");
						dispatchEvent(new CustomEvent(CustomEvent.ON_PLAY_COMPLETE));
					}
            }
        }

        private function connectStream():void {
            stream = new NetStream(connection);
			stream.client = new VideoClient();
			stream.bufferTime = 5;
			client = stream.client as VideoClient;
			client.addEventListener(CustomEvent.ON_META_DATA, onMetaData);
            stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
            video = new Video();
			video.smoothing = smooting;
            video.attachNetStream(stream);
            stream.play(videoURL);
            addChild(video);
			//video.de
			addEventListener(Event.ENTER_FRAME, loop);
			
			
			
        }
		public function stop():void {
			stream.pause();
		}
		public function destroy():void {
			stream.close();
			client.removeEventListener(CustomEvent.ON_META_DATA, onMetaData);
            stream.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            stream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			removeEventListener(Event.ENTER_FRAME, loop);
			
			stream = null;
			client = null;
			removeChild(video);
			video = null;
			connection.close();
			connection = null;
		}
		
		private function loop(e:Event):void 
		{
			//trace(stream.time + "/" + client.duration);
			/*
			if (Utils.rapport(stream.bytesLoaded, stream.bytesTotal, 100, 0, 0) > 10) {
				stream.resume();
				removeEventListener(Event.ENTER_FRAME, loop);
			}
			*/
		}
		/**
		 * evènement renvoyé quand la vidéo arrive au bout de la lecture
		 */
		[Event(name="onPlayComplete", type="cc.shic.events.CustomEvent")]
		/**
		 * evènement renvoyé quand on connait la durée et la taille de la vidéo
		 */
		[Event(name="onMetaData", type="cc.shic.events.CustomEvent")]
		
		private function onMetaData(e:CustomEvent):void 
		{
			video.width = client.width;
			video.height = client.height;
			dispatchEvent(new CustomEvent(CustomEvent.ON_META_DATA));
		}

        private function securityErrorHandler(event:SecurityErrorEvent):void {
            trace("securityErrorHandler: " + event);
        }
        
        private function asyncErrorHandler(event:AsyncErrorEvent):void {
            // ignore AsyncErrorEvent events.
        }
		
		public function get smooting():Boolean { return _smooting; }
		
		public function set smooting(value:Boolean):void 
		{
			_smooting = value;
			video.smoothing = _smooting;
		}
		
		public function get time():Number { return stream.time; }
		
	}

}


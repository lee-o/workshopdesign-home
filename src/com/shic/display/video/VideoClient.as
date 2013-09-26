package cc.shic.display.video 
{
	import cc.shic.events.CustomEvent;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author david@shic.fr
	 */
	public class VideoClient extends EventDispatcher
	{
		public var width:Number;
		public var height:Number;
		public var duration:Number;
		public var framerate:Number;
		
		public function VideoClient() 
		{


		}
		
		[Event(name="onMetaData", type="cc.shic.events.CustomEvent")]
		
		public function onMetaData(info:Object):void {
			trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
			width = info.width;
			height = info.height;
			framerate = info.framerate;
			duration = info.duration;
			dispatchEvent(new CustomEvent(CustomEvent.ON_META_DATA));
		}
		
		public function onXMPData(info:Object):void {
			trace("on xmpdata");
		}
		
		public function onCuePoint(info:Object):void {
			trace("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
		}
		
	}

}
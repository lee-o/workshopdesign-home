package com.thinkadelik.sharedObject
{
	
	import flash.events.NetStatusEvent;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;

	public class MySharedObject
	{

		private var mySo:SharedObject;

		public function MySharedObject() {

			//mySo = SharedObject.getLocal("flashCookie","/",false);
			//mySo = getSo();
			//trace("SharedObject loaded...");
			//trace("loaded value: " + mySo.data.savedValue );
		}
		
		private function getSo():SharedObject {
			return SharedObject.getLocal("flashCookie", "/", false);
		}
		
		public function readValue():* {
			return mySo.data.savedValue;
		}

		public function saveValue(value:*):void {
			//trace("saving value... " + value);
			mySo.data.savedValue = value;

			var flushStatus:String = null;
			try {
				flushStatus = mySo.flush(10000);
			} catch (error:Error) {
				//trace("Error...Could not write SharedObject to disk");
			}
			if (flushStatus != null) {
				switch (flushStatus) {
					case SharedObjectFlushStatus.PENDING:
					//trace("Requesting permission to save object...");
					mySo.addEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
					break;
					case SharedObjectFlushStatus.FLUSHED:
					//trace("Value flushed to disk.");
					break;
				}
			}
		}
		
		public function setValue(variableName:String, variableValue:*):void {
			
			mySo = getSo();
			mySo.data[variableName] = variableValue;
			mySo.flush();
			mySo = null;
		}
		public function getValue(variableName:String):* {
			mySo = getSo();
			var retour:* = mySo.data[variableName];
			mySo = null;
			return retour;
		}

		private function clearValue():void {
			mySo = getSo();
			//for (i in mySo.data) {
				//delete mySo.data[i];
			//}
		}

		private function onFlushStatus(event:NetStatusEvent):void {
			switch (event.info.code) {
				case "SharedObject.Flush.Success":
				//trace("User granted permission -- value saved.");
				break;
				case "SharedObject.Flush.Failed":
				//trace("User denied permission -- value not saved.");
				break;
			}
			mySo.removeEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
		}
	}
}
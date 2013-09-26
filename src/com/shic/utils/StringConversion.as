package com.shic.utils 
{
	/**
	 * ...
	 * @author shic
	 */
	public class StringConversion
	{
		/**
		 * 125.888 -> 02:05
		 * @param	seconds --> exemple : 125.888
		 * @return	secondes formatées --> exemple : 02:05
		 */
		public static function secToTimeSec(seconds:Number):String {
			
			var date:Date = new Date(0, 0, 0, 0, 0, 0, 0);
			date.setMilliseconds(seconds * 1000);
			var s:String;
			var m:String;
			if (date.getMinutes()<10) {
				m = "0" + date.getMinutes();
			}else {
				m = String(date.getMinutes());
			}
			if (date.getSeconds()<10) {
				s = "0" + date.getSeconds();
			}else {
				s = String(date.getSeconds());
			}
			if (s=="NaN" || m=="NaN") {
				s = "00";
				m = "00";
			}
			return m + ":" + s;
			
		}
		
	}

}
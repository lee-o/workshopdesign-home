package site.ui 
{
	import com.shic.displayObjects.Square;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ...
	 */
	public class simpleBtn extends Sprite
	{
		public var url:String;
		public var id:uint;
		public var type:String;
		private var _width:int;
		private var _height:int;
		private var forme:Square;
		//
		public function simpleBtn(w:int = 20, h:int = 20, _url:String = null, _id:uint = 0, _type:String = null) 
		{
			url = _url;
			id = _id;
			type = _type;
			_width = w;
			_height = h;
			//
			init();
		}
		//
		private function init():void 
		{
			forme = new Square(_width, _height);
			addChild(forme);
			buttonMode = true;
			mouseChildren = false;
		}
		
	}

}
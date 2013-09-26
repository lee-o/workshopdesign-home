package site.navigation 
{
	import com.greensock.TweenMax;
	import com.shic.displayObjects.TextFieldMonoLine;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.TextFormat;
	import site.ui.simpleBtn;
	/**
	 * ...
	 * @author lee-o
	 */
	public class Menu extends Sprite
	{
		private var xml:XML;
		private var menus:XMLList;
		private var nbreMenus:uint;
		private var sizeTypo:uint = 24;
		private var menuEnCour:uint;
		//
		public function Menu(_xml:XML) 
		{
			menus = _xml.navigation;
			nbreMenus = menus.children().length();
			//trace(menus.child(0));
			//
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE,init)
			}
		}
		
		private function init(e:Event = null):void 
		{
			var shadow:DropShadowFilter = new DropShadowFilter(1, 45, 0x000000, 1, 2, 2, 1, 2);
			this.filters = [shadow];
			
			for (var u:uint = 0; u < nbreMenus; u++)
			{
				var lien:Sprite = new Sprite();
				lien.name = menus.child(u).attribute("type");
				var btn:simpleBtn = new simpleBtn(5,5,null, u, menus.child(u).attribute("type"));
				//
				var txt:TextFieldMonoLine = new TextFieldMonoLine(menus.child(u).attribute("type"));
				DataLoader.xmlStyleLoader.appliqueFormat(txt, "Helvetica-Neue-Lt-Std-Thin");
				var sizeTextFormat:TextFormat = new TextFormat();
				sizeTextFormat.size = sizeTypo;
				txt.setTextFormat(sizeTextFormat);
				txt.textColor = DataLoader.couleurTexteNoir;
				//
				btn.alpha = 0;
				btn.width = txt.width;
				btn.height = txt.height - (txt.height * 0.35);
				btn.y = txt.y + btn.height * 0.3;
				btn.x = txt.x;
				//
				lien.y =  u * (sizeTypo * 1.10);
				//
				lien.addChild(txt);
				lien.addChild(btn);
				addChild(lien);
				//
				btn.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
				btn.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
				btn.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			}
		}
		
		
		private function mouseOverHandler(e:MouseEvent = null):void 
		{
			if(menuEnCour != e.target.id){
				TweenMax.to(e.target.parent, DataLoader.tempsApparition / 4, { tint:DataLoader.couleurTexteBlanc} );
			}
		}
		
		private function mouseOutHandler(e:MouseEvent = null):void 
		{
			if(menuEnCour != e.target.id){
				TweenMax.to(e.target.parent, DataLoader.tempsApparition, { tint:null } );
			}
		}
		
		private function mouseUpHandler(e:MouseEvent = null):void 
		{
			menuEnCour = e.target.id;
			for (var t:uint = 0; t < nbreMenus; t++)
			{
				if (t != e.target.id)
				{
					var temp:Sprite = this.getChildAt(t) as Sprite;
					temp.mouseEnabled = true;
					TweenMax.to(temp, DataLoader.tempsApparition, { tint:null } );
				}
			}
			e.target.parent.mouseEnabled = false;
			TweenMax.to(e.target.parent,0, { tint:DataLoader.couleurTexteBlanc } );
			Navigation.openPage(menus,e.target.type);
		}
		
		public function get select():String 
		{
			return this.getChildAt(menuEnCour).name;
		};
		
		public function set select(_type:String):void
		{
			var cible:Sprite = this.getChildByName(_type) as Sprite;
			cible.mouseEnabled = false;
			TweenMax.to(cible,DataLoader.tempsApparition / 4, { tint:DataLoader.couleurTexteBlanc } );
		}
		
		public function openHome(_type:String):void
		{
			select = _type;
			Navigation.openPage(menus,_type);
		}
	}

}
package site.pages 
{
	import com.greensock.easing.Quad;
	import com.greensock.OverwriteManager;
	import com.greensock.TweenMax;
	import com.shic.displayObjects.Square;
	import com.shic.displayObjects.TextFieldMonoLine;
	import com.shic.utils.Utils;
	import com.thinkadelik.stat.Ga;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import site.navigation.DataLoader;
	import site.ui.simpleBtn;
	/**
	 * ...
	 * @author ...
	 */
	public class LinkMenu extends Sprite
	{
		[Event(name = "complete", type = "flash.events.Event")]
		
		private var xml:XML;
		private var lienXML:XMLList;
		private var nombreLiens:uint;
		private var content:Sprite = new Sprite();
		private var LienVector:Vector.<MovieClip> = new Vector.<MovieClip>();
		private var maxTypoSize:TextFormat;
		private var maxWidth:uint;
		private var tailleMaxTypo:uint = 100;
		private var ratioResizeTypo:Number = 0.5;
		
		public function LinkMenu(_xml:XML) 
		{
			xml = _xml;
			init();
		}
		
		private function init():void 
		{
			OverwriteManager.init(OverwriteManager.ALL_IMMEDIATE);
			//
			lienXML = xml.liens;
			nombreLiens = lienXML.lien.length();
			//
			addChild(content);
			var shadow:DropShadowFilter = new DropShadowFilter(1, 45, 0x000000, 1, 2, 2, 1, 2);
			content.filters = [shadow];
			//
			var txtHeight:uint = 0;
			for (var i:uint = 0; i < nombreLiens; i++) {
				var lien:MovieClip = new MovieClip();
				lien.name = lienXML.lien[i].name;
				var btn:simpleBtn = new simpleBtn(5,5,"http://" + lienXML.lien[i].link, i);
				var txtBmp:Bitmap;
				var txtBmpd:BitmapData;
				//
				var txt:TextFieldMonoLine = new TextFieldMonoLine(lienXML.lien[i].name);
				i % 2 == 0 ? DataLoader.xmlStyleLoader.appliqueFormat(txt, "Helvetica-Neue-Lt-Std-Bold") : DataLoader.xmlStyleLoader.appliqueFormat(txt, "Helvetica-Neue-Lt-Std-Roman");
				maxTypoSize = new TextFormat(); 
				maxTypoSize.size = tailleMaxTypo;
				txt.setTextFormat(maxTypoSize);
				txt.textColor = DataLoader.couleurTexteBlanc;
				//
				txtHeight = txt.height;
				maxWidth < txt.width ? maxWidth = txt.width : null;
				//
				txtBmpd = new BitmapData(txt.width, txtHeight, true, 0x006699);
				txtBmpd.draw(txt);
				txtBmp = new Bitmap(txtBmpd, "auto", true);
				txtBmp.y -= txtHeight * 0.25;
				txtBmp.x -= Math.floor(txtBmp.width);
				txtBmp.smoothing = true;
				//
				txt = null;
				//
				btn.alpha = 0;
				btn.width = txtBmp.width;
				btn.height = txtHeight - (txtHeight * 0.35);
				btn.y = txtBmp.y + btn.height * 0.3;
				btn.x = txtBmp.x;
				//
				i != 0 ? lien.y =  LienVector[(LienVector.length - 1)].getBounds(content).bottom: lien.y = 0;
				lien.posY = lien.y;
				lien.txtHeightMax = txtHeight;
				lien.scaleX = lien.scaleY = ratioResizeTypo;
				lien.txtHeightMin = lien.height;
				//
				lien.addChild(btn);
				lien.addChild(txtBmp);
				content.addChild(lien);
				//
				LienVector.push(lien);
				//
				btn.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
				btn.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
				btn.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			}
			//resize();
		}
		
		private function mouseOverHandler(e:MouseEvent):void 
		{
			var depart:uint = LienVector.indexOf(e.target.parent);
			var total:uint = LienVector.length;
			for (var i:uint = depart + 1; i < total; i++)
			{
				var cible:MovieClip = LienVector[i];
				TweenMax.killTweensOf(cible);
				TweenMax.to(cible, 0.2, {ease:Quad.easeInOut,y:cible.posY + int(maxTypoSize.size) / 3,scaleX:ratioResizeTypo,scaleY:ratioResizeTypo} );
			}
			content.addChild(e.target.parent);
			TweenMax.to(e.target.parent, 0.2, { ease:Quad.easeInOut, y:e.target.parent.posY, scaleX:1, scaleY:1 } );
			//
			if ((stage.stageWidth - maxWidth)-DataLoader.margeGlobale*3 < MainWorkshopDesign.page.x + MainWorkshopDesign.page.fond.width) {
				TweenMax.to(MainWorkshopDesign.page, 0.2, { ease:Quad.easeInOut, alpha:0 } );
			}
		}
		
		private function mouseOutHandler(e:MouseEvent):void 
		{
			var total:uint = LienVector.length;
			for (var i:uint = 0; i < total; i++)
			{
				var cible:MovieClip = LienVector[i];
				TweenMax.to(cible, 0.2, {ease:Quad.easeInOut,y:cible.posY,scaleX:ratioResizeTypo,scaleY:ratioResizeTypo } );
			}
			//
			if ((stage.stageWidth - maxWidth)-DataLoader.margeGlobale*3 < MainWorkshopDesign.page.x + MainWorkshopDesign.page.width) {
				TweenMax.to(MainWorkshopDesign.page, 0.6, {delay:0.3,ease:Quad.easeInOut,alpha:1 } );
			}
		}
		
		private function mouseUpHandler(e:MouseEvent):void 
		{
			MainWorkshopDesign.MainPause();
			Utils.openExternalPage(e.target.url);
			/*var obj:Object = new Object();
			obj.type = "links";
			obj.name = e.target.parent.name;
			Ga.track("Event", obj);*/
			Ga.Event("links", e.target.parent.name);
		}
		
		private function resize():void 
		{
			//trace(content.width);
			//for (var i:uint = 0; i < nombreLiens; i++) {
				//trace(content.getChildAt(i));
				//content.getChildAt(i).x = uint(content.width - content.getChildAt(i).width);
			//}
		}
	}
}
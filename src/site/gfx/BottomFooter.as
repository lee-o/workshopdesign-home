package site.gfx 
{
	import com.greensock.TweenMax;
	import com.shic.displayObjects.Square2;
	import com.shic.displayObjects.TextFieldMonoLine;
	import site.navigation.DataLoader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author lee-o
	 */
	public class BottomFooter extends Sprite
	{
		private var largeurGlobale:int = DataLoader.largeurGlobale;
		private var txtBottom:Sprite;
		private var bottomMargin:Square2;
		private var bottomFooter:Square2;
		private var trait:Shape;
		
		public function BottomFooter() 
		{
			alpha = 0;
			visible = false;
			//
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			bottomFooter = new Square2(stage.stageWidth, 27, 0x000000, 1);
			//bottomFooter.alpha = 0;
			addChild(bottomFooter);
			//
			txtBottom = new Sprite();
			//txtBottom.visible = false;
			//txtBottom.alpha = 0;
			addChild(txtBottom);
			//
			var titre_txt:TextFieldMonoLine
			if (DataLoader.xmlFacebLoader.xml.footer.mail != "") {
				titre_txt = new TextFieldMonoLine(DataLoader.xmlFacebLoader.xml.footer.name + " | <a href='mailto:" + DataLoader.xmlFacebLoader.xml.footer.mail + "' target='_blank'>" + DataLoader.xmlFacebLoader.xml.footer.mail + "</a>", true);
			}else{
				titre_txt = new TextFieldMonoLine(DataLoader.xmlFacebLoader.xml.footer.name, true);
			}
			titre_txt.name = "titre_txt";
			DataLoader.xmlStyleLoader.appliqueFormat(titre_txt, "AvantGarde-bk-12");
			titre_txt.textColor = DataLoader.couleurTexteBlanc;
			titre_txt.selectable = true;
			titre_txt.mouseWheelEnabled = false;
			titre_txt.x = 6;
			titre_txt.y = 4;
			txtBottom.addChild(titre_txt);
			//
			var credit_txt:TextFieldMonoLine = new TextFieldMonoLine("<a href='http://" + DataLoader.xmlFacebLoader.xml.footer.credit + "' target='_blank'>" + DataLoader.xmlFacebLoader.xml.footer.credit + "</a>", true);
			credit_txt.name = "credit_txt";
			DataLoader.xmlStyleLoader.appliqueFormat(credit_txt, "AvantGarde-bk-12");
			credit_txt.textColor = DataLoader.couleurTexteBlanc;
			credit_txt.x = largeurGlobale - (credit_txt.width + 6);
			credit_txt.y = 4;
			txtBottom.addChild(credit_txt);
			//
			resize();
		}
		
		public function resize():void
		{
			if(bottomFooter){
				//bottomFooter.x = (stage.stageWidth - largeurGlobale)/2;
				bottomFooter.width = stage.stageWidth;
				txtBottom.x = stage.stageWidth / 2 - largeurGlobale / 2;
				//
				//trait.y = int(fluxRss_mc.reelHeight + margeGlobale);
				//bottomFooter.y = int(fluxRss_mc.reelHeight + margeGlobale);
				//txtBottom.y = bottomFooter.y + 4;
				//
				/*if (MainFaceB.conteneurGlobal.height < MainFaceB.maskGlobal.height ) {
					bottomFooter.y = int((MainFaceB.maskGlobal.height - y) - (bottomFooter.height+1));
					txtBottom.y = bottomFooter.y + 4;
				}else{
					bottomFooter.y = int(fluxRss_mc.reelHeight + margeGlobale);
					txtBottom.y = bottomFooter.y + 4;
				}*/
			}
		}
		
		public function apparition():void 
		{
			TweenMax.to(this, DataLoader.tempsApparition, {autoAlpha:1 } );
			//TweenMax.to(bottomFooter, DataLoader.tempsApparition, { delay:2, autoAlpha:1 } );
			//TweenMax.to(txtBottom, DataLoader.tempsApparition, {delay:2,autoAlpha:1 } );
		}
	}

}
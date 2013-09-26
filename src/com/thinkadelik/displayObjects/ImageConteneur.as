package com.thinkadelik.displayObjects 
{
	import com.shic.utils.EasyLoader;
	import com.shic.utils.EasyLoaderEvent;
	import com.shic.utils.Utils;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author lee-o
	 */
	public class ImageConteneur extends Sprite
	{
		private var photo_mc:EasyLoader;
		private var link:String;
		private var largeur:int;
		private var hauteur:int;
		private var trueSize:Boolean;
		private var maskPhoto:Rectangle;
		private var cadre:Shape;
		private var isCadre:Boolean;
		private var largeurCadre:int;
		private var couleurCadre:Number;
		
		public function ImageConteneur(_link:String,_largeur:int = 100,_hauteur:int = 100, _trueSize:Boolean = false,_isCadre:Boolean = false,_largeurCadre:int = 0,_couleurCadre:Number = 0) 
		{
			link = _link;
			largeur = _largeur;
			hauteur = _hauteur;
			trueSize = _trueSize;
			isCadre = _isCadre;
			largeurCadre = _largeurCadre;
			couleurCadre = _couleurCadre;
			//
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE,init)
			}
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			photo_mc = new EasyLoader(link, true);
			addChild(photo_mc);
			photo_mc.addEventListener(Event.COMPLETE, imageLoaded);
		}
		
		private function imageLoaded(e:Event):void 
		{
			photo_mc.removeEventListener(Event.COMPLETE, imageLoaded);
			if (trueSize) {
				largeur = photo_mc.width;
				hauteur = photo_mc.height;
			}
			resize();
			Utils.smoothRecursive(photo_mc);
			if (isCadre) makeBorder();
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function makeBorder():void
		{
			cadre = new Shape();
			cadre.graphics.beginFill(couleurCadre, 0);
            cadre.graphics.lineStyle(largeurCadre, couleurCadre);
            cadre.graphics.drawRect(0, 0, largeur, hauteur);
            cadre.graphics.endFill();
            addChild(cadre);

		}
		
		private function resize():void
		{
			if (stage && this.contains(photo_mc))
			{
				maskPhoto = new Rectangle(0, 0, largeur, hauteur);
				scrollRect = maskPhoto;
				//
				if(photo_mc.height < maskPhoto.height){
					photo_mc.height = maskPhoto.height;
					photo_mc.scaleX = photo_mc.scaleY;
					photo_mc.x = (maskPhoto.width - photo_mc.width)/2;
					photo_mc.y = 0;
				}else{
					photo_mc.x = 0;
					photo_mc.y = (maskPhoto.height - photo_mc.height) / 2;
					if (photo_mc.width < maskPhoto.width) {
						photo_mc.width = maskPhoto.width;
						photo_mc.scaleY = photo_mc.scaleX;
						photo_mc.y = (maskPhoto.height - photo_mc.height)/2;
					}
				}
			}
		}
		
	}

}
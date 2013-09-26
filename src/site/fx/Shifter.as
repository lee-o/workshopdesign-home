package site.fx 
{
	import flash.display.Sprite;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	/**
	 * ...
	 * @author lee-o
	 */
	public class Shifter
	{
		public var RGB_fx:RGBShift;
		private var defaultRecurence:int = 94;
		private var defaultCible:Sprite = this as Sprite;
		private var defaultConteneur:Sprite = this as Sprite;
		private var cible:Sprite;
		private var conteneur:Sprite;
		public var recurence:int = defaultRecurence;
		
		
		public function Shifter(pCible:Sprite = null,pConteneur:Sprite = null) 
		{
			if (pCible == null) {
				cible = defaultCible;
			}else {
				cible = pCible;
			}
			if (pConteneur == null) {
				conteneur = defaultConteneur;
			}else {
				conteneur = pConteneur;
			}
		}
		
		public function playShift(e:Event = null):void
		{
			var randNum:uint = Math.random() * 100;
			if(randNum > recurence){
				stopShift();
				try {
					RGB_fx = new RGBShift(cible, 4);
					RGB_fx.mouseChildren = false;
					RGB_fx.mouseEnabled = false;
					RGB_fx.addEventListener(Event.COMPLETE, stopShift);
					conteneur.addChild(RGB_fx);
				}catch(error:IOErrorEvent) {
				}catch(error:TypeError) {
				}catch (error:Error) {
					//trace(error.message);	
				}
			}
		}
		
		private function stopShift(e:Event = null):void 
		{
			if (RGB_fx != null) {
				RGB_fx.removeEventListener(Event.COMPLETE, stopShift);
				conteneur.removeChild(RGB_fx);
				RGB_fx = null;
			}
		}
		
		public function set _cible(cible:Sprite):void {
			this.cible = cible;
		}
		
		public function set _conteneur(conteneur:Sprite):void {
			this.conteneur = conteneur;
		}
		
		public function set _recurence(recurence:int):void {
			this.recurence = recurence;
		}
		
		public function clearParam():void {
			this.cible = defaultCible;
			this.recurence = defaultRecurence;
		}
		
	}

}
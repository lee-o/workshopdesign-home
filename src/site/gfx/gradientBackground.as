package site.gfx 
{
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.*
	import flash.display.Shape;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author lee-o
	 */
	public class gradientBackground extends Sprite
	{
		private var gradient:Shape = new Shape();
		private var matrix:Matrix = new Matrix();
		private var hauteur:Number;
		private var largeur:Number;
	
		public function gradientBackground(_largeur:Number = 100,_hauteur:Number = 100) 
		{
			hauteur = _hauteur;
			largeur = _largeur;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			createGradient();
		}
		
		private function createGradient():void
		{
			this.alpha = 0;
				
			matrix.createGradientBox(largeur, hauteur, 0, 0, 0);
		
			gradient.graphics.beginGradientFill("radial", [0xFFFFFF, 0x000000], [0, 1], [100, 255], matrix, "pad", "RGB", 0);
				
			gradient.graphics.moveTo(0, 0);
			gradient.graphics.lineTo(largeur, 0);
			gradient.graphics.lineTo(largeur, hauteur);
			gradient.graphics.lineTo(0, hauteur);
			gradient.graphics.lineTo(0, 0);
			gradient.graphics.endFill();
				
			addChild(gradient);
			
			
		}
		
		public function apparition(time:Number = 1,_delay:Number = 0, value:Number = 1):void
		{
			TweenMax.to(this, time, {delay:_delay, autoAlpha:value } );
		}
		
		public function onStageResize(e:Event):void{
			createGradient();
		}
		
	}

}
package com.shic.swingImage.filters 
{
	import com.shic.swingImage.SwingImage;
	import com.shic.swingImage.SwingImageControler;
	import com.shic.swingImage.SwingImageControlerParam;
	import flash.display.DisplayObject;
	import flash.display.Shader;
	import flash.display.ShaderData;
	import flash.display.ShaderPrecision;
	import flash.filters.ShaderFilter;
	import flash.display.ShaderInput;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.display.Sprite;

	
	/**
	 * ...
	 * @author david m
	 */
	
	 public class DistortHorizontal extends ShaderFilter
	{
		
		private var mon_shader:Shader;
		
		/**
		 * 
		 * @param	width
		 * @param	height
		 * @param	waveSize
		 * @param	positionFactor	valeur qui influe sur le déplacement des turbulences, il est conseillé de faire évouluer ce parametre par valuers tres faibles pour avoir un réel effet (0.1 par exemple)
		 */
		public function DistortHorizontal(width:Number,height:Number,waveSize:Number=20,positionFactor:Number=0) 
		{
			//trace("DistortHorizontal "+width+"/"+height);
			
			[Embed(source="shaders/DeformationY.pbj", mimeType="application/octet-stream")] 
			var pbData:Class;
			
			
			mon_shader = new Shader();
			mon_shader.byteCode = new pbData();
			mon_shader.data.width.value  = [width];
			mon_shader.data.height.value  = [height];
			mon_shader.data.waveSize.value  = [waveSize];
			mon_shader.data.positionFactor.value  = [positionFactor];
			
			mon_shader.precisionHint = ShaderPrecision.FAST;
			
			super(mon_shader);
			
		}
		/**
		 * retourne un swingImageControleur qui permetra à l'utilisateur de modifier le filtre appliqué sur targetObject
		 * @param	targetObject	displayObject sur lequel est appliqué le filtre
		 * @return 	une interface utilisateur permettant de modifier le filtre
		 */
		public function getControler(targetObject:DisplayObject):SwingImageControler {
			//construit le controler
			var controler:SwingImageControler = new SwingImageControler(this,targetObject,
			[
			new SwingImageControlerParam("Slider", "centerX", _centerX, { minValue:0, maxValue:2048 } ),
			new SwingImageControlerParam("Slider", "centerY", _centerY, { minValue:0, maxValue:2048 } ),
			new SwingImageControlerParam("Slider", "innerRadius", _innerRadius, { minValue:0, maxValue:2048 } ),
			new SwingImageControlerParam("Slider", "outerRadius", _outerRadius, { minValue:0, maxValue:2048 } ),
			new SwingImageControlerParam("Slider", "magnification", _magnification, { minValue:0, maxValue:50 } )
			]
			)
			return controler;
		}
		/**
		* Methode permettant de cloner le filtre
		* @return
		*/
		/*
		public function clone2():Magnify 
		{ 
			trace("clone2 pas défini sur distort horizontal (ligne 62)");
			//return new Magnify(_centerX,_centerY,_innerRadius,_outerRadius,_magnification);
		} 
		*/
		

		
	}

}
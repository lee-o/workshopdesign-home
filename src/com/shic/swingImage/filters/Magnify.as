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
	
	 public class Magnify extends ShaderFilter
	{
		
		private var _graphicRepresentation:Shape;
		private var _centerX:Number;
		private var _centerY:Number;
		private var _innerRadius:Number;
		private var _outerRadius:Number;
		private var _magnification:Number;
		public var mon_shader:Shader;
		private var shaderDatas:*;
		
		
		/**
		 * Le filtre Magnify crée un effet de sphère dont on peut paramétrer des controles de déformation avancés
		 * @param	centerX point X central de la sphère
		 * @param	centerY point y central de la sphère
		 * @param	innerRadius	diamètre permettant de définir une aténuation de la shpère sur son sommet. Généralement ce paramètre est nul et doit être inférieur à outerRadius pour produire un effet optimal.
		 * @param	outerRadius diamètre de la sphère,
		 * @param	magnification élavation de la sphère (0,50)
		 */
		public function Magnify(centerX:Number,centerY:Number,innerRadius:Number=0,outerRadius:Number=100,magnification:Number=10) 
		{
			
			[Embed(source="shaders/magnify.pbj", mimeType="application/octet-stream")] 
			var MagnifyData:Class;
			
			shaderDatas= new MagnifyData();
			
			_centerX = centerX;
			_centerY = centerY;
			_innerRadius = innerRadius;
			_outerRadius = outerRadius;
			_magnification = magnification;
			update();
			super(mon_shader);

			
		}
		private function update():void {

			
			mon_shader = new Shader();
			mon_shader.byteCode = shaderDatas;
			mon_shader.data.center.value  = [centerX, centerY];
			mon_shader.data.innerRadius.value  = [innerRadius];
			mon_shader.data.outerRadius.value  = [outerRadius];
			mon_shader.data.magnification.value  = [magnification];
			mon_shader.precisionHint = ShaderPrecision.FAST;
			this.shader = mon_shader;
			
		}
		/**
		 * retourne un swingImageControleur qui permetra à l'utilisateur de modifier le filtre appliqué sur targetObject
		 * @param	targetObject	displayObject sur lequel est appliqué le filtre
		 * @return 	une interface utilisateur permettant de modifier le filtre
		 */
		public function getControler(targetObject:DisplayObject):SwingImageControler {
			//construit le controler
			var controler:SwingImageControler = new SwingImageControler(this,targetObject,"Magnify Filter",
			[
			new SwingImageControlerParam("Slider", "centerX", _centerX, { minValue:0, maxValue:2048,roundMultiplicator:1} ),
			new SwingImageControlerParam("Slider", "centerY", _centerY, { minValue:0, maxValue:2048,roundMultiplicator:1 } ),
			new SwingImageControlerParam("Slider", "innerRadius", _innerRadius, { minValue:0, maxValue:2048,roundMultiplicator:1 } ),
			new SwingImageControlerParam("Slider", "outerRadius", _outerRadius, { minValue:0, maxValue:2048,roundMultiplicator:1 } ),
			new SwingImageControlerParam("Slider", "magnification", _magnification, { minValue:1, maxValue:10,roundMultiplicator:0.01 } )
			]
			)
			return controler;
		}
		/**
		* Methode permettant de cloner le filtre
		* @return
		*/
		public function clone2():Magnify 
		{ 
			return new Magnify(_centerX,_centerY,_innerRadius,_outerRadius,_magnification);
		} 
		
		//----getter setters---
		
		public function get graphicRepresentation():Shape { return _graphicRepresentation; }		
		public function get centerX():Number { return _centerX; }
		public function get centerY():Number { return _centerY; }
		public function get innerRadius():Number { return _innerRadius; }
		public function get outerRadius():Number { return _outerRadius; }
		public function get magnification():Number { return _magnification; }
		
		
		public function set magnification(value:Number):void 
		{
			_magnification = value;
			update();
		}
		
		public function set outerRadius(value:Number):void 
		{
			_outerRadius = value;
			update();
		}
		
		public function set innerRadius(value:Number):void 
		{
			_innerRadius = value;
			update();
		}
		
		public function set centerY(value:Number):void 
		{
			_centerY = value;
			update();
		}
		
		public function set centerX(value:Number):void 
		{
			_centerX = value;
			update();
		}
		
		public function set graphicRepresentation(value:Shape):void 
		{
			_graphicRepresentation = value;
		}
		
	}

}
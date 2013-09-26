package com.shic.swingImage.filters 
{
	import com.shic.swingImage.SwingImageControler;
	import com.shic.swingImage.SwingImageControlerParam;
	import flash.display.DisplayObject;
	import flash.display.Shader;
	import flash.display.ShaderData;
	import flash.display.ShaderParameter;
	import flash.filters.ShaderFilter;
	import flash.display.ShaderInput;
	import flash.display.Shape;
	/**
	 * ...
	 * @author david m
	 */
	public class Spotlight extends ShaderFilter
	{
		
		private var _graphicRepresentation:Shape;
		private var _centerX:Number;
		private var _centerY:Number;
		private var _angle:Number;
		private var _coneAngle:Number;
		private var _intensity:Number;
		private var mon_shader:Shader;
		
		
		public function Spotlight(centerX:Number,centerY:Number,angle:Number=45,coneAngle:Number=2,intensity:Number=15) 
		{
			[Embed(source="shaders/spotlight.pbj", mimeType="application/octet-stream")] 
			var SpotlightData:Class;
			
			mon_shader = new Shader(new SpotlightData());
			
			//--------------trace-----------------
			
			trace("--------------ShaderParameters---------------");
			
			//var i:ShaderInput;
			var shaderData:ShaderData = mon_shader.data;
			//trace(shaderData.
			var input:ShaderInput;
			var parameter:ShaderParameter;
			
			for (var prop:String in shaderData) 
			{
				//trace(prop);
				if (shaderData[prop] is ShaderInput) 
				{ 
					input = shaderData[prop];
					trace("ShaderInput: "+prop+": "+input.input); 
				} 
				else if (shaderData[prop] is ShaderParameter) 
				{ 
					parameter = shaderData[prop];
					//parameters[parameters.length] = shaderData[prop]; 
					trace("ShaderParameter: " + prop + ": " + parameter.type + " = " + parameter.value);
					trace("minValue: " + parameter.minValue);
					trace("maxValue: "+parameter.maxValue);
				} 
				else 
				{ 
					//metadata[metadata.length] = shaderData[prop]; 
					trace("meta: "+prop+": "+shaderData[prop]);
				} 
			}
			
			
			///
			
			
			
			_centerX = centerX;
			_centerY = centerY;
			_angle = angle;
			_coneAngle = coneAngle;
			_intensity = intensity;
			
			
			mon_shader.data.position.value  = [_centerX, _centerY,100.0];
			mon_shader.data.angle.value  = [_angle];
			mon_shader.data.coneAngle.value  = [_coneAngle];
			mon_shader.data.intensity.value  = [_intensity];
			
			/*
			mon_shader.data.attenuationDecay.value  = [1.0];
			mon_shader.data.attenuationSpeed.value  = [strength/10];
			mon_shader.data.attenuationDelta.value  = [radius];
			*/
			
			
			//mon_shader.data.strength.value  = [strength];
			super(mon_shader);
			
			//graphicRepresentation = new Shape();
			//graphicRepresentation.graphics.lineStyle(1, 0xff0000, 100);
			//graphicRepresentation.graphics.drawCircle(centerX, centerY, radius);

	
			
			
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
			new SwingImageControlerParam("Slider", "angle", _angle, { minValue:0, maxValue:2048 } ),
			new SwingImageControlerParam("Slider", "coneAngle",_coneAngle , { minValue:0, maxValue:2048 } ),
			new SwingImageControlerParam("Slider", "intensity", _intensity, { minValue:0, maxValue:50 } )
			]
			)
			return controler;
		}
		
		/**
		* Methode permettant de cloner le filtre
		* @return
		*/
		public function clone2():Spotlight 
		{ 
			return new Spotlight(_centerX,_centerY,_angle,_coneAngle,_intensity);
		} 
		
		public function get graphicRepresentation():Shape { return _graphicRepresentation; }
		
		public function set graphicRepresentation(value:Shape):void 
		{
			_graphicRepresentation = value;
		}
		
		public function get centerX():Number { return _centerX; }
		
		public function set centerX(value:Number):void 
		{
			_centerX = value;
		}
		
		public function get centerY():Number { return _centerY; }
		
		public function set centerY(value:Number):void 
		{
			_centerY = value;
		}
		
		public function get angle():Number { return _angle; }
		
		public function set angle(value:Number):void 
		{
			_angle = value;
		}
		
		public function get coneAngle():Number { return _coneAngle; }
		
		public function set coneAngle(value:Number):void 
		{
			_coneAngle = value;
		}
		
		public function get intensity():Number { return _intensity; }
		
		public function set intensity(value:Number):void 
		{
			_intensity = value;
		}
		
		
	}

}
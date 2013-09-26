package com.shic.swingImage 
{
	import flash.display.Shader;
	import flash.display.ShaderData;
	import flash.display.ShaderPrecision;
	import flash.filters.ShaderFilter;
	import flash.display.ShaderInput;
	import flash.display.Shape;
	/**
	 * ...
	 * @author david m
	 */
	public class Solarize extends ShaderFilter
	{
		[Embed(source="shaders/Solarize.pbj", mimeType="application/octet-stream")] 
		public var SolarizeData:Class;
		//public var graphicRepresentation:Shape;
		
		public function Solarize(centerX:Number=150,centerY:Number=150,radius:Number=150,strength:uint=6) 
		{
			var mon_shader:Shader = new Shader(new SolarizeData());
			mon_shader.data.center.value  = [centerX, centerY];
			//mon_shader.data.radius.value  = [radius];
			
			mon_shader.data.attenuationDecay.value  = [1.0];
			mon_shader.data.attenuationSpeed.value  = [strength/10];
			mon_shader.data.attenuationDelta.value  = [radius];
			mon_shader.precisionHint = ShaderPrecision.FAST;
			super(mon_shader);
			
		}
		
	}

}
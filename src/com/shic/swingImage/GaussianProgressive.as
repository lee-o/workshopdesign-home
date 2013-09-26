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
	public class GaussianProgressive extends ShaderFilter
	{
		[Embed(source="shaders/GaussianProgressive.pbj", mimeType="application/octet-stream")] 
		public var GaussianProgressiveData:Class;
		public var graphicRepresentation:Shape;
		
		public function GaussianProgressive(centerX:Number=150,centerY:Number=150,radius:Number=150,strength:uint=6) 
		{
			var mon_shader:Shader = new Shader(new GaussianProgressiveData());
			mon_shader.data.center.value  = [centerX, centerY];
			mon_shader.data.radius.value  = [radius];
			mon_shader.data.strength.value  = [strength];
			mon_shader.precisionHint = ShaderPrecision.FAST;
			super(mon_shader);
			
			graphicRepresentation = new Shape();
			graphicRepresentation.graphics.lineStyle(1, 0xff0000, 100);
			graphicRepresentation.graphics.drawCircle(centerX, centerY, radius);

			
			
			
		}
		
	}

}
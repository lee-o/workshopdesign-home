package com.shic.swingImage 
{
	import flash.display.BitmapData;
	import flash.filters.BitmapFilter;
	import flash.geom.Point;
	import flash.display.BitmapDataChannel
	import flash.filters.DisplacementMapFilterMode
	import flash.filters.DisplacementMapFilter
	/**
	 * ...
	 * @author david m
	 */
	public class Distort
	{
		/**
		 * le filtre résultant
		 */
		public var filter:BitmapFilter;
		/**
		 * le facteur de déformation x
		 */
		public var deplacementX:Number;
		/**
		 * le facteur de déformation y
		 */
		public var deplacementY:Number;
		/**
		 * le facteur aléatoire de génération de la transformation
		 */
		public var randomSeed:Number;
		/**
		 * le bitmapData généré utilisé pour la déformation
		 */
		public var bitmapDistort:BitmapData;
		
		/**
		 * 
		 * @param	bmpd	une instance de bitmapData qui permettra de déterminer la taille du filtre renvoyé
		 * @param	deplacementX_p	nombre de pixels en x pour la déformation une valeur de 200 donnera un déplacement pouvant se faire de -200 à 200
		 * @param	deplacementY_p	nombre de pixels en y pour la déformation une valeur de 200 donnera un déplacement pouvant se faire de -200 à 200
		 * @param	randomSeed_p	ce chiffre determinera une transformation pseudo aléatoire, si le parametre est omis ou égal à 0 chaque nouvelle instance du filtre sera aléatoire, si une valeur fixe est passée alors la déformation sera identique.
		 */
		public function Distort(bmpd:BitmapData,deplacementX_p:Number,deplacementY_p:Number,randomSeed_p:Number) {
			
			if (randomSeed_p==0) {
				randomSeed = Math.random()*1000
			}else {
				randomSeed = randomSeed_p;
			}
			
			deplacementX = deplacementX_p;
			deplacementY = deplacementY_p;
			
			filter = getFilter(bmpd);
			
			
		}
		public function getFilter(bmpd:BitmapData) :BitmapFilter
		{
			
			var point:Point=new Point(0,0);
			var pt:Array=new Array(point,point)			
			bitmapDistort = new BitmapData(bmpd.width, bmpd.height, false, 0xff0000);
			bitmapDistort.perlinNoise(500,500,1,randomSeed,true,true,7,false,pt)

            var mapPoint:Point       = new Point(0, 0);
            var componentX:uint      = BitmapDataChannel.RED;
            var componentY:uint      = BitmapDataChannel.GREEN;
            var scaleX:Number        = deplacementX;
            var scaleY:Number        = deplacementY;
            var mode:String          = DisplacementMapFilterMode.WRAP ;
            var color:uint           = 0;
            var alpha:Number         = 0;
            
			var filtre:DisplacementMapFilter = new DisplacementMapFilter(
											bitmapDistort,
                                            mapPoint,
                                            componentX,
                                            componentY,
                                            scaleX,
                                            scaleY,
                                            mode,
                                            color,
                                            alpha);
											
			pt = null;
			point = null;
			
			return filtre;
			
			
		}


		
	}
	
}
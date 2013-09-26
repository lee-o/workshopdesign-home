package com.shic.utils{
	///////////////////////////////////
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.net.*;
	///////////////////////////////////
	public dynamic class Utils{
	/**
	 * renvoie le résultat d'un produit
	 * @param	valeur	valeur d'entrée
	 * @param	maxentree	valeur maximale de la valeur d'entrée
	 * @param	maxsortie	valeur maximale de la valeur de sortie
	 * @param	minentree	valeur minimale de la valeur d'entrée
	 * @param	minsortie	valeur minimale de la valeur de sortie
	 * @return	le résultat du produit
	 */
	public static function rapport (valeur:Number,maxentree:Number, maxsortie:Number, minentree:Number, minsortie:Number):Number {
		var produitentree:Number = (valeur-minentree)/(maxentree-minentree);
		var valeursortie:Number = ((maxsortie-minsortie)*produitentree)+minsortie;
		return valeursortie;
	}
	/**
	 * renvoi les noms des fonts embarquees dans un doc
	 */
	//KNOW FONT EMBED
	//
	public static function knowFont():void{
		for (var f:* in Font.enumerateFonts()) {
			var toto:Font = Font.enumerateFonts()[f];
			trace(toto);
			trace(toto.fontName);
			trace(toto.fontStyle);
			trace(toto.fontType);
		}
	}
	/**
	 * renvoie l'arrondi d'un nombre.<br>
	 * floorAt(5.684, 0.1) retournera 5.7
	 * @param	number
	 * @param	roundLevel
	 * @return
	 */
	public static function roundAt(number:Number, roundLevel:Number):Number {
		var divisor:Number = (1 / roundLevel)
		var multiplicated:int = Math.round(number * divisor)
		var result:Number = multiplicated * roundLevel;
		return debugDecimal(result);
	}
	/**
	 * renvoie le plancher d'un nombre.<br>
	 * floorAt(5.684, 0.1) retournera 5.6
	 * @param	number
	 * @param	roundLevel
	 * @return
	 */
	public static function floorAt(number:Number, roundLevel:Number):Number {
		var divisor:Number = (1 / roundLevel)
		var multiplicated:int = Math.floor(number * divisor)
		var result:Number = multiplicated * roundLevel;
		return debugDecimal(result);

	}
	/**
	 * Il peut arriver que flash génere des bugs dans ses opération de multiplication et divisions en produisant des valeurs de type 5.000000000000001 alors que 5 est attendu. Cette fonction renvoie la valeur à la 10ème décimale évitant ainsi ce bug.
	 * @param	num
	 */
	public static function debugDecimal(num:Number):Number {
		var tab:Array = String(num).split(".");
		if (!tab[0]) {
			return num;
		}
		if (!tab[1]) {
			return tab[0];
		}
		return  Number(tab[0]+"."+tab[1].substring(0,10));
	}
	/**
	 * si valeur > max, retournera max, <br/>
	 * si valeur < min, retournera min, <br/>
	 * sinon retournera valeur inchangé.
	 * @param	valeur valeur d'entrée qui sera vérifiée.
	 * @param	min	valeur minimale de sortie.
	 * @param	max	valeur maximale de sortie.
	 * @return	valeur où valeur >=min && valeur <=max
	 */
	public static function limites(valeur:Number,min:Number,max:Number):Number {
		if (valeur < min) {
			valeur = min;
		}else if (valeur>max) {
			valeur = max;
		}
		return valeur;
	}
	/**
	 * retourne un boléen à partir d'une chaine.<br/>
	 * Si str == "false" ou "FALSE" ou "" retourne le booléen false dans tous les autres cas, retourne true
	 * @param	str
	 * @return
	 */
	public static function getBool (str:String):Boolean {
		if (str=="FALSE" || str=="false" || str=="") {
			return false;
		} else {
			return true;
		}
	}
	//
	// 
	//
	public static function sprite2Bmp (sprite_mc:*):void {
		////////////////////////////
		var bmpd:BitmapData = new BitmapData(sprite_mc.getBounds(sprite_mc).width + sprite_mc.getBounds(sprite_mc).x, sprite_mc.getBounds(sprite_mc).height + sprite_mc.getBounds(sprite_mc).y, true, 0x00ff00);
		////////////////////////////
		bmpd.draw (sprite_mc);
		var bmp:Bitmap = new Bitmap(bmpd,"auto", true);
		////////////////////////////
		while (sprite_mc.numChildren>0) {
			sprite_mc.removeChildAt(0);
		}
		////////////////////////////
		sprite_mc.addChild (bmp);
	}
	
	//
	// obtenir le nom d'un fichier
	//
	
	public static function getNomFichier (url:String) :String{
		var url_array:Array=url.split("/");
		return url_array[url_array.length - 1];
		
	}
	
	//
	// xml2variable
	//
	public static function xmlToVariables(p_xml:XMLList, p_objet:Object, p_recursif:Boolean):void {		
		/////
		var xmlObject:XMLList = p_xml;
		var lngXml:Number = p_xml.children().length();
		var objetlist:Object = p_objet;
		/////
		if (p_recursif == false ) {
			var i:uint;		
			for (i = 0; i < lngXml; i++ ) {
				var Name:String =  xmlObject[i].name();
				objetlist[Name] = xmlObject[i];
			}
		}
		/////
	}

	/**
	 * Remplace une chaine dans une chaine
	 * @param	chaine
	 * @param	chaine a remplacer
	 * @param	chaine remplacante
	 * @return
	 */
	
	public static function strReplace(str:String, needle:String, haystack:String):String {
		return str.split(needle).join(haystack);
	};
	
	
	public static function html2Text(str:String):String {
		var temp_txt:TextField = new TextField();
		temp_txt.htmlText = str

		return temp_txt.text;
	}
	/**
	 * Retourne un bitmap data d'un display object aux positions et tailles indiquées par rectangle
	 * @param	clip
	 * @param	rectangle
	 * @param	transparent
	 * @param	color
	 * @return
	 */
	
	public static function getBitmapDataAtRect(clip:DisplayObject, rectangle:Rectangle,transparent:Boolean=false,color:uint=0xff0000):BitmapData {
		
		var BMPD:BitmapData = new BitmapData(rectangle.width, rectangle.height, transparent, color);
		
		var matrix:Matrix = new Matrix(1, 0, 0, 1, -rectangle.width, -rectangle.height);
		BMPD.draw(clip,matrix);
		matrix = null;		
		return BMPD;
	}
	/**
	 * definit interactiveObject sur mouseEnabled=true buttonMode=true MouseChildren=false
	 * @param	interactiveObject
	 */
	public static function setAsBouton(interactiveObject:*):void {
		interactiveObject.mouseEnabled = true;
		interactiveObject.buttonMode = true;
		interactiveObject.MouseChildren = false;
	}
	/**
	 * applique la propriété smoothing a tous les bitmaps descendant de l'objet indiqué
	 * @param	container un displayObject sur le quel sera appliqué le smoothing (ou non) ainsi qu'à tous ces descendants
	 * @param	smooth si true les bitmaps sont smooth, si false, les bitmaps sont pixel
	 */
	public static function smoothRecursive(container:*,smooth:Boolean=true):void {
		var i:uint = 0;
		if (container is Bitmap) {
			container.smoothing = smooth;
		}else if (container is DisplayObjectContainer) {
			for (i = 0; i < container.numChildren; i++) {
				Utils.smoothRecursive(container.getChildAt(i),smooth);
			}
		}
	}
	//
	//DATE
	//
	public static function secondesToMinutesInv(duration:Number,sec:Number):String {
		var d:Date = new Date();
		d.setMilliseconds(0);
		d.setHours(0);
		d.setMinutes(0);
		d.setSeconds(duration - sec);
		return dec(d.getMinutes())+":"+dec(d.getSeconds());
	};
	/////
	public static function secondesToMinutes(sec:Number):String {
		var d:Date = new Date();
		d.setMilliseconds(0);
		d.setHours(0);
		d.setMinutes(0);
		d.setSeconds(sec);
		return dec(d.getMinutes())+":"+dec(d.getSeconds());
	};
	/////
	public static function dec(valeur:Number):String {
		var ret:String;
		if (Number(valeur)<10) {
			ret = String("0")+Number(valeur);
		} else {
			ret = valeur.toString();
		}
		if (String(ret) != "NaN") {
			return ret;
		} else {
			return "00";
		}
	};
	/////
	public static function randRange(min:int, max:int):int {
	    var randomNum:int = Math.random() * (max - min) + min;
	    return randomNum;
	}
	/////
	public static function openExternalPage(link:String, target:String = "_blank"):void {
		var externalLink:URLRequest = new URLRequest(link);
		navigateToURL ( externalLink, target );
	}
	
}


}
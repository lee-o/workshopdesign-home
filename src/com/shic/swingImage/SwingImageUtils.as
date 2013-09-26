package com.shic.swingImage 
{
	import flash.display.DisplayObject;
	/**
	 * La classe SwingImageUtils offre des méthodes permettant de simplifier les opérations courantes sur des filtres.
	 * @author david m
	 */
	public class SwingImageUtils
	{
		
		/**
		* Compare filterA et filterB, si les filtres sont identiques renvoie true, sinon false
		* @param	filterA
		* @param	filterB
		*/
		public static function isSameFilter(filterA:*, filterB:*):Boolean {
			//trace("compare "+filterA+" et "+filterB);
			switch(String(filterA)) {
				
				case "[object ShaderFilter]":
					//trace("is shader");
					if (filterB.shader != null && filterB.shader==filterA.shader) {
						return true;
					}
					break;
				default:
					return false;
					break
			}
			return false;
			
		}
		
		/**
		* tente de remplacer oldFilter par newFilter dans le tableau filters de targetObject
		* @param	targetObject	le displayObject sur lequel est appliqué le filtre
		* @param	newFilter	le nouveau filtre à appliquer
		* @param	oldFilter	l'ancien filtre à replacer
		*/
		public static function replaceFilterInObject(targetObject:DisplayObject, newFilter:*, oldFilter:*= null):void {
			if (targetObject==null || newFilter==null || oldFilter==null) {
				//trace("rien");
			}else{
				//targetObject.filters = [newFilter];
				
				var i:uint;
				var found:Boolean = false;
				var theFilters:Array = new Array();
				
				//targetObject.filters = theFilters;
				for (i = 0; i < targetObject.filters.length; i++) {
					if (SwingImageUtils.isSameFilter(targetObject.filters[i], oldFilter)) {
						theFilters.push(newFilter);
					}else {
						theFilters.push(targetObject.filters[i]);
					}
				}
				//trace("result is:"+theFilters);
				targetObject.filters = theFilters;
			}
			
		}
		
	}

}
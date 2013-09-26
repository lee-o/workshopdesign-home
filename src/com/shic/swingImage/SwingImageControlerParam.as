package com.shic.swingImage 
{
	/**
	 * ...
	 * @author david m
	 */
	public class SwingImageControlerParam
	{
		public var uiType:String;
		public var variable:String;
		public var InitValue:*;
		public var  params:Object;
		
		/**
		 * Un objet SwingImageControlerParam contient les paramètres nécessaire pour générer un composant utilisateur permettatn de piloter les paramètres d'un filtre.
		 * Ces objets n'ont pas vocation à être utilisés en dehors du contexte des création de filtres personnalisés del aclasse swingImages.
		 * @param	_uiType Type de composant utilisateur (Slider | ...à compléter )
		 * @param	_variable	le nom du parmètre dans le filtre
		 * @param	_InitValue	valeur initiale à appliquer au composant utilisateur 
		 * @param	_params	objet de variables diverses dépendant du type de composant utilisateur choisi
		 */
		public function SwingImageControlerParam(_uiType:String, _variable:String,_InitValue:*,_params:Object ) 
		{
			uiType = _uiType;
			variable = _variable;
			InitValue = _InitValue;
			params = _params;
		}
		
	}

}
package com.shic.share
{
	import com.greensock.*;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.system.System;

	
	[Embed(source='player_share.swf', symbol='shareWindow')]
	/**
	 * l'objet share window crée une occurence de fenetre permettant à l'utilisateur de copier un permalink et un code embed
	 * @author shic
	 * @example	
	 * <listing version="3.0">
	 * share_window_mc = new share_window("http://www.google.com","http://toto.com/toto.swf?param1=truc",640,480,"#ff0000");
	 * </listing>
	 * 
	 * @return un display object
	 */
	public class share_window extends MovieClip
	{
		//private static var close_bt:MovieClip;
		public var close_mc : MovieClip;
		public var embed_txt : TextField;
		public var permalink_txt : TextField;
		public var copy_permalink_mc : MovieClip;
		public var copy_embed_mc : MovieClip;
		public static var embedCode:String;
		public static var permalink:String;
		
		/**
		 * 
		 * @param	permalink l'url de permalink à spécifier dans la fenêtre
		 * @param	swf	l'url du swf, le code embed html, sera généré automatiquement
		 * @param	width	largeur du swf embed
		 * @param	height	hauteur du swf embed
		 * @param	color	couleur de fond du swf (spécifier une couleur hexadécimale html de type #ff0000)
		 */
		public function share_window(permalink:String,swf:String,width:uint,height:uint,color:String) 
		{
			this.permalink_txt.text = permalink;
			this.embed_txt.text = swf;
			embed_txt.text = '<object id="mySWFid" name="mySWFid"  width="'+width+'" height="'+height+'">';
			embed_txt.appendText('<param name = "movie" value = "'+swf+'"/>');
			embed_txt.appendText('<param name = "menu" value = "false" />');
			embed_txt.appendText('<param name = "wmode" value = "opaque" /> ');
			embed_txt.appendText('<param name = "bgcolor" value = "'+color+'" /> ');
			embed_txt.appendText('<param name = "allowfullscreen" value = "true" /> ');
			embed_txt.appendText('<param name = "allowscriptaccess" value = "always" /> ');
			embed_txt.appendText('<embed src = "'+swf+'" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" wmode ="opaque" bgcolor = "'+color+'" width = "'+width+'"  height= "'+height+'" menu = "false" ></embed>');
			embed_txt.appendText('</object>');
			
			embedCode = embed_txt.text;
			permalink = permalink;
			
			embed_txt.border = false;
			embed_txt.backgroundColor = 0x5F5347;
			embed_txt.textColor = 0xDDD9D0;
			permalink_txt.border = false;
			permalink_txt.backgroundColor = 0x5F5347;
			permalink_txt.textColor = 0xDDD9D0;
			
			init_UI();
			
			//apparition
			show();
		}
		/**
		 * initialise les actions utilisateurs
		 */
		private function init_UI():void {
			copy_embed_mc.addEventListener(MouseEvent.CLICK, copy_text);
			copy_embed_mc.addEventListener(MouseEvent.MOUSE_OVER, hover_bouton);
			copy_embed_mc.addEventListener(MouseEvent.MOUSE_OUT, hout_bouton);
			copy_embed_mc.buttonMode = true;
			copy_embed_mc.mouseChildren = false;
			
			copy_permalink_mc.addEventListener(MouseEvent.CLICK, copy_text);
			copy_permalink_mc.addEventListener(MouseEvent.MOUSE_OVER, hover_bouton);
			copy_permalink_mc.addEventListener(MouseEvent.MOUSE_OUT, hout_bouton);
			copy_permalink_mc.buttonMode = true;
			copy_permalink_mc.mouseChildren = false;
			
			close_mc.addEventListener(MouseEvent.CLICK, close);
			close_mc.addEventListener(MouseEvent.MOUSE_OVER, hover_bouton);
			close_mc.addEventListener(MouseEvent.MOUSE_OUT, hout_bouton);
			close_mc.buttonMode = true;
			close_mc.mouseChildren = false;
			
		}
		
		
		/**
		 * effet rollOver sur le fond d'un objet
		 * @param	e
		 */
		private function hover_bouton(e:MouseEvent):void {	
			TweenMax.to(e.target.fond_mc, 0.3, { tint:0x333333} );
		}
		/**
		 * effet rollOut sur le fond d'un objet
		 * @param	e
		 */
		private function hout_bouton(e:MouseEvent):void {
			TweenMax.to(e.target.fond_mc, 0.3, { tint:0xB3B3AB} );
		}
		
		
		/**
		 * copie le texte associé dans le presse papier et fait un effet sur le texfield.
		 * @param	e
		 */
		private function copy_text(e:*):void {
			var source:TextField;
			if (e.target==copy_embed_mc) {
				source=embed_txt
			}else {
				source=permalink_txt
			}
			//source.filters = [];
			TweenMax.from(source, 0.5, { hexColors: { backgroundColor:0xffffff } } );
			System.setClipboard(source.text);
		}
		/**
		 * detruit l'objet share_window après avoir fait une transition de fermeture
		 * @param	e	un event listener en général...mais des fois non ;)
		 */
		public function close(e:* = null) :void{
			TweenMax.to(this, 0, { removeTint:true } );
			this.visible = false; 
			/*TweenMax.to(this, 0.3, { 
				colorTransform: { tint:0xffffff, tintAmount:1, exposure:2 }, 
				onComplete:function():void{ 
					this.visible = false; 
					//destroy();
					}
				} );*/

		}
		//
		public function show():void {
			this.visible = true;
			this.alpha = 1;
			this.filters = [];
			TweenMax.to(this, 0, {removeTint:true});
			TweenMax.from(this, 0.3, {colorTransform:{tint:0xffffff, tintAmount:1, exposure:2}} );
		}
		/**
		 * detruit l'objet share_window
		 * 
		 * @example 
		 * Ce code crée une fenêtre de partage et la positionne sur la scène à 100 / 100:
		 * <listing version="3.0">
		 * import com.shic.share.share_window
		 * var ma_fenetre:share_window=new share_window("http://www.shic.fr", "http://www.shic.fr/swf/shicPlayer.swf?langCode=fr", 640, 480, "#FF2266");
		 * this.addChild(ma_fenetre);
		 * ma_fenetre.x=100;
		 * ma_fenetre.y=100;
		 * ma_fenetre.destroy();
		 * </listing>
		 * 
		 */
		public function destroy():void {
			if (this.parent != null && this != null) {
				this.parent.removeChild(this);
				//this = null;
			}
			copy_embed_mc.removeEventListener(MouseEvent.CLICK, copy_text);
			copy_permalink_mc.removeEventListener(MouseEvent.CLICK, copy_text);
			close_mc.removeEventListener(MouseEvent.CLICK, close);
		}
		
	}
	
}
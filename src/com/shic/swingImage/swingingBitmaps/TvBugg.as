package com.shic.swingImage.swingingBitmaps 
{
import com.shic.swingImage.filters.DistortHorizontal;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BitmapDataChannel;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.BitmapFilter;
import flash.filters.DisplacementMapFilter;
import flash.filters.DisplacementMapFilterMode;
import flash.geom.Point;
import flash.geom.Rectangle;
/**
 * ...
 * @author ...
 */
public class TvBugg extends Sprite
{
	private var bmpdOrignal:BitmapData;
	private var bmpd:BitmapData;
	private var yy:uint = 0;
	private var container:Sprite = new Sprite();
	private var bmp1:Bitmap;
	private var bmp2:Bitmap;
	public var deformFactor:uint = 0;
	private var waveSize:Number = 0;
	private var deformPosition:Number = 0;
	private var vitesseScrollY:Number = 1;
		
	public function TvBugg(p_bmpd:BitmapData) 
	{
		
		if (stage) {
			trace("aa");
			init();
		}else {
			trace("bb");
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
		bmpdOrignal = p_bmpd;
		

	}
	
	public function init(e:Event = null):void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		//creer les doubles bitmaps
		bmp1 = new Bitmap(bmpdOrignal);
		bmp2 = new Bitmap(bmpdOrignal);
		//on travaille avec de simages 2 fois plus petites pour plus de fluidité
		//bmp1.scaleX = bmp2.scaleX = bmp1.scaleY = bmp2.scaleY = 0.5;
		
		//attache 2 bitmaps au container qui subira les déformations et sera imprimé par la suite
		container.addChild(bmp1);
		container.addChild(bmp2);
		container.addEventListener(Event.ENTER_FRAME, loop);
		container.scrollRect = new Rectangle(0, 0, Math.ceil(bmpdOrignal.width), Math.ceil(bmpdOrignal.height));
		this.addChild(container);
		
		//le bitmap qui sera modifié
		bmpd = new BitmapData(container.width,container.height,bmpdOrignal.transparent,0xff5522);
		
		loop();
		//super(bmpd);
		//this.scaleX = this.scaleY = 2;
		//this.smoothing = true;
		
		this.addEventListener(Event.ENTER_FRAME, loop);
		this.addEventListener(Event.REMOVED_FROM_STAGE, destoy);
		
		
		
	}
	/**
	 * Efface les références et listeners au sein de l'objet
	 * @param	e
	 */
	private function destoy(e:Event):void 
	{
		removeEventListener(Event.REMOVED_FROM_STAGE, destoy);
		this.removeEventListener(Event.ENTER_FRAME, loop);
		bmpd.dispose();
		bmpdOrignal.dispose();
		bmpd = null;
		bmpdOrignal = null;
	}
	
	
	private function loop(e:Event=null):void 
	{
		vitesseScrollY = vitesseScrollY * 1.3;
		if (vitesseScrollY>20) {
			vitesseScrollY = 20;
		}
		scrollImage(vitesseScrollY, "y");
		deformeImage();
		setBMPD();	
	}
		
	
	public function setBMPD ():void {
		if(bmpd){
			bmpd.draw(container);
		}
	}
	
	
	
	
	private function scrollImage(_p:uint, axis:String):void {
			
			if (axis=="x") {
				bmp1.x += _p;
				if (bmp1.x>0) {
					bmp1.x -=bmp1.width;
				}
				bmp2.x = container.bmp1.x + bmp1.width;
			}else {
				bmp1.y += _p;
				if (bmp1.y>0) {
					bmp1.y -=bmp1.height;
				}
				bmp2.y = bmp1.y + bmp1.height;
			}
	}
	private function deformeImage():void {
			
			//deform_xx+=20+Math.random()*5
			//deform_yy += 20 + Math.random() * 5
			/*
			var deform_xx:Number=0
			var deform_yy:Number = 0
			deformFactor = 500;
		
			var point:Point=new Point(deform_xx,deform_yy);
			var pt:Array=new Array(point,point)			
			var bmpdPerlin:BitmapData = new BitmapData(container.width, container.height, false, 0xff0000);
			bmpdPerlin.perlinNoise(5000, 5000, 1, 1, true, true, 7, false, pt)
			*/
			var filter_deform:DistortHorizontal = getDeformFilter();
			container.filters=[filter_deform]
			/*
			bmpdPerlin = null;
			point = null;
			pt = null;
			*/
			
	}
	private function getDeformFilter():DistortHorizontal {
			waveSize += 2;
			if (waveSize > 50) {
				waveSize = 50;
			}
			deformPosition+=0.2
          return new DistortHorizontal(container.width, container.height,waveSize,deformPosition);
    }
	
	
	
}
}
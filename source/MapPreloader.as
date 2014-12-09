package  {
	/**
	 * ...
	 * @author aichukanov
	 */
	
	import flash.display.Bitmap;
	
	import starling.display.Sprite;
	import starling.display.MovieClip;
	
	import starling.textures.TextureAtlas;
	import starling.textures.Texture;
	
	import starling.core.Starling;
	import starling.animation.Juggler;
	import starling.events.Event;
	
	public class MapPreloader extends Sprite {
		[Embed(source="Media/preloader/round.xml",mimeType="application/octet-stream")]
	 	public static const PreloaderXML:Class;
		
	 	[Embed(source="Media/preloader/round.png")]
	 	private static const PreloaderPNG:Class;
		
		private var mMovie:MovieClip;
		
		public function MapPreloader() {	
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(evt:Event = null):void {
			try {
				var bitmap:Bitmap = new PreloaderPNG();
				var texture:Texture = Texture.fromBitmap(bitmap);
				var xml:XML = XML(new PreloaderXML());
				var sTextureAtlas:TextureAtlas = new TextureAtlas(texture, xml);
				var frames:Vector.<Texture> = sTextureAtlas.getTextures("roundpreloader_");
				mMovie = new MovieClip(frames, 24);
				mMovie.pivotX = mMovie.width >> 1;
				mMovie.pivotY = mMovie.height >> 1;
				mMovie.x = (stage.stageWidth - mMovie.width) + mMovie.width >> 1;
				mMovie.y = stage.stageHeight - mMovie.height >> 1;
				
				stage.addChild(mMovie);
				Starling.juggler.add(mMovie);
			}
			catch (e:Error) {
				trace("Preloader init()",e.message);
			}
		}
		
		public function hidePL():void {
			try {
				stage.removeChild(mMovie);
			}
			catch (e:Error) {
				trace("MapPreloader hidePL()",e.message);
			}
		}
	}
	
}

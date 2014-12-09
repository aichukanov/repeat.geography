package 
{
	/**
	 * ...
	 * @author aichukanov
	 */
	
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.events.Event;
	
	public class Logo extends Sprite {
		[Embed(source="/Media/logo/logo.png")]
	 	private static const LogoPNG:Class;
		
		private var logo:Image;
		
		function Logo() {
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(evt:Event = null) : void {
			try {
				removeEventListener(Event.ADDED_TO_STAGE, init);
				logo = new Image(Texture.fromBitmap(new LogoPNG()));
				addChild(logo);
				logo.x = 0;
				logo.y = 0;
			}
			catch (e:Error) {
				trace("Logo init()", e.message);
			}
		}
	}
	
}
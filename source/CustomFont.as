package 
{
	/**
	 * ...
	 * @author aichukanov
	 */
	
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.events.Event;
	
	import flash.text.Font;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.text.TextFieldAutoSize;
	import starling.utils.VAlign;
	import starling.utils.HAlign;
	
	public class CustomFont {
		[Embed(source = "/Media/fonts/53453.ttf", embedAsCFF = "false", fontName = "1212")]
		public static const RobotoRegular:Class;
		
		[Embed(source = "/Media/fonts/45223.ttf", embedAsCFF = "false", fontName = "2324t")]
		public static const RobotoItalic:Class;
	 			
		function CustomFont() {
			//
		}
	}
	
}
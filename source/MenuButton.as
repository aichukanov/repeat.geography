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
	
	public class MenuButton extends Sprite {		
	 	[Embed(source = "/Media/fonts/Roboto-Light.ttf", embedAsCFF = "false", fontName = "RobotoLight")]
		private static const RobotoLight:Class;
		
		[Embed(source="/Media/buttons/btn_bg.png")]
	 	private static const BtnBGPNG:Class;
		
		private static const defFS:uint = 24;
		
		private var desc:String;
		private var bg:Image;
		private var tf:TextField;
		private var font:Font = new RobotoLight();
		
		function MenuButton(str:String) {
			super();
			
			bg = new Image(Texture.fromBitmap(new BtnBGPNG()));
			desc = str;
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(evt:Event = null) : void {
			try {
				removeEventListener(Event.ADDED_TO_STAGE, init);
				
				tf = new TextField(bg.width, bg.height, desc, font.fontName, defFS, 0xFFFFFF);
				
				tf.vAlign = VAlign.CENTER;
				tf.hAlign = HAlign.CENTER;
				
				tf.x = bg.x;
				tf.y = bg.y;
								
				this.addChild(bg);
				this.addChild(tf);
				
				tf.autoScale = true;
				tf.height = bg.height;
			}
			catch (e:Error) {
				trace("MenuButton init()", e.message);
			}
		}
	}
	
}
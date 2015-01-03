package 
{
	/**
	 * ...
	 * @author aichukanov
	 */
	
	//import starling.display.Sprite;
	import starling.display.Image;
	import starling.events.Event;
	
	import flash.text.Font;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.text.TextFieldAutoSize;
	import starling.utils.VAlign;
	import starling.utils.HAlign;
	import starling.display.Button;
	
	public class MenuButton extends Button {		
		[Embed(source="/Media/buttons/btn_bg.png")]
	 	private static const BtnBGPNG:Class;
		
		private static const defFS:uint = 24;
		
		//private var desc:String;
		//private var bg:Image;
		//private var tf:TextField;
		private var font:Font = new CustomFont.RobotoRegular();
		
		function MenuButton(str:String) {
			super(Texture.fromBitmap(new BtnBGPNG()),str);
			/*
			bg = new Image(Texture.fromBitmap(new BtnBGPNG()));
			desc = str;
			*/
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(evt:Event = null) : void {
			try {
				removeEventListener(Event.ADDED_TO_STAGE, init);
				
				this.fontName = font.fontName;
				this.fontColor = 0x000000;
				this.fontSize = defFS;
				this.scaleWhenDown = 0.98;
			}
			catch (e:Error) {
				trace("MenuButton init()", e.message);
			}
		}
				
		/*
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
		*/
	}
	
}
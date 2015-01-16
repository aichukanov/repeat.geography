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
		[Embed(source="../media/buttons/btn_bg.png")]
	 	private static const BtnBGPNG:Class;
		
		private static const defFS:uint = 24;
		
		private var font:Font = new CustomFont.RobotoRegular();
		
		function MenuButton(str:String) {
			super(Texture.fromBitmap(new BtnBGPNG()),str);
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
	}
	
}
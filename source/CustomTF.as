package  {
	import starling.text.TextField;
	import flash.text.Font;
	import starling.utils.VAlign;
	import starling.utils.HAlign;
	
	public class CustomTF {
		
		public function CustomTF() {
			//
		}
		
		public static function makeTF(w:Number, h:Number,fs:uint,pos:String = "CENTER",isItalic:Boolean = false):TextField {
			var font:Font = isItalic ? new CustomFont.RobotoItalic() : new CustomFont.RobotoRegular();
			
			var tf:TextField = new TextField(w, h, "", font.fontName, fs, 0xFFFFFF);
			tf.vAlign = VAlign.CENTER;
			tf.hAlign = HAlign[pos];
			
			return tf;
		}
		
	}
	
}

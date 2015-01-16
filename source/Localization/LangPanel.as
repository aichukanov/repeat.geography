package Localization
{
	/**
	 * ...
	 * @author aichukanov
	 */
	
	import starling.core.Starling;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import flash.filters.GlowFilter;
	import starling.display.Quad;
	import starling.display.Image;
	import starling.text.TextField;
	import flash.geom.Rectangle;
	import starling.display.Button;
	import starling.textures.TextureAtlas;
	import starling.textures.Texture;
	import starling.events.TouchPhase;
	import starling.animation.Tween;
	import starling.animation.Transitions;
	
	public class LangPanel extends Sprite {		
		[Embed(source = "../../media/flags/flags.png")]
		private static const FlagsPNG:Class;
		
		[Embed(source = "../../media/flags/flags.xml",mimeType="application/octet-stream")]
	 	public static const FlagsXML:Class;
				
	 	[Embed(source = "../../media/buttons/arrow_expand.png")]
		private static const ArrowExpandPNG:Class;
		
	 	[Embed(source = "../../media/buttons/arrow_collapse.png")]
		private static const ArrowCollapsePNG:Class;
		
		public var flagAtlas:TextureAtlas;
		
		public var arrowExpand:Button;
		public var arrowCollapse:Button;
		
		private var langPanel:Sprite;
		private var langPanelWidth:Number = 0;
		private var maskWidth:Number = 0;
		
		function LangPanel() {
			super();
			flagAtlas = new TextureAtlas(Texture.fromBitmap(new FlagsPNG()), XML(new FlagsXML()));			
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(evt:Event = null) : void {
			try {
				removeEventListener(Event.ADDED_TO_STAGE, init);
				
				langPanel = new Sprite();
				this.addChild(langPanel);
				
				arrowExpand = new Button(Texture.fromBitmap(new ArrowExpandPNG()));
				arrowCollapse = new Button(Texture.fromBitmap(new ArrowCollapsePNG()));
				
				arrowExpand.addEventListener(TouchEvent.TOUCH, expandPanelHandler);
				langPanel.addChild(arrowExpand);
				arrowExpand.x = 0;
				arrowExpand.y = 10;
				
				addFlagBtns();	
		
				arrowCollapse.addEventListener(TouchEvent.TOUCH, collapsePanelHandler);
				langPanel.addChild(arrowCollapse);
				arrowCollapse.x = langPanel.width + 10;
				arrowCollapse.y = 10;
				
				var q:Quad = new Quad(langPanel.width + 5,60,0x000000);
				langPanel.addChildAt(q,0);
				q.x = 0;
				q.y = 0;
				
				langPanelWidth 	= langPanel.width;
				maskWidth 		= arrowExpand.width;
				
				var rect:Rectangle = new Rectangle(0,0,maskWidth,langPanel.height);
				langPanel.clipRect = rect;
			}
			catch (e:Error) {
				trace("LangPanel init()", e.message);
			}
		}
		
		private function addFlagBtns():void {
			var arr:Vector.<String> = flagAtlas.getNames();
			var curX:Number = 25;
			var curY:Number = 10;
			
			var btnSprite:Sprite;
			var q:Quad;
			var lang:String;
			
			var flag:Flag;
			
			for (var i:uint = 0; i < arr.length; i++) {
				try {
					lang = arr[i];
					btnSprite 	= new Sprite();
					
					langPanel.addChild(btnSprite);
					btnSprite.x = curX;
					btnSprite.y = curY;
					
					//btnSprite.addChild(newFlag(lang));
					flag = new Flag(flagAtlas.getTexture(lang),lang);
					btnSprite.addChild(flag);
					curX += btnSprite.width + 20;
					
					// adding a hit area
					q = new Quad(btnSprite.width,btnSprite.height);
					q.name = lang;
					q.addEventListener(TouchEvent.TOUCH,switchLanguageHandler);
					q.alpha = 0.01;
					q.useHandCursor = true;
					btnSprite.addChild(q);
				}
				catch (e:Error) { trace("LangPanel addFlagBtns()",e.message); }
			}
		}
		
		// по нажатию на стрелку раскрываем панель языков
		private function expandPanelHandler(evt:TouchEvent):void {
			try {
				var t:Touch = evt.touches[0];
				t.phase == TouchPhase.ENDED ? expandPanel() : null;
			}
			catch (e:Error) { trace("LangPanel expandPanelHandler()",e.message); }
		}
		
		// по нажатию на стрелку скрываем панель языков
		private function collapsePanelHandler(evt:TouchEvent):void {
			try {
				var t:Touch = evt.touches[0];
				t.phase == TouchPhase.ENDED ? collapsePanel() : null;
			}
			catch (e:Error) { trace("LangPanel collapsePanelHandler()",e.message); }
		}
		
		// раскрыть панель
		public function expandPanel():void {
			var rect:Rectangle = new Rectangle(0,0,maskWidth,langPanel.height);
			tweenPanel(rect, langPanelWidth, maskWidth);
		}
		
		// скрыть панель
		public function collapsePanel():void {			
			var rect:Rectangle = new Rectangle(maskWidth,0,langPanelWidth,langPanel.height);
			tweenPanel(rect, maskWidth, 0);
		}
		
		// анимировать маску (lMask-rectangle), на новую ширину newW и новый x newX 
		private function tweenPanel(lMask:Rectangle, newW:Number, newX:Number):void {
			var tween:Tween;
			
			try {
				langPanel.clipRect = null;
				langPanel.clipRect = lMask;
				
				tween = new Tween(lMask, 0.5, Transitions.EASE_OUT);
				tween.onUpdate = onTweenMask;
				tween.animate("width", newW);
				tween.animate("x", newX);
				Starling.juggler.add(tween);
			}
			catch (e:Error) {
				trace("LangPanel tweenPanel()",e.message);
			}
			
			function onTweenMask():void {
				try {
					langPanel.clipRect = null;
					langPanel.clipRect = lMask;
				}
				catch (e:Error) { trace("LangPanel tweenPanel onTweenMask()",e.message); }
			}
		}
		
		private function switchLanguageHandler(evt:TouchEvent):void { 
			try {
				var t:Touch = evt.touches[0];
				var str:String = (evt.currentTarget as Quad).name;
				t.phase == TouchPhase.ENDED ? switchLanguage(str) : null;
			}
			catch (e:Error) { trace("LangPanel switchLanguageHandler()",e.message); }
		}
		
		private function switchLanguage(str:String):void {
			dispatchEventWith(LangEvent.SWITCH_LANGUAGE,false,{newLang:str});
			collapsePanel();
		}
	}
	
}
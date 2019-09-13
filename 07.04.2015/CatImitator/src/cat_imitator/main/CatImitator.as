// Project CatImitator
package cat_imitator.main {
	
	//{ ======= import
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import cat_imitator.Application;
	import cat_imitator.IApplication;
	
	import com.junkbyte.console.Console;
	import com.junkbyte.console.ConsoleChannel;
	import com.junkbyte.console.ConsoleConfig;
	
	import cat_imitator.LOG;
	import cat_imitator.LOGGER;
	import cat_imitator.data.ApplicationConstants;
	//} ======= END OF import
	
	
	/**
	 * Main
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * 
	 */
	public class CatImitator extends Sprite {
		
		//{ ======= CONSTRUCTOR
		
		function CatImitator () {
			if (stage) {init();}
			else {addEventListener(Event.ADDED_TO_STAGE, init);}
		}
		
		private function init(e:Event=null):void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			
			// tip: press "`" button to display/hide console
			prepareConsole(ApplicationConstants.AppW, ApplicationConstants.AppH, ApplicationConstants.AppH/3);
			// show console:
			c.visible=true;
			
			prepareLogging();
			prepareView();
			prepareControl();
			//prepareNetwork();
			run();
		}
		
		//} ======= END OF CONSTRUCTOR
		
		
		
		//{ ======= run application
		private function run():void {
			LOG(LOGGER.C_OP, 'run',0);
			// entry point
			app = new Application(this);
			app.set_localeId(ID_LOCALE_RUSSIAN);
			app.run();
		}
		
		
		//{ ======= id
		public static const ID_LOCALE_RUSSIAN:uint=1;
		public static const ID_LOCALE_ENGLISH:uint=0;
		//} ======= END OF id
		
		
		private var app:IApplication;
		//} ======= END OF run application
		
		
		
		//{ ======= view
		private function prepareView():void {
			LOG(LOGGER.C_OP, 'prepareView',0);
			
		}
		//} ======= END OF view
		
		
		
		//{ ======= control
		private function prepareControl():void {
			LOG(LOGGER.C_OP, 'prepareControl',0);
			
		}
		//} ======= END OF control
		
		
		
		//{ ======= data
		private function prepareData():void {
			LOG(LOGGER.C_OP, 'prepareData',0);
			
		}
		//} ======= END OF data
		
		
		
		//{ ======= network
		private function prepareNetwork():void {
			LOG(LOGGER.C_OP, 'prepareNetwork',0);
			
		}
		//} ======= END OF network
		
		
		
		//{ ======= console
		private function prepareConsole(appW:uint, appH:uint, consoleH:uint=400, consoleAlpha:Number=1, consoleBGAlpha:Number=.65):void {
			var cc:ConsoleConfig=new ConsoleConfig;
			cc.alwaysOnTop = true;
			cc.style.traceFontSize=18;
			cc.style.menuFontSize=18;
			cc.style.backgroundAlpha=consoleBGAlpha;
			c = new Console('`', cc);
			addChild(c);
			c.height=consoleH;c.width=appW;
			c.y=appH-consoleH;
			c.alpha = consoleAlpha;
		}
		public static var c:Console;
		//} ======= END OF console
		
		
		//{ ======= Logging
		private function prepareLogging():void {
			LOGGER.setL(logMessage);
			LOG_CL.push(
				new ConsoleChannel(LOGGER._CHANNEL_DISPLAY_NAMES[LOGGER.C_R], c)
				,new ConsoleChannel(LOGGER._CHANNEL_DISPLAY_NAMES[LOGGER.C_DT], c)
				,new ConsoleChannel(LOGGER._CHANNEL_DISPLAY_NAMES[LOGGER.C_DS], c)
				,new ConsoleChannel(LOGGER._CHANNEL_DISPLAY_NAMES[LOGGER.C_V], c)
				,new ConsoleChannel(LOGGER._CHANNEL_DISPLAY_NAMES[LOGGER.C_OP], c)
				,new ConsoleChannel(LOGGER._CHANNEL_DISPLAY_NAMES[LOGGER.C_NET], c)
				,new ConsoleChannel(LOGGER._CHANNEL_DISPLAY_NAMES[LOGGER.C_A], c)
			);
			
		}
		/**
		 * 
		 * @param	c channel id
		 * @param	a message
		 * @param	b level
		 */
		public function logMessage(c:uint, a:String, b:uint=0):void {
			var cc:ConsoleChannel=LOG_CL[c];
			if (!cc) {cc=LOG_CL[0];}
			
			switch (b) {
				
				case LOGGER.LEVEL_ERROR:
					cc.error(a);
					break;
					
				case LOGGER.LEVEL_WARNING:
					cc.warn(a);
					break;
					
				default:
				case LOGGER.LEVEL_INFO:
					cc.log(a);
					break;
					
			}
			
		}
		private static const LOG_CL:Vector.<ConsoleChannel>=new Vector.<ConsoleChannel>;
		//} ======= END OF Logging
		
	}
}
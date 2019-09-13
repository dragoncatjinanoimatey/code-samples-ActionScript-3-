package org.jinanoimateydragoncat.net {
	import flash.display.DisplayObject;
    import flash.events.*;
    import flash.net.*;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.utils.ByteArray;

    /**
	 * загрузка swf с других доменов в этот домен.
	 * Ликвидирует заморочки связанные с Security.allowDomain() ...etc
	 * @author Alekperov Samir
	 * @version 0.0.0
	 * @created 10.06.2010 18:23
	 */
	public class SwfLoader {
		
		/**
		 * 
		 * @param	path swf path
		 * @param	onComplete function(displayObject:DisplayObject):void
		 * @param	onInit function(displayObject:DisplayObject):void
		 * @param onError onError(errorMessage:String):void
		 * @param loadBytes load bytes instead
		 */
        public function SwfLoader(path:String, onInit:Function, onComplete:Function=null, onError:Function=null, loadBytes:ByteArray=null) {
			this.onError = onError;
			this.onInit = onInit;
			this.onComplete = onComplete;
			
			if (loadBytes) {
				completeHandler(null, loadBytes);
				return;
			}
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
            addListeners(loader);
			
			
			var request:URLRequest = new URLRequest(path);
			try {
				//var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, SecurityDomain.currentDomain);
				loader.load(request);
			} catch (error:Error) {
				onErrorMessage("Unable to load requested document."+ error);
			}
			
		}
		
		private function addListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            //dispatcher.addEventListener(Event.OPEN, openHandler);
            //dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            //dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }
        private function completeHandler(event:Event, bytes:ByteArray=null):void {
			if (!bytes) {
				var loader:URLLoader = URLLoader(event.target);
			}
			//trace0("completeHandler: " + loader.data);
			loader_ = new LoaderExample(bytes || loader.data, 
				function(swf:DisplayObject):void {
					if (onInit == null) {return;}
					onInit(swf);
				}, 
				function(swf:DisplayObject):void {
					if (onComplete == null) {return;}
					onComplete(swf);
				}, 
				function (msg:String):void {
					onErrorMessage('LoaderExample>'+ msg);
				}
			);
        }
        private function openHandler(event:Event):void {
            //trace0("openHandler: " + event);
        }
        private function progressHandler(event:ProgressEvent):void {
            //trace0("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
        }
        private function securityErrorHandler(event:SecurityErrorEvent):void {
            onErrorMessage("securityErrorHandler: " + event);
        }
        private function httpStatusHandler(event:HTTPStatusEvent):void {
            //trace0("httpStatusHandler: " + event);
        }
        private function ioErrorHandler(event:IOErrorEvent):void {
            onErrorMessage("ioErrorHandler: " + event);
        }
		private function onErrorMessage(errorMessage:String):void {
			if (onError == null) {return;}
			
			onError(errorMessage);
		}
		
		private var onComplete:Function;
		private var onInit:Function;
		private var onError:Function;
        private var loader_:LoaderExample;
	}
}




import flash.display.Loader;
import flash.events.*;
import flash.utils.ByteArray;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.system.SecurityDomain;
import flash.net.*;
	
class LoaderExample {
    public function LoaderExample(bytes:ByteArray, onInit:Function, onComplete:Function, onError:Function=null) {
        loader = new Loader();
        addListeners(loader.contentLoaderInfo);
		this.onError = onError;
		this.onInit = onInit;
		this.onComplete = onComplete;
        var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
        loader.loadBytes(bytes, context);
    }
	private var loader:Loader;
	private var onComplete:Function;
	private var onInit:Function;
	private var onError:Function;
    private function addListeners(dispatcher:IEventDispatcher):void {
        dispatcher.addEventListener(Event.COMPLETE, completeHandler,false,0,true);
        //dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
        dispatcher.addEventListener(Event.INIT, initHandler,false,0,true);
        dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler,false,0,true);
        //dispatcher.addEventListener(Event.OPEN, openHandler);
        //dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
        //dispatcher.addEventListener(Event.UNLOAD, unLoadHandler);
    }

    private function completeHandler(event:Event):void {
        //trace("completeHandler: " + event);
		if (onComplete == null){return;}
		onComplete(loader.content);
    }
    private function httpStatusHandler(event:HTTPStatusEvent):void {
        //trace("httpStatusHandler: " + event);
    }
    private function initHandler(event:Event):void {
        //trace("initHandler: " + event);
		if (loader.content!=null) {
			onInit(loader.content);
		} else {
			throw new Error('loader.content is null');
		}
    }
    private function ioErrorHandler(event:IOErrorEvent):void {
        onErrorMessage("ioErrorHandler: " + event);
    }
    private function openHandler(event:Event):void {
        //trace("openHandler: " + event);
    }
    private function progressHandler(event:ProgressEvent):void {
        //trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
    }
    private function unLoadHandler(event:Event):void {
        //trace("unLoadHandler: " + event);
    }
	private function onErrorMessage(errorMessage:String):void {
		if (onError == null) {return;}
		onError(errorMessage);
	}
}

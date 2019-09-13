package tk.jinanoimateydragoncat.utils.flow.data {
	
	//{ ======= import
	import flash.utils.Dictionary;
	//} ======= END OF import
	
	
	/**
	 * State Message (Short)
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * 
	 */
	public class JDSM implements IAM {
		
		//{ ======= CONSTRUCTOR
		public function JDSM (useStaticMethodInsteadOfConstrctor:String) {
			if (useStaticMethodInsteadOfConstrctor!=PROTECTION_KEY) {throw new ArgumentError('object pool - use static method instead of constrctor');}
			intV=[];
			stringV=[];
			booleanV=[];
		}
		
		protected function clearState():void {
			intV.splice(0, intV.length);// NOTE: replace .length with more faster solution
			stringV.splice(0, intV.length);// NOTE: replace .length with more faster solution
			booleanV.splice(0, intV.length);// NOTE: replace .length with more faster solution
		}
		/**
		 * return instance to pool
		 */
		public function freeInstance():void {
			if (isFree) {return;}
			r(this);//return to the object pool
		}
		//} ======= END OF CONSTRUCTOR
		
		public function get_intV(i:int):int {return intV[i];}
		public function set_intV(i:int, a:int):void {intV[i] = a;}
		public function get_stringV(i:int):String {return stringV[i];}
		public function set_stringV(i:int, a:String):void {stringV[i] = a;}
		public function get_booleanV(i:int):Boolean {return booleanV[i];}
		public function set_booleanV(i:int, a:Boolean):void {booleanV[i] = a;}
		
		private var intV:Array;
		private var stringV:Array;
		private var booleanV:Array;
		
		private var isFree:Boolean;
		
		
		//{ ======= ======= ObjectPool
		/**
		 * getInstance
		 */
		public static function getInstance():JDSM {
			var i:JDSM=pool[JDSM];
			if (!i) {i=new JDSM(PROTECTION_KEY);}
			
			var cd:Dictionary=poolNext[JDSM];
			if (!cd) {
				cd=new Dictionary();
				poolNext[JDSM]=cd;
			}
			
			pool[JDSM]=cd[i];
			cd[i]=null;
			
			i.clearState();
			i.isFree = false;
			return i;
		}
		
		/**
		 * returnInstance
		 */
		private static function r(i:JDSM):void {
			var c:Class=JDSM;
			
			var cd:Dictionary=poolNext[c];
			if (!cd) {
				cd=new Dictionary();
				poolNext[c]=cd;
			}
			cd[i]=pool[c];
			pool[c]=i;
			i.isFree = true;
		}
		
		/**
		 * d[classname]d[instance]=*
		 */
		private static var pool:Dictionary=new Dictionary();
		/**
		 * d[classname]=*
		 */
		private static var poolNext:Dictionary=new Dictionary();
		//} ======= ======= END OF ObjectPool		
		
		
		private static const PROTECTION_KEY:String='PROTECTION_KEY';
		
	}
}
package tk.jinanoimateydragoncat.utils.flow.data {
	
	//{ ======= import
	import flash.utils.Dictionary;
	//} ======= END OF import
	
	
	/**
	 * State Message (Full)
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * 
	 */
	public class JDAM extends JDSM implements IAM {
		
		//{ ======= CONSTRUCTOR
		public function JDAM (useStaticMethodInsteadOfConstrctor:String) {
			super(useStaticMethodInsteadOfConstrctor);
			if (useStaticMethodInsteadOfConstrctor!=PROTECTION_KEY) {throw new ArgumentError('object pool - use static method instead of constrctor');}
			
			objectV=[];
			arrayV=[];
		}
		
		protected override function clearState():void {
			super.clearState();
			objectV.splice(0, objectV.length);// NOTE: replace .length with more faster solution
			arrayV.splice(0, arrayV.length);// NOTE: replace .length with more faster solution
		}
		/**
		 * return instance to pool
		 */
		public override function freeInstance():void {
			if (isFree) {return;}
			r(this);//return to the object pool
		}
		//} ======= END OF CONSTRUCTOR
		
		public function get_objectV(i:int):Object {return objectV[i];}
		public function set_objectV(i:int, a:Object):void {objectV[i] = a;}
		public function get_arrayV(i:int):Array {return arrayV[i];}
		public function set_arrayV(i:int, a:Array):void {arrayV[i] = a;}
		private var objectV:Array;
		private var arrayV:Array;
		
		private var isFree:Boolean;
		
		//{ ======= ======= ObjectPool
		/**
		 * getInstance
		 */
		public static function getInstance():JDAM {
			var i:JDAM=pool[JDAM];
			if (!i) {i=new JDAM(PROTECTION_KEY);}
			
			var cd:Dictionary=poolNext[JDAM];
			if (!cd) {
				cd=new Dictionary();
				poolNext[JDAM]=cd;
			}
			
			pool[JDAM]=cd[i];
			cd[i]=null;
			
			i.clearState();
			i.isFree = false;
			return i;
		}
		
		/**
		 * returnInstance
		 */
		private static function r(i:JDAM):void {
			var c:Class=JDAM;
			
			var cd:Dictionary=poolNext[c];
			if (!cd) {
				cd=new Dictionary();
				poolNext[c]=cd;
			}
			cd[i]=pool[c];
			pool[c] = i;
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
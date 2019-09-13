// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.controller {
	
	//{ =^_^= import
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 18:39
	 */
	public class StartupCommand extends MacroCommand {
		
		//{ =^_^= CONSTRUCTOR
		
		function StartupCommand () {
		}
		//} =^_^= END OF CONSTRUCTOR
		
		override protected function initializeMacroCommand():void{
			addSubCommand(ModelPrepCommand);
			addSubCommand(ViewPrepCommand);
			addSubCommand(ControllerPrepCommand);
			//заполнение контентом
			addSubCommand(FillUIWithContentCommand);
		}
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]
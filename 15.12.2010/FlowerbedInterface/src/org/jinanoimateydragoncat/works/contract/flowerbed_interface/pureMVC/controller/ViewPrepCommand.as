// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.controller {
	
	//{ =^_^= import
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.main.UI;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.view.BookViewComponentMediator;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.view.ShopViewComponentMediator;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.view.StoreroomViewComponentMediator;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.pureMVC.view.VaseViewComponentMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	//} =^_^= END OF import
	
	
	/**
	 * Create and register Mediators with the View.
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 18:41
	 */
	public class ViewPrepCommand extends SimpleCommand {
		
		//{ =^_^= CONSTRUCTOR
		
		function ViewPrepCommand () {
		}
		//} =^_^= END OF CONSTRUCTOR
		
		override public function execute(note:INotification):void {
			var app:UI = note.getBody() as UI;
			
			facade.registerMediator(new BookViewComponentMediator(app.bookInterface));
			facade.registerMediator(new ShopViewComponentMediator(app.shopInterface));
			facade.registerMediator(new StoreroomViewComponentMediator(app.storeroomInterface));
			facade.registerMediator(new VaseViewComponentMediator(app.vaseInterface));
		}
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]
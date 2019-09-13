// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.alerts {
	
	//{ =^_^= import
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import org.aswing.*;
	import org.aswing.border.EmptyBorder;
	import org.aswing.colorchooser.*;
	import org.aswing.geom.IntRectangle;
	import org.aswing.plaf.DefaultEmptyDecoraterResource;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 17:20
	 */
	public class AlertImage extends JFrame {
		
		//{ =^_^= CONSTRUCTOR
		
		function AlertImage (title:String, image:DisplayObject) {
			super();
			
			setBackgroundDecorator(new SolidBackground(ASColor.LIGHT_GRAY));
			setSizeWH(image.width+50, image.height+70);
			
			getTitleBar().getCloseButton().setVisible(false);
			getTitleBar().getIconifiedButton().setVisible(false);
			getTitleBar().getMaximizeButton().setVisible(false);
			getTitleBar().getRestoreButton().setVisible(false);
			
			var button:JButton = new JButton("Ok")
			button.addActionListener(onOk);
			
			var img:AssetPane = new AssetPane(image, AssetPane.PREFER_SIZE_IMAGE);
			
			getContentPane().setLayout(new BorderLayout());
			getContentPane().append(img,BorderLayout.CENTER);
			getContentPane().append(button, BorderLayout.SOUTH);
			
			setTitle(title);
			show();
		}
		//} =^_^= END OF CONSTRUCTOR
		
		private function onOk(e:Event):void {
			//hide();
			parent.removeChild(this);
		}
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]
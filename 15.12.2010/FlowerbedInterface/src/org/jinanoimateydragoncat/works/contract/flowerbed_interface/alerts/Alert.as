// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.alerts {
	
	//{ =^_^= import
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
	 * @created 15.12.2010 17:21
	 */
	public class Alert extends JFrame {
		
		//{ =^_^= CONSTRUCTOR
		
		function Alert () {
			super();
			
			setBackgroundDecorator(new SolidBackground(ASColor.LIGHT_GRAY));
			setSizeWH(200, 130);
			
			getTitleBar().getCloseButton().setVisible(false);
			getTitleBar().getIconifiedButton().setVisible(false);
			getTitleBar().getMaximizeButton().setVisible(false);
			getTitleBar().getRestoreButton().setVisible(false);
			
			getContentPane().append(label,BorderLayout.CENTER);
			getContentPane().append(button, BorderLayout.SOUTH);
			
			button.addActionListener(onOk);
			
			var border1:EmptyBorder = new EmptyBorder();
			border1.setTop(0);
			border1.setLeft(50);
			border1.setBottom(5);
			border1.setRight(50);
			button.setBorder(border1);
			
		}
		//} =^_^= END OF CONSTRUCTOR
		
		public function alert(message:String, title:String = 'message'):void {
			setTitle(title);
			label.setText(message);
			show();
		}
		
		private function onOk(e:Event):void {
			hide();
		}
		
		private const label:JLabel = new JLabel();
		private const button:JButton = new JButton("Ok");
		
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]
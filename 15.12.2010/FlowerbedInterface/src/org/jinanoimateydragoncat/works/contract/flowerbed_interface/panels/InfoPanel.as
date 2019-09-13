// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.panels {
	
	//{ =^_^= import
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.text.UIText;
	
	import org.aswing.ASColor;
	import org.aswing.BoxLayout;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.SolidBackground;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 18:07
	 */
	public class InfoPanel extends JPanel {
		
		//{ =^_^= CONSTRUCTOR
		
		function InfoPanel () {
			super(new BoxLayout(BoxLayout.Y_AXIS));
			setBackgroundDecorator(new SolidBackground(ASColor.LIGHT_GRAY));
			append(levelText_);
			append(balanceText_);
			append(ratingText_);
			pack();
		}
		//} =^_^= END OF CONSTRUCTOR
		
		/**
		 * уровень игрока
		 */
		public function set levelText(a:String):void {
			levelText_.setText(UIText.TEXT_INFO_LEVEL+ a);
		}
		/**
		 * баланс игрока
		 */
		public function set balanceText(a:String):void {
			balanceText_.setText(UIText.TEXT_INFO_BALANCE+ a);
		}
		/**
		 * оценка посетителей
		 */
		public function set ratingText(a:String):void {
			ratingText_.setText(UIText.TEXT_INFO_RATING+ a);
		}
		
		private const levelText_:JLabel = new JLabel(UIText.TEXT_INFO_LEVEL+'999999',null,JLabel.LEFT);
		private const balanceText_:JLabel = new JLabel(UIText.TEXT_INFO_BALANCE+'999999',null,JLabel.LEFT);
		private const ratingText_:JLabel = new JLabel(UIText.TEXT_INFO_RATING+'999999',null,JLabel.LEFT);
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]
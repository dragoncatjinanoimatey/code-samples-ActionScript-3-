// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface {
	
	//{ =^_^= import
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.text.UIText;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.lib.UILibrary;
	import org.jinanoimateydragoncat.works.contract.flowerbed_interface.data.UISettings;
	
	import org.aswing.AssetPane;
	import org.aswing.border.LineBorder;
	import org.aswing.BoxLayout;
	import org.aswing.event.SelectionEvent;
	import org.aswing.FlowLayout;
	import org.aswing.JLabel;
	import org.aswing.JList;
	import org.aswing.JScrollPane;
	import org.aswing.JTextArea;
	import org.aswing.JTextField;
	import org.aswing.VectorListModel;
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.BorderLayout;
	import org.aswing.colorchooser.ColorRectIcon;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JPanel;
	import org.aswing.JTabbedPane;
	//} =^_^= END OF import
	
	
	/**
	 * интерфейс "книга"
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 18:14
	 */
	public class GUIBook extends JFrame {
		
		//{ =^_^= CONSTRUCTOR
		
		function GUIBook () {
			super(null, UIText.TEXT_BOOK);
			setResizable(false);
			
			// картинка+список
			var leftBlock:JPanel = new JPanel(new BorderLayout(0,5));
			
			image.setPreferredWidth(UISettings.XMLData.GUIBook.image.@setPreferredWidth);//ширина картинки
			image.setPreferredHeight(UISettings.XMLData.GUIBook.image.@setPreferredHeight);
			leftBlock.append(image,BorderLayout.NORTH);
			
			list.setPreferredHeight(UISettings.XMLData.GUIBook.list.@setPreferredHeight);//высота списка
			list.setSelectionMode(JList.SINGLE_SELECTION);
			list.addSelectionListener(selectedListener);
			
			var scrollPane:JScrollPane = new JScrollPane(list);
			scrollPane.setBorder(new LineBorder());
			leftBlock.append(scrollPane,BorderLayout.SOUTH);
			
			// текстовое описание
			var rightBlock:JPanel = new JPanel(new BorderLayout());
			
			textName.setEditable(false);
			textName.setBackground(new ASColor(0, 0));
			
			textDescription.setEditable(false);
			textDescription.setPreferredWidth(UISettings.XMLData.GUIBook.textDescription.@setPreferredWidth);
			textDescription.setPreferredHeight(UISettings.XMLData.GUIBook.textDescription.@setPreferredHeight);
			textDescription.setBackground(new ASColor(0, 0));
			
			scrollPane = new JScrollPane(textDescription); 
			rightBlock.append(textName,BorderLayout.NORTH);
			rightBlock.append(scrollPane,BorderLayout.SOUTH);
			
			getContentPane().setLayout(new FlowLayout());
			getContentPane().append(leftBlock);
			getContentPane().append(rightBlock);
			pack();
			
			//show();
		}
		//} =^_^= END OF CONSTRUCTOR
		
		/**
		 * установка данных для списка
		 * @param	title элемента
		 * @param	description описание
		 * @param	bitmapData картинка
		 */
		public function setListData(title:Array,description:Array,bitmapData:Array):void {
			titleList = title;
			bitmapDataList = bitmapData;
			descriptionList = description;
			list.setListData(title);
			list.setSelectedIndex(0);
		}
		
		/**
		 * отбражает описание текущего элемента
		 */
		public function set currentItem(a:uint):void {
			if (descriptionList.length < 1) {return;}
			textDescription.setText(descriptionList[a]);
			textName.setText(titleList[a]);
			image.setAsset(new Bitmap(bitmapDataList[a]));
		}
		
		
		private function selectedListener(e:SelectionEvent):void {
			currentItem = e.getFirstIndex();
		}
		
		private const list:JList = new JList();
		
		private const textName:JTextField = new JTextField('Название');
		private const textDescription:JTextArea = new JTextArea('Описание');
		
		//любая картинка для инициализации
		private const image:AssetPane = new AssetPane(new Bitmap(new BitmapData(10,10,false,0x00AA00)));
		
		private var titleList:Array;
		private var descriptionList:Array;
		private var bitmapDataList:Array;
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]
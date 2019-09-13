// Project FlowerbedInterface
package org.jinanoimateydragoncat.works.contract.flowerbed_interface.data {
	
	//{ =^_^= import
	//} =^_^= END OF import
	
	
	/**
	 *  Настройки
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 15.12.2010 17:25
	 */
	public class UISettings {
		
		//{ =^_^= CONSTRUCTOR
		
		function UISettings () {
			throw new ArgumentError("Static container only.");
		}
		//} =^_^= END OF CONSTRUCTOR
		
		public static const XMLData:XML = 
		<settings>
			//интерфейс "Книга"
			<GUIBook>
				//ширина и высота картинки
				<image setPreferredWidth="100" setPreferredHeight="100"/>
				//высота списка
				<list setPreferredHeight="200"/>
				//ширина и высота описания
				<textDescription setPreferredWidth="400" setPreferredHeight="300"/>
			</GUIBook>
			
			//интерфейс "Ваза"
			<GUIVase>
				// список фрагментов
				<rightBlock setPreferredWidth="200" setPreferredHeight="400">
					// кнопки управления вазой
					<vaseViewportControls>
						<button width='30' height='30'/>
					</vaseViewportControls>	
					//список фрагментов
					<elementsList>
						<element setPreferredWidth="150" setPreferredHeight="150">
							<button setPreferredWidth="150" setPreferredHeight="20"/>
						</element>
					</elementsList>
					//кнопка "продолжить"
					<buttonDone setPreferredHeight="20"/>
				</rightBlock>
				// область сбора букета
				<leftBlock setPreferredWidth="400" setPreferredHeight="400"/>
			</GUIVase>
			//интерфейс "Магазин"
			//setHeight - высота окна
			<GUIShop setHeight="270">
			</GUIShop>
		</settings>;
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]
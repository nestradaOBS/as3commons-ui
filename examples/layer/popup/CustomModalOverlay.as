package layer.popup {
	import layer.popup.common.AlertBox;
	import com.sibirjak.asdpc.button.Button;
	import com.sibirjak.asdpc.button.ButtonEvent;
	import org.as3commons.ui.layer.PopUpManager;
	import flash.display.Sprite;
	import flash.events.Event;

	public class CustomModalOverlay extends Sprite {
		private var _popUpManager : PopUpManager;
		private var _addButton : Button;
		
		public function CustomModalOverlay() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var container : Sprite = stage.addChild(new Sprite()) as Sprite;
			_popUpManager = new PopUpManager(container);
			_popUpManager.modalOverlay = ModalOverlay;

			_addButton = new Button();
			_addButton.setSize(50, 20);
			_addButton.label = "add";
			_addButton.addEventListener(ButtonEvent.CLICK, addHandler);
			addChild(_addButton);
		}
		
		private function addHandler(event : ButtonEvent) : void {
			var alert : AlertBox = new AlertBox(
				"Modal Popup",
				"This is a modal popup window. Close this window by clicking the close button.",
				[null, null, "Close"],
				removePopUp
			);
			_popUpManager.createPopUp(alert, true, true);
		}
		
		private function removePopUp(alert : AlertBox, event : String) : void {
			_popUpManager.removePopUp(alert);
			_addButton.selected = false;
		}
	}
}

import flash.display.Sprite;

internal class ModalOverlay extends Sprite {
	public function ModalOverlay() {
		with (graphics) {
			clear();
			beginFill(0x000000, .3);
			drawRect(0, 0, 100, 100);
		}
	}
}
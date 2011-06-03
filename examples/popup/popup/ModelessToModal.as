package popup.popup {
	import com.sibirjak.asdpcbeta.window.Window;
	import com.sibirjak.asdpcbeta.window.WindowEvent;
	import org.as3commons.ui.popup.PopUpManager;
	import flash.display.Sprite;
	import flash.events.Event;

	public class ModelessToModal extends ControlPanelBase {
		private var _popUpManager : PopUpManager;
		private var _windowId : uint;
		private var _startPosition : uint;

		public function ModelessToModal() {
			var container : Sprite = stage.addChild(new Sprite()) as Sprite;
			_popUpManager = new PopUpManager(container);

			addChild(
				labelButton({
					label: "add",
					click: addHandler
				})
			);
		}
		
		private function addHandler() : void {
			_startPosition += 30;
			if (_startPosition > 170) _startPosition = 30;

			var window : Window = window({
				x: _startPosition * 2, y: _startPosition, w: 200, h: 120,
				title: "PopUp " + ++_windowId,
				minimised: true
			});
			window.document = new WinContent();
			window.addEventListener("modal", modalHandler);
			window.addEventListener("modeless", modelessHandler);
			window.addEventListener(WindowEvent.MINIMISED, minimiseHandler);
			
			_popUpManager.createPopUp(window);
			window.restore();
		}

		private function modalHandler(event : Event) : void {
			_popUpManager.makeModal(event.currentTarget as Window);
		}
		
		private function modelessHandler(event : Event) : void {
			_popUpManager.makeModeless(event.currentTarget as Window);
		}
		
		private function minimiseHandler(event : WindowEvent) : void {
			var window : Window = event.currentTarget as Window;
			window.removeEventListener("modal", modalHandler);
			window.removeEventListener("modeless", modelessHandler);
			window.removeEventListener(WindowEvent.MINIMISED, minimiseHandler);
			_popUpManager.removePopUp(window);
		}
	}
}

import com.sibirjak.asdpcbeta.window.Window;
import org.as3commons.ui.layout.constants.Align;
import org.as3commons.ui.layout.shortcut.vgroup;
import flash.events.Event;

internal class WinContent extends ControlPanelBase {
	override protected function draw() : void {
		vgroup(
			"minWidth", _width, "minHeight", _height - 5,
			"marginX", 5, "vAlign", Align.BOTTOM, "gap", 5,
			labelButton({
				toggle: true,
				label: "modal",
				selectedlabel: "modeless",
				change: function(selected : Boolean) : void {
					if (selected) dispatchEvent(new Event("modal", true));
					else dispatchEvent(new Event("modeless", true));
				}
			}),
			labelButton({
				label: "close",
				click: function() : void {
					Window(parent).minimise();
				}
			})
		).layout(this);
	}
}
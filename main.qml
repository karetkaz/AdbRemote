import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Window 2.10
import Process 1.0

Window {
	id: window
	width: 300
	height: 340
	visible: true
	title: 'Adb remote'

	TextField {
		id: txtSend
		width: parent.width
		placeholderText: "send text or key"
		onAccepted: process.start(["shell", "input", "text", '"' + txtSend.text + '"']);
	}

	DropArea {
		enabled: true
		anchors.fill: parent
		onDropped: if (drop.urls && drop.urls.length > 0) {
			for (let url of drop.urls) {
				if (url.endsWith('.apk')) {
					process.start(["install", url.replace(/^file:\/\//, '')]);
				} else {
					process.start(["push", url.replace(/^file:\/\//, ''), "/sdcard/Download/"]);
				}
			}
		}
	}

	GridLayout {
		id: buttonGrid
		width: parent.width
		anchors.top: txtSend.bottom
		rows: 4
		rowSpacing: 0
		columns: 3
		columnSpacing: 0

		ComboBox {
			id: customAction
			Layout.fillWidth: true
			Layout.columnSpan: 2
			textRole: 'text'
			model: [
				{text: "Connect", args: ["connect", txtSend.text]},
				{text: "KillServer", args: ["kill-server"]},
				{text: "SendEnter", args: ["shell", "input", "keyevent", '66']},
				{text: "SendText", args: ["shell", "input", "text", '"' + txtSend.text + '"']},
				{text: "SendKey", args: ["shell", "input", "keyevent", '"' + txtSend.text + '"']},
			]
		}
		Button {
			text: "Execute";
			Layout.fillWidth: true
			onClicked: process.start(customAction.model[customAction.currentIndex].args);
		}
		Button {
			text: "⤺";
			Layout.fillWidth: true
			onClicked: process.startDetached(["shell", "input", "keyevent", '4']);
		}
		Button {
			text: "⬆";
			Layout.fillWidth: true
			onClicked: process.startDetached(["shell", "input", "keyevent", '19']);
		}
		Button {
			text: "🏠";
			Layout.fillWidth: true
			onClicked: process.startDetached(["shell", "input", "keyevent", '3']);
		}
		Button {
			text: "⬅";
			Layout.fillWidth: true
			onClicked: process.startDetached(["shell", "input", "keyevent", '21']);
		}
		Button {
			text: 'OK'
			Layout.fillWidth: true
			onClicked: process.startDetached(["shell", "input", "keyevent", '23']);
		}
		Button {
			text: "➡";
			Layout.fillWidth: true
			onClicked: process.startDetached(["shell", "input", "keyevent", '22']);
		}
		Button {
			text: "Settings";
			Layout.fillWidth: true
			onClicked: process.start(['shell', 'am', 'start', '-a', 'android.settings.SETTINGS']);
		}
		Button {
			text: "⬇";
			Layout.fillWidth: true
			onClicked: process.startDetached(["shell", "input", "keyevent", '20']);
		}
		Button {
			text: 'Clear'
			Layout.fillWidth: true
			onClicked: logger.clear();
		}
	}

	ListView {
		width: parent.width
		boundsBehavior: Flickable.StopAtBounds
		flickableDirection: Flickable.HorizontalAndVerticalFlick
		anchors.top: buttonGrid.bottom
		anchors.bottom: parent.bottom

		clip: true
		model: logger
		delegate: Text {
			function toSeconds(time, pad) {
				var result = (time / 1000).toFixed(2);
				while (result.length < pad + 3) {
					result = '0' + result;
				}
				return result;
			}
			font.pointSize: 9
			color: model.color || "black"
			text: '[@' + toSeconds(model.time, 4) + ']: ' + model.text + (model.elapsed < 0 ? '' : ' completed in: ' + toSeconds(model.elapsed) + ' seconds')
		}
	}

	ListModel {
		id: logger
		function log(message) {
			this.insert(0, { time: -1, text: message, elapsed: -1, color: "gray" });
		}
	}

	Process {
		id: process
		program: "adb"
		onStarting: logger.log("Starting: " + program + ' ' + args.join(' '))
		onAboutToClose: logger.log("AboutToClose: ")
		onErrorOccurred: logger.log("onErrorOccurred: ")
		onFinished: logger.log("finished: " + readAll());
	}
}

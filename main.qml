import QtQuick.Controls.Material
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import Process

Window {
	width: 340
	height: 700
	visible: true
	title: 'Adb remote'

	property int dividerHeigth: customAction.height / 3

	DropArea {
		enabled: true
		anchors.fill: parent
		onDropped: (args) => {
			if (args.urls && args.urls.length > 0) {
				for (let url of args.urls) {
					let file = url.toString();
					if (file.endsWith('.apk')) {
						adb.start(["install", file.replace(/^file:\/\//, '')]);
					} else {
						adb.start(["push", file.replace(/^file:\/\//, ''), "/sdcard/Download/"]);
					}
				}
			}
		}
	}

	TextField {
		id: txtSend
		width: parent.width
		padding: 5
		placeholderText: "send text or key"
		onAccepted: customAction.exec();
	}

	GridLayout {
		id: buttonGrid
		width: parent.width
		anchors.top: txtSend.bottom
		rows: 4
		rowSpacing: 0
		columns: 3
		columnSpacing: 0
		uniformCellWidths: true


		ComboBox {
			id: customAction
			Layout.fillWidth: true
			Layout.columnSpan: 2
			textRole: 'text'
			onCurrentIndexChanged: if (txtSend.text === '') {
				txtSend.text = model[currentIndex].hint || ''
			}
			model: [{
				text: "KillServer",
				exec: ["kill-server"]
			}, {
				text: "Connect",
				hint: "192.168.1.",
				execInput: ["connect"]
			}, {
				text: "Open Settings",
				exec: ["shell", "am", "start", '-a', 'android.settings.SETTINGS']
			}, {
				text: "SendText",
				execInputEsc: ["shell", "input", "text"]
			}, {
				text: "SendKey",
				execInput: ["shell", "input", "keyevent"]
			}, {
				text: "SendEnter", // KEYCODE_ENTER = 66;
				exec: ["shell", "input", "keyevent", '66']
			}]
			
			function exec() {
				if (model[currentIndex].execInputEsc != null) {
					adb.start([...model[currentIndex].execInputEsc, "\'" + txtSend.text + "\'"]);
					return;
				}
				if (model[currentIndex].execInput != null) {
					adb.start([...model[currentIndex].execInput, txtSend.text]);
					return;
				}
				if (model[currentIndex].exec != null) {
					adb.start(model[currentIndex].exec);
					return;
				}
				
			}
		}
		Button {
			text: "Execute";
			Layout.fillWidth: true
			onClicked: customAction.exec();
		}

		Repeater {model: 3; delegate: Rectangle {height: dividerHeigth}}

		//media controls: ▶ ⏵ ⏸ ⏯ ⏹ ⏺ ⏏ ⏪ ⏮ ⏩ ⏭
		Button {
			text: "⏮";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "keyevent", '89']);
		}
		Button {
			text: "⏯";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "keyevent", '85']);
		}
		Button {
			text: "⏭";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "keyevent", '90']);
		}

		Button {
			text: "🔙";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "keyevent", '4']);
		}
		Button {
			text: "⏹";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "keyevent", '86']);
		}
		Button {
			text: "🏠";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "keyevent", '3']);
		}

		Repeater {model: 3; delegate: Rectangle {height: dividerHeigth}}

		Button {
			text: "ch-";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "keyevent", 167]);
		}
		Button {
			text: "⬆";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "keyevent", '19']);
		}
		Button {
			text: "ch+";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "keyevent", 166]);
		}


		Button {
			text: "⬅";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "keyevent", '21']);
		}
		Button {
			text: 'OK'
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "keyevent", '23']);
		}
		Button {
			text: "➡";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "keyevent", '22']);
		}

		Button {
			text: "rec";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "keyevent", '130']);
		}
		Button {
			text: "⬇";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "keyevent", '20']);
		}
		Button {
			text: "sub";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "keyevent", '175']);
		}

		Repeater {model: 3; delegate: Rectangle {height: dividerHeigth}}

		Button {
			text: "1";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "text", text]);
		}
		Button {
			text: "2";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "text", text]);
		}
		Button {
			text: "3";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "text", text]);
		}

		Button {
			text: "4";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "text", text]);
		}
		Button {
			text: "5";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "text", text]);
		}
		Button {
			text: "6";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "text", text]);
		}

		Button {
			text: "7";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "text", text]);
		}
		Button {
			text: "8";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "text", text]);
		}
		Button {
			text: "9";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "text", text]);
		}

		Rectangle {}
		Button {
			text: "0";
			Layout.fillWidth: true
			onClicked: adb.startDetached(["shell", "input", "text", text]);
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
		id: adb
		program: "adb"
		onStarting: (program, args) => logger.log("Starting: " + program + ' ' + args.join(' '))
		onAboutToClose: logger.log("AboutToClose: ")
		onErrorOccurred: (error) => {
			logger.log("onErrorOccurred: " + error)
		}
		onFinished: logger.log("finished: " + readAll());
	}

	Component.onCompleted: {
		customAction.currentIndex = 2
	}
}

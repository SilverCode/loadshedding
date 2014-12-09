import QtQuick 1.0

Rectangle {
    id: mainWindow;
    visible: true
    width: 360
    height: 260
    property int loadSheddingState: 0

    onLoadSheddingStateChanged: {
        if (loadSheddingState == 1) {
            mainWindow.color = "Green";
            text.text = "No Loadshedding";
        } else if (loadSheddingState == 2) {
            mainWindow.color = "orange";
            text.text = "Stage 1";
        } else if (loadSheddingState == 3) {
            mainWindow.color = "red"
            text.text = "Stage 2";
        } else if (loadSheddingState == 4) {
            mainWindow.color = "Stage 3";
            text.text = "Stage 3";
        } else if (loadSheddingState == 5) {
            mainWindow.color = "black";
            text.text = "Stage 4";
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }

    Timer {
        id: timer
        interval: 5 * 60 * 1000
        running: true
        repeat: true
        onTriggered: request()
    }

    Text {
        id: text
        font.family: "Arial"
        font.pointSize: 20
        text: qsTr("Unknown")
        anchors.centerIn: parent
    }

    function request() {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            } else if (xhr.readyState === XMLHttpRequest.DONE) {
                var data = xhr.responseText.toString();
                loadSheddingState = parseInt(data);
            }
        }
        xhr.open("GET", "http://loadshedding.eskom.co.za/LoadShedding/GetStatus");
        xhr.send();
    }

    Component.onCompleted: {
        request();
    }
}

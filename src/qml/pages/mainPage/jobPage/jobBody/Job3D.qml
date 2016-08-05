import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import DarkStyle.Controls 1.0
import DarkStyle 1.0
import Meshroom.GL 0.1

Item {
    Menu {
        id: menu

        ExclusiveGroup { id: selectionModeGroup }

        MenuItem {
            text: "Select plane"
            exclusiveGroup: selectionModeGroup
            checkable: true
            checked: true
            onCheckedChanged: if (checked) glview.selectionMode = GLView.RECTANGLE
        }

        MenuItem {
            text: "Select line"
            exclusiveGroup: selectionModeGroup
            checkable: true
            onCheckedChanged: if (checked) glview.selectionMode = GLView.LINE
        }

        MenuSeparator {}

        MenuItem {
            text: "Define ground plane"
            onTriggered: glview.definePlane()
        }
        MenuItem {
            text: "Flip plane normal"
            onTriggered: glview.flipPlaneNormal()
        }
        MenuItem {
            text: "Clear plane"
            onTriggered: glview.clearPlane()
        }

        MenuSeparator {}

        MenuItem {
            text: "Define scale"
        }
        MenuItem {
            text: "Reset scale"
        }
    }

    DropArea {
        anchors.fill: parent
        hideBackground: true
        onDropped: glview.loadAlembicScene(drop.urls[0])
        GLView {
            id: glview
            anchors.fill: parent
            color: "#333"
            property variant job: currentJob
            onJobChanged: glview.loadAlembicScene(Qt.resolvedUrl(currentJob.url+"/"+currentJob.name+".abc"))
            onOpenPopup: menu.popup()
        }
    }
    Connections {
        target: _applicationWindow
        onShowCameras: {
            glview.showCameras = checked
        }
        onShowGrid: {
            glview.showGrid = checked
        }
    }
}
import QtQuick 2.15
import SddmComponents 2.0

Rectangle {
    id: root

    width: 1920
    height: 1080
    color: "#1e222a"

    readonly property color textColor: "#eceff4"
    readonly property color mutedColor: "#aab1c0"
    readonly property color accentColor: "#88c0d0"
    readonly property color cardColor: "#2e3440"
    readonly property color fieldColor: "#3b4252"
    readonly property color borderColor: "#4c566a"

    TextConstants {
        id: textConstants
    }

    Background {
        anchors.fill: parent
        source: Qt.resolvedUrl(config.Background || "wallpaper.png")
        fillMode: Image.PreserveAspectCrop
    }

    Rectangle {
        anchors.fill: parent
        color: "#40000000"
    }

    Clock {
        id: clock

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.11

        color: root.textColor
        timeFont.pointSize: 64
        dateFont.pointSize: 20
    }

    Rectangle {
        id: card

        width: 380
        height: loginColumn.implicitHeight + 56
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 70
        radius: 12

        color: root.cardColor
        opacity: 0.95
        border.color: root.borderColor
        border.width: 1

        Column {
            id: loginColumn

            anchors.centerIn: parent
            width: parent.width - 48
            spacing: 12

            Text {
                width: parent.width
                text: textConstants.welcomeText.arg(sddm.hostName)
                color: root.textColor
                font.pointSize: 15
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                elide: Text.ElideRight
            }

            Text {
                width: parent.width
                text: textConstants.userName
                color: root.mutedColor
                font.pointSize: 10
            }

            TextBox {
                id: userName

                width: parent.width
                height: 36

                text: userModel.lastUser
                color: root.fieldColor
                textColor: root.textColor
                borderColor: root.borderColor
                focusColor: root.accentColor
                hoverColor: root.accentColor
                font.pointSize: 12
            }

            Text {
                width: parent.width
                text: textConstants.password
                color: root.mutedColor
                font.pointSize: 10
            }

            PasswordBox {
                id: password

                width: parent.width
                height: 36

                color: root.fieldColor
                textColor: root.textColor
                borderColor: root.borderColor
                focusColor: root.accentColor
                hoverColor: root.accentColor
                font.pointSize: 12

                Keys.onReturnPressed: loginButton.clicked()
                Keys.onEnterPressed: loginButton.clicked()
            }

            Text {
                width: parent.width
                text: textConstants.session
                color: root.mutedColor
                font.pointSize: 10
            }

            ComboBox {
                id: session

                width: parent.width
                height: 36

                model: sessionModel
                index: sessionModel.lastIndex
                color: root.fieldColor
                menuColor: root.fieldColor
                textColor: root.textColor
                borderColor: root.borderColor
                focusColor: root.accentColor
                hoverColor: root.accentColor
                font.pointSize: 12
            }

            Button {
                id: loginButton

                width: parent.width
                height: 38

                text: textConstants.login
                textColor: root.textColor
                font.pointSize: 12

                onClicked: sddm.login(userName.text, password.text, session.index)
            }

            Text {
                id: errorText

                width: parent.width
                text: ""
                color: "#bf616a"
                font.pointSize: 10
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }
        }
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 28
        spacing: 20

        Button {
            width: 110
            height: 32
            text: textConstants.reboot
            textColor: root.textColor
            onClicked: sddm.reboot()
        }

        Button {
            width: 110
            height: 32
            text: textConstants.shutdown
            textColor: root.textColor
            onClicked: sddm.powerOff()
        }

        Button {
            width: 110
            height: 32
            text: textConstants.suspend
            textColor: root.textColor
            onClicked: sddm.suspend()
        }
    }

    Connections {
        target: sddm

        function onLoginFailed() {
            errorText.text = textConstants.loginFailed
            password.text = ""
            password.forceActiveFocus()
        }

        function onLoginSucceeded() {
            errorText.text = ""
        }
    }

    Component.onCompleted: {
        if (userName.text.length > 0)
            password.forceActiveFocus()
        else
            userName.forceActiveFocus()
    }
}

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs.core

Flickable {
    id: root

    required property var agentModel
    contentWidth: width
    contentHeight: content.implicitHeight
    clip: true

    component ToggleCard: Rectangle {
        id: toggleCard

        required property string title
        required property string detail
        required property bool checked
        signal toggled

        Layout.fillWidth: true
        Layout.preferredHeight: Math.max(64, toggleContent.implicitHeight + Theme.spacingLg * 2)
        color: Theme.controlNormalFill
        border.color: Theme.controlNormalBorder
        border.width: Theme.controlBorderWidth
        radius: Theme.controlRadius

        RowLayout {
            id: toggleContent
            anchors.fill: parent
            anchors.margins: Theme.spacingLg
            spacing: Theme.spacingLg

            ColumnLayout {
                Layout.fillWidth: true
                spacing: Theme.spacingXs

                UiText {
                    Layout.fillWidth: true
                    text: toggleCard.title
                    color: Theme.controlNormalText
                    font.bold: true
                    wrapMode: Text.WordWrap
                }

                UiText {
                    Layout.fillWidth: true
                    text: toggleCard.detail
                    color: Theme.menuMutedText
                    wrapMode: Text.WordWrap
                }
            }

            PanelToggleSwitch {
                checked: toggleCard.checked
                busy: root.agentModel.busy
                accessibleName: toggleCard.title
                accessibleDescription: toggleCard.detail
                onToggled: toggleCard.toggled()
            }
        }
    }

    component Badge: Rectangle {
        id: badge

        required property string label
        required property color stateColor

        implicitWidth: badgeText.implicitWidth + (Theme.controlPaddingX * 2)
        implicitHeight: Theme.pillHeight
        color: Theme.transparent
        border.color: badge.stateColor
        border.width: Theme.controlBorderWidth
        radius: Theme.pillRadius

        UiText {
            id: badgeText
            anchors.centerIn: parent
            text: badge.label.toUpperCase()
            color: badge.stateColor
            font.pixelSize: Theme.fontCaptionSize
            font.bold: true
        }
    }

    ColumnLayout {
        id: content
        width: root.width
        spacing: Theme.spacingLg

        RowLayout {
            Layout.fillWidth: true
            UiText {
                Layout.fillWidth: true
                text: "Choose Diagnose with AI on a notification to open your default agent"
                color: Theme.menuMutedText
                elide: Text.ElideRight
            }
            ShellButton {
                label: root.agentModel.busy ? "Applying..." : "Refresh"
                enabled: !root.agentModel.busy
                onActivated: root.agentModel.refresh()
            }
        }

        UiText {
            Layout.fillWidth: true
            visible: root.agentModel.message.length > 0
            text: root.agentModel.message
            color: Theme.danger
            wrapMode: Text.WordWrap
        }

        SectionLabel { label: "Alerts" }

        ToggleCard {
            title: "Crash notifications"
            detail: "Tell me when one of my programs crashes and offer to diagnose it."
            checked: root.agentModel.crashNotifications
            onToggled: root.agentModel.setToggle("crash-notifications", !root.agentModel.crashNotifications)
        }

        ToggleCard {
            title: "Hang detection"
            detail: "dwm checks every few seconds that windows still answer and tells you when one stops for 10 seconds. "
                + "Games, virtual machines and apps that are busy on purpose can show up as not responding when they are fine."
            checked: root.agentModel.hangDetection
            onToggled: root.agentModel.setToggle("hang-detection", !root.agentModel.hangDetection)
        }
    }
}

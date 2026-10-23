
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root

    width: 900
    height: 600
    minimumWidth: 700
    minimumHeight: 450
    visible: true
    title: "Troubleshooter"
    color: "#FFFFFF"

    property string currentPage: "Home"
    property string statusMessage: ""

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // Sidebar
        Rectangle {
            Layout.preferredWidth: 220
            Layout.fillHeight: true
            color: "#F7F8FA"

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 14
                spacing: 12

                Text {
                    text: "Troubleshooter"
                    font.pixelSize: 19
                    font.bold: true
                    color: "#172033"
                    Layout.leftMargin: 6
                    Layout.topMargin: 8
                    Layout.bottomMargin: 12
                }

                Button {
                    text: "+   New chat"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 42

                    onClicked: {
                        root.currentPage = "Home"
                        issueInput.clear()
                        root.statusMessage = ""
                    }

                    background: Rectangle {
                        radius: 8
                        color: parent.down ? "#DCE8FC" : "#E8EFFB"
                    }

                    contentItem: Text {
                        text: parent.text
                        color: "#2459A9"
                        font.pixelSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Text {
                    text: "PAST CHATS"
                    color: "#8993A4"
                    font.pixelSize: 11
                    font.bold: true
                    Layout.leftMargin: 8
                    Layout.topMargin: 14
                }

                // Placeholder chat history
                Repeater {
                    model: ["Wi-Fi issue", "Slow PC", "Printer problem"]

                    delegate: ItemDelegate {
                        required property string modelData
                        Layout.fillWidth: true
                        Layout.preferredHeight: 38
                        text: modelData

                        background: Rectangle {
                            radius: 7
                            color: parent.hovered ? "#E9EDF3" : "transparent"
                        }

                        contentItem: Text {
                            text: parent.text
                            color: "#465267"
                            font.pixelSize: 13
                            elide: Text.ElideRight
                            verticalAlignment: Text.AlignVCenter
                        }

                        onClicked: {
                            root.currentPage = "Home"
                            issueInput.text = modelData
                            root.statusMessage =
                                "Previous conversation selected: " + modelData
                        }
                    }
                }

                Item {
                    Layout.fillHeight: true
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: "#E1E5EB"
                }

                // Bottom navigation
                Repeater {
                    model: [
                        {label: "Settings", symbol: "⚙"},
                        {label: "Login", symbol: "⇥"}
                    ]

                    delegate: ItemDelegate {
                        required property var modelData
                        Layout.fillWidth: true
                        Layout.preferredHeight: 42

                        contentItem: RowLayout {
                            spacing: 12

                            Text {
                                text: modelData.symbol
                                color: "#586579"
                                font.pixelSize: 18
                            }

                            Text {
                                text: modelData.label
                                color: "#344054"
                                font.pixelSize: 14
                                Layout.fillWidth: true
                            }
                        }

                        background: Rectangle {
                            radius: 8
                            color: parent.hovered ? "#E9EDF3" : "transparent"
                        }

                        onClicked: {
                            root.currentPage = modelData.label
                            root.statusMessage = ""
                        }
                    }
                }
            }
        }

        // Main content
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ColumnLayout {
                anchors.centerIn: parent
                width: Math.min(parent.width - 48, 460)
                spacing: 18
                visible: root.currentPage === "Home"

                Text {
                    text: "What can I help you fix?"
                    font.pixelSize: 27
                    font.bold: true
                    color: "#172033"
                    Layout.alignment: Qt.AlignHCenter
                }

                TextField {
                    id: issueInput
                    Layout.fillWidth: true
                    Layout.preferredHeight: 52
                    placeholderText: "Describe your problem..."
                    font.pixelSize: 15
                    leftPadding: 16
                    rightPadding: 16
                    selectByMouse: true

                    background: Rectangle {
                        radius: 11
                        color: "#FFFFFF"
                        border.color: issueInput.activeFocus
                                      ? "#3B82F6" : "#D9E1EC"
                        border.width: issueInput.activeFocus ? 2 : 1
                    }

                    onAccepted: diagnoseButton.clicked()
                }

                Button {
                    id: diagnoseButton
                    text: "Diagnose"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 44

                    onClicked: {
                        if (issueInput.text.trim().length > 0)
                            root.statusMessage =
                                "Ready to diagnose: " + issueInput.text.trim()
                        else
                            root.statusMessage = "Please describe your problem."
                    }

                    contentItem: Text {
                        text: diagnoseButton.text
                        color: "white"
                        font.pixelSize: 14
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    background: Rectangle {
                        radius: 9
                        color: diagnoseButton.down ? "#1D4ED8" : "#2563EB"
                    }
                }

                Text {
                    text: root.statusMessage
                    visible: text.length > 0
                    color: "#64748B"
                    font.pixelSize: 12
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                }
            }

            // Simple placeholder pages
            ColumnLayout {
                anchors.centerIn: parent
                width: Math.min(parent.width - 48, 360)
                spacing: 14
                visible: root.currentPage === "Settings"
                         || root.currentPage === "Login"

                Text {
                    text: root.currentPage
                    font.pixelSize: 27
                    font.bold: true
                    color: "#172033"
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: root.currentPage === "Settings"
                          ? "Your application settings will appear here."
                          : "Sign-in functionality will appear here."
                    font.pixelSize: 14
                    color: "#64748B"
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    Layout.fillWidth: true
                }

                Button {
                    text: "Back to Home"
                    Layout.alignment: Qt.AlignHCenter
                    onClicked: root.currentPage = "Home"
                }
            }
        }
    }
}

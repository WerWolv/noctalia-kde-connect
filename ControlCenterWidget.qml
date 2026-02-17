import QtQuick
import Quickshell
import qs.Widgets
import "./Services"

NIconButtonHot {
    property ShellScreen screen
    property var pluginApi: null

    function getIcon(device) {
        if (!KDEConnect.daemonAvailable)
            return "exclamation-circle"

        if (device === null || !device.reachable)
            return "device-mobile-off"

        if (device.notificationIds.length > 0)
            return "device-mobile-message"
        else if (device.charging)
            return "device-mobile-charging"
        else
            return "device-mobile"
    }

    function getConnectionState(device) {
        if (!KDEConnect.daemonAvailable)
            return pluginApi?.tr("control_center_widget.state.unavailable") || "Unavailable"

        if (device === null)
            return pluginApi?.tr("control_center_widget.state.no-device") || "No device"

        if (!device.reachable)
            return pluginApi?.tr("control_center_widget.state.disconnected") || "Disconnected"

        if (!device.paired)
            return pluginApi?.tr("control_center_widget.state.not-paired") || "Not paired"

        return pluginApi?.tr("control_center_widget.state.connected") || "Connected"
    }

    function getTooltip(device) {
        const batteryLine = (device !== null && device.reachable && device.paired && device.battery !== -1)
            ? ((pluginApi?.tr("control_center_widget.tooltip.battery") || "Battery") + ": " + device.battery + "%\n")
            : ""

        const stateLine = (pluginApi?.tr("control_center_widget.tooltip.state") || "State") + ": " + getConnectionState(device)

        return batteryLine + stateLine
    }

    icon: getIcon(KDEConnect.mainDevice)
    tooltipText: getTooltip(KDEConnect.mainDevice)

    onClicked: pluginApi?.togglePanel(screen, this)
}

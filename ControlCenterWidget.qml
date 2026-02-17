import QtQuick
import Quickshell
import qs.Widgets
import "./Services"

NIconButtonHot {
    property ShellScreen screen
    property var pluginApi: null

    function getTooltip(device) {
        const batteryLine = (device !== null && device.reachable && device.paired && device.battery !== -1)
            ? ("Battery: " + device.battery + "%\n")
            : ""

        const stateLine = "State: " + KDEConnectUtils.getConnectionState(device, KDEConnect.daemonAvailable)

        return batteryLine + stateLine
    }

    icon: KDEConnectUtils.getIcon(KDEConnect.mainDevice, KDEConnect.daemonAvailable)
    tooltipText: getTooltip(KDEConnect.mainDevice)

    onClicked: pluginApi?.togglePanel(screen, this)
}

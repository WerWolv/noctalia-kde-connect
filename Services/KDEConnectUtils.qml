pragma Singleton

import QtQuick

QtObject {
  function getIcon(device, daemonAvailable) {
    if (!daemonAvailable)
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

  function getConnectionState(device, daemonAvailable) {
    if (!daemonAvailable)
      return "Unavailable"

    if (device === null)
      return "No device"

    if (!device.reachable)
      return "Disconnected"

    if (!device.paired)
      return "Not paired"

    return "Connected"
  }
}

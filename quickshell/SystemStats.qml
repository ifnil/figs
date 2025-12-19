import QtQuick
import "SystemStats"

Item {
    id: stats

    property alias kernelVersion: kernel.kernelVersion
    property alias cpuUsage: cpu.usage
    property alias memUsage: mem.usage
    property alias diskUsage: disk.usage
    property alias volumeLevel: volume.level
    property alias batteryPercent: battery.percent

    KernelInfo {
        id: kernel
    }
    CpuUsage {
        id: cpu
    }
    MemUsage {
        id: mem
    }
    DiskUsage {
        id: disk
    }
    VolumeLevel {
        id: volume
    }
    BatteryLevel {
        id: battery
    }
}

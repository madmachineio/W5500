import CW5500
import SwiftIO



final public class W5500 {
    var netInfo: wiz_NetInfo = wiz_NetInfo()

    var receiveBuffer = [UInt8](repeating: 0, count: 1024)

    public enum SocketStatus: UInt8 {
        case closed         = 0x00
        case initialized    = 0x13
        case listen         = 0x14
        case synSent        = 0x15
        case synReceived    = 0x16
        case established    = 0x17
        case finWait        = 0x18
        case closing        = 0x1A
        case timeWait       = 0x1B
        case closeWait      = 0x1C
        case lastAck        = 0x1D
        case udp            = 0x22
        case ipRaw          = 0x32
        case macRaw         = 0x42
    }

    public init(spi: SPI, csPin: DigitalOut) {
        w5500_wrap_register(spi.obj, csPin.obj)

        // var txBufferSize = [UInt8](repeating: 2, count: 8)
        // var rxBufferSize = [UInt8](repeating: 2, count: 8)
        // wizchip_init(&txBufferSize, &rxBufferSize)

        writeInit()
        sleep(ms: 100)

        readInit()
        sleep(ms: 1000)
    }

    public func getSocketStatus(_ number: UInt8) -> SocketStatus {
        var arg: UInt8 = 0

        getsockopt(number, SO_STATUS, &arg)

        return SocketStatus(rawValue: arg)!
    }

    public func writeInit() {
        netInfo.mac.0 = 0xFF
        netInfo.mac.1 = 0x00
        netInfo.mac.2 = 0x55
        netInfo.mac.3 = 0xAA
        netInfo.mac.4 = 0x5A
        netInfo.mac.5 = 0xA5

        netInfo.ip.0 = 192
        netInfo.ip.1 = 168
        netInfo.ip.2 = 10
        netInfo.ip.3 = 33

        netInfo.sn.0 = 255
        netInfo.sn.1 = 255
        netInfo.sn.2 = 255
        netInfo.sn.3 = 0

        netInfo.gw.0 = 192
        netInfo.gw.1 = 168
        netInfo.gw.2 = 10
        netInfo.gw.3 = 1

        netInfo.dns.0 = 192
        netInfo.dns.1 = 168
        netInfo.dns.2 = 10
        netInfo.dns.3 = 1

        netInfo.dhcp = NETINFO_STATIC

        print("write netinfo: \(netInfo)")
        wizchip_setnetinfo(&netInfo)
    }

    public func readInit() {
        var verifyInfo = wiz_NetInfo()

        wizchip_getnetinfo(&verifyInfo)
        print("read netinfo: \(verifyInfo)")
    }



}

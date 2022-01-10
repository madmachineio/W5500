import CW5500
import SwiftIO


final public class W5500 {

    public init(spi: SPI, csPin: DigitalOut) {
        w5500_register(spi.obj, csPin.obj)
    }
}

import CW5500
import SwiftIO


final public class W5500 {
    var text = "Hello, World!"

    public init(spi: SPI, csPin: DigitalOut) {
        socket(0, 0, 0, 0)
        w5500_register(nil, nil)
    }

}

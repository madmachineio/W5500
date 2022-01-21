import SwiftIO
import MadBoard
import W5500


let cs = DigitalOut(Id.D3, value: true)
let spi = SPI(Id.SPI1, speed: 40_000_000, CPOL: false, CPHA: false)
//let spi = SPI(Id.SPI1, speed: 40_000_000, CPOL: true, CPHA: true)
print("spi speed = \(spi.getSpeed())")


sleep(ms: 100)
let eth = W5500(spi: spi, csPin: cs)
sleep(ms: 100)


while true {
    sleep(ms: 1)
}
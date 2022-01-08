#include "wizchip_conf.h"
#include "w5500_register.h"

#include "swift_gpio.h"
#include "swift_spi.h"


static void *gpio_ptr;
static void *spi_ptr;


static void cs_enable()
{
    swifthal_gpio_set(gpio_ptr, 0);
}

static void cs_disable()
{
    swifthal_gpio_set(gpio_ptr, 1);
}


static unsigned char spi_read_byte()
{
    unsigned char byte;

    swifthal_spi_read(spi_ptr, &byte, 1);
    return byte;
}

static void spi_write_byte(unsigned char value)
{
    swifthal_spi_write(spi_ptr, &value, 1);
}

static void spi_read(unsigned char *buf, unsigned short len)
{
    swifthal_spi_read(spi_ptr, buf, len);
}

static void spi_write(unsigned char *buf, unsigned short len)
{
    swifthal_spi_write(spi_ptr, buf, len);
}


static void empty()
{

}


void w5500_register(void *spi, void *gpio)
{
    spi_ptr = spi;
    gpio_ptr = gpio;

    reg_wizchip_cs_cbfunc(cs_enable, cs_disable);
    // TODO
    reg_wizchip_cris_cbfunc(empty, empty);
    reg_wizchip_spi_cbfunc(spi_read_byte, spi_write_byte);
    reg_wizchip_spiburst_cbfunc(spi_read, spi_write);
}
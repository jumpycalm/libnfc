IF(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  SET(LIBNFC_DRIVER_PN532_I2C ON CACHE BOOL "Enable PN532 I2C support (Use I2C bus)")
  SET(LIBNFC_DRIVER_PN532_SPI ON CACHE BOOL "Enable PN532 SPI support (Use SPI bus)")
ELSE(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  SET(LIBNFC_DRIVER_PN532_I2C OFF CACHE BOOL "Enable PN532 I2C support (Use I2C bus)")
  SET(LIBNFC_DRIVER_PN532_SPI OFF CACHE BOOL "Enable PN532 SPI support (Use SPI bus)")
ENDIF(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
SET(LIBNFC_DRIVER_PN532_UART ON CACHE BOOL "Enable PN532 UART support (Use serial port)")

IF(LIBNFC_DRIVER_PN532_I2C)
  ADD_DEFINITIONS("-DDRIVER_PN532_I2C_ENABLED")
  SET(DRIVERS_SOURCES ${DRIVERS_SOURCES} "drivers/pn532_i2c.c")
  SET(I2C_REQUIRED TRUE)
ENDIF(LIBNFC_DRIVER_PN532_I2C)

IF(LIBNFC_DRIVER_PN532_SPI)
  ADD_DEFINITIONS("-DDRIVER_PN532_SPI_ENABLED")
  SET(DRIVERS_SOURCES ${DRIVERS_SOURCES} "drivers/pn532_spi.c")
  SET(SPI_REQUIRED TRUE)
ENDIF(LIBNFC_DRIVER_PN532_SPI)

IF(LIBNFC_DRIVER_PN532_UART)
  ADD_DEFINITIONS("-DDRIVER_PN532_UART_ENABLED")
  SET(DRIVERS_SOURCES ${DRIVERS_SOURCES} "drivers/pn532_uart.c")
  SET(UART_REQUIRED TRUE)
ENDIF(LIBNFC_DRIVER_PN532_UART)


INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/libnfc/drivers)

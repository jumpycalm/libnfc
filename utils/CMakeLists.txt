SET(UTILS-SOURCES 
  nfc-barcode
  nfc-emulate-forum-tag4
  nfc-jewel
  nfc-list
  nfc-mfclassic
  nfc-mfultralight
  nfc-read-forum-tag3
  nfc-relay-picc
  nfc-scan-device
)

ADD_LIBRARY(nfcutils STATIC 
  nfc-utils.c
)
TARGET_LINK_LIBRARIES(nfcutils nfc)

# Examples
FOREACH(source ${UTILS-SOURCES})
  SET (TARGETS ${source}.c)

  IF(WIN32)
    SET(RC_COMMENT "${PACKAGE_NAME} utility")
    SET(RC_INTERNAL_NAME ${source})
    SET(RC_ORIGINAL_NAME ${source}.exe)
  ENDIF(WIN32)

  IF(${source} MATCHES "nfc-jewel")
    LIST(APPEND TARGETS jewel.c)
  ENDIF(${source} MATCHES "nfc-jewel")

  IF((${source} MATCHES "nfc-mfultralight") OR (${source} MATCHES "nfc-mfclassic"))
    LIST(APPEND TARGETS mifare.c)
  ENDIF((${source} MATCHES "nfc-mfultralight") OR (${source} MATCHES "nfc-mfclassic"))

  IF(WIN32)
    IF(${source} MATCHES "nfc-scan-device")
      LIST(APPEND TARGETS ../contrib/win32/stdlib.c)
      INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/../contrib/win32)
    ENDIF(${source} MATCHES "nfc-scan-device")
    IF(${source} MATCHES "nfc-read-forum-tag3")
      LIST(APPEND TARGETS ${CMAKE_CURRENT_SOURCE_DIR}/../contrib/win32/getopt.c)
    ENDIF()
  ENDIF(WIN32)

  ADD_EXECUTABLE(${source} ${TARGETS})

  TARGET_LINK_LIBRARIES(${source} nfc)
  TARGET_LINK_LIBRARIES(${source} nfcutils)

  INSTALL(TARGETS ${source} RUNTIME DESTINATION bin COMPONENT utils)
ENDFOREACH(source)

IF(NOT WIN32)
  # Manuals for the examples
  FILE(GLOB manuals "${CMAKE_CURRENT_SOURCE_DIR}/*.1")
  INSTALL(FILES ${manuals} DESTINATION ${SHARE_INSTALL_PREFIX}/man/man1 COMPONENT manuals)
ENDIF(NOT WIN32)

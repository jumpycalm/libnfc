SET(EXAMPLES-SOURCES
  nfc-anticol
  nfc-dep-initiator
  nfc-dep-target
  nfc-emulate-forum-tag2
  nfc-emulate-tag
  nfc-emulate-uid
  nfc-mfsetuid
  nfc-poll
  nfc-relay
  nfc-st25tb
#  pn53x-diagnose
#  pn53x-sam
#  pn53x-tamashell
)

INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/../libnfc)

# Examples
FOREACH(source ${EXAMPLES-SOURCES})
  SET (TARGETS ${source}.c)

  IF(WIN32)
    SET(RC_COMMENT "${PACKAGE_NAME} example")
    SET(RC_INTERNAL_NAME ${source})
    SET(RC_ORIGINAL_NAME ${source}.exe)
	
	  
	IF(${source} MATCHES "nfc-st25tb")
		LIST(APPEND TARGETS ${CMAKE_CURRENT_SOURCE_DIR}/../contrib/win32/getopt.c)
	ENDIF()
  ENDIF(WIN32)

  ADD_EXECUTABLE(${source} ${TARGETS})
  TARGET_LINK_LIBRARIES(${source} nfc)
  TARGET_LINK_LIBRARIES(${source} nfcutils)
  INSTALL(TARGETS ${source} RUNTIME DESTINATION bin COMPONENT examples)
ENDFOREACH(source)

IF(NOT WIN32)
  # Manuals for the examples
  FILE(GLOB manuals "${CMAKE_CURRENT_SOURCE_DIR}/*.1")
  INSTALL(FILES ${manuals} DESTINATION ${SHARE_INSTALL_PREFIX}/man/man1 COMPONENT manuals)
ENDIF(NOT WIN32)

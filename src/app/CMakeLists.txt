project(app)

file(GLOB_RECURSE APP_FILES "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")
add_library(${PROJECT_NAME} STATIC ${APP_FILES})

target_link_libraries(${PROJECT_NAME} ${CONAN_LIBS})
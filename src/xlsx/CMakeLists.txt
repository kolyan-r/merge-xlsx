project(xlsx)

add_executable(${PROJECT_NAME} merge-xlsx.cpp)

target_link_libraries(${PROJECT_NAME} ${CONAN_LIBS} app)
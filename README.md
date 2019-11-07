# Requirements
- [Boost 1.67](https://www.boost.org/)
- [xlnt](https://github.com/tfussell/xlnt)

# Install environment
```
sudo apt-get install python-pip
sudo pip install conan
```

# Install & build
```
conan profile update settings.compiler.libcxx=libstdc++11 default
conan remote add conan-community https://api.bintray.com/conan/conan-community/conan
conan remote add shajeenahmed https://api.bintray.com/conan/shajeenahmed/conan
mkdir cmake-conan
conan install . --install-folder=cmake-conan
mkdir -p cmake-build/output
cd cmake-build
cmake .. -DCMAKE_INSTALL_PREFIX=output
make
make install
ls -la output/bin/merge-xlsx --help
```
rem Check whether Boost libraries compiled with MSVC and Python 3.7 are in cache
rem If not, download and build them. We do not build all of Boost, just the
rem bits we need: filesystem, test, system, and python.

if "%CMAKE_GENERATOR%"=="Visual Studio 15 2017 Win64" (
  echo "Using VS generator %CMAKE_GENERATOR%"
  echo "-- Installing Boost"
  if exist "C:\Deps\boost_1_67_0\include\boost-1_67\" (
    echo "-- Boost FOUND in cache"
  ) else (
    echo "-- Boost NOT FOUND in cache"
    rem Download
    bash -c "curl -LOs https://dl.bintray.com/boostorg/release/1.67.0/source/boost_1_67_0.zip"
    bash -c "7z x boost_1_67_0.zip"
    rem Configure
    cd boost_1_67_0
    bootstrap.bat > NUL
    rem Build and install
    b2 -q install address-model=64 architecture=x86 threading=multi toolset=msvc --build-type=complete --with-filesystem --with-test --with-system --with-python --prefix="C:\Deps\boost_1_67_0" > NUL
    rem Clean up
    cd %APPVEYOR_BUILD_FOLDER%
    del /s /q boost_1_67_0 boost_1_67_0.zip > NUL
  )
  echo "-- Done installing Boost"
) else (
  echo "Using non-VS generator %CMAKE_GENERATOR%"
  echo "Nothing to do here!"
)

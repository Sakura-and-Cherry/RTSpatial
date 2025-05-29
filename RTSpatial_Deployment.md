# OptiX 8.0.0
## 下载
https://developer.nvidia.com/designworks/optix/downloads/legacy

## 安装依赖环境
https://blog.csdn.net/qq_45779334/article/details/124304087

## 安装gflags
cmake -DCMAKE_INSTALL_PREFIX=/mnt/home/xyzhu/libs/gflags -DBUILD_SHARED_LIBS=ON -DBUILD_STATIC_LIBS=ON -DINSTALL_HEADERS=ON -DINSTALL_SHARED_LIBS=ON -DINSTALL_STATIC_LIBS=ON  ..

## 安装boost 1.76.0
./bootstrap.sh --prefix=/mnt/home/xyzhu/libs/boost_1_76_0
./b2 install
### 配置环境变量
export Boost_ROOT=/mnt/home/xyzhu/libs/boost_1_76_0/
export Boost_INCLUDE_DIR=/mnt/home/xyzhu/libs/boost_1_76_0/include/boost
export Boost_LIBRARY_DIR=/mnt/home/xyzhu/libs/boost_1_76_0/lib
export CPLUS_INCLUDE_PATH=/mnt/home/xyzhu/libs/boost_1_76_0/include/boost:$CPLUS_INCLUDE_PATH
export LIBRARY_PATH=/mnt/home/xyzhu/libs/boost_1_76_0/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=/mnt/home/xyzhu/libs/boost_1_76_0/lib:$LD_LIBRARY_PATH


## 编译Optix
### 安装gcc12 g++12
sudo apt-get install gcc-12 g++-12 -y
### 切换gcc版本 不超过gcc12
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 40 --slave /usr/bin/g++ g++ /usr/bin/g++-12
### 查看现有版本并切换
sudo update-alternatives --config gcc


# RTSpatial
## cmake
cmake -DOptiX_INSTALL_DIR=/mnt/home/xyzhu/libs/Optix/NVIDIA-OptiX-SDK-8.0.0-linux64-x86_64 ..


# 参考RTSpatial的配置路径
export AE_DEPS=~/libs/ae_deps

./NVIDIA-OptiX-SDK-8.0.0-linux64-x86_64.sh --prefix=$AE_DEPS --exclude-subdir --skip-license

cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$AE_DEPS -DCMAKE_INSTALL_PREFIX=$AE_DEPS -BUILD_EXAMPLES=ON ..

cd ..

rm -r build

mkdir build && cd build

cmake -DBUILD_EXAMPLES=ON \
      -DCMAKE_PREFIX_PATH=$AE_DEPS \
      -DCMAKE_BUILD_TYPE=Release \
      -DGFLAGS_INCLUDE_DIR=/mnt/home/xyzhu/libs/gflags/include \
      -DGFLAGS_LIBRARY=/mnt/home/xyzhu/libs/gflags/lib/libgflags.a \
      ..

make -j 

# 使用example文件
# box和box的contain 1000
./bin/rtspatial_exec -box /mnt/home/xyzhu/codes/RTSpatial/dataset/box/gaussian_1000.wkt  -box_query /mnt/home/xyzhu/codes/RTSpatial/dataset/box/uniform_1000.wkt  -predicate contains -gpu_id=1

# 10000 box 和 10000 point 的 predicate
./bin/rtspatial_exec -box /mnt/home/xyzhu/codes/RTSpatial/dataset/box/gaussian_10000.wkt  -point_query /mnt/home/xyzhu/codes/RTSpatial/dataset/point/uniform_10000.wkt  -predicate contains
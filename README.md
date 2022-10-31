# SPACE 挖矿指引
 ## 中文 / [english](https://github.com/Brochao/space-mining-guide/blob/main/README-en.md)

## 系统环境
Ubuntu 20.04 LTS

## 第一步： 安装依赖项
```
sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils
```
```
sudo apt-get install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
```
```
sudo apt-get install libdb-dev
```
```
sudo apt-get install libdb++-dev
```
```
sudo apt-get install libczmq-dev
```

## 快速启动节点(快速启动可跳过第二、三步)
1. 将[install-node.sh](https://github.com/Brochao/space-mining-guide/blob/main/install-node.sh)和[mvc.conf](https://github.com/Brochao/space-mining-guide/blob/main/mvc.conf)置于同一个文件夹($NODE_DIR)
2. 修改mvc.conf中的addnode、rpcuser和rpcpasswd等参数
3. chmod 777 ./install-node.sh
4. ./install-node.sh -t -latest

## 第二步: 下载节点客户端、挖矿程序和节点配置文件


### 客户端

最新版本: [v0.1.0.0](https://github.com/Brochao/space-mining-guide/releases/download/v0.1.0.0/mvc.tar.gz)

历史版本: none

### 挖矿程序

[cpuminer](https://github.com/Brochao/space-mining-guide/releases/download/v0.1.0.0/cpuminer.tar.gz)

### 配置文件
[mvc.conf](https://github.com/Brochao/space-mining-guide/blob/main/mvc.conf)



## 第三步: 运行节点

1. 将客户端程序解压到用户目录
```
tar zxvf mvc.tar.gz -C /home/$USER/mvc
```
2. 将挖矿程序解压到用户目录
```
tar zxvf cpuminer.tar.gz -C /home/$USER/mine
```
3. 将配置文件拷贝到用户目录
```
cp mvc.conf /home/$USER/mvc
```
4. 创建节点数据文件夹
```
mkdir -p  /home/$USER/node_data_dir
```
5. 修改配置文件中的信息
```
addnode=ip:port (连接的节点)
rpcuser=user (节点的rpc访问用户名)
rpcpassword=password (节点的rpc访问密码)
```
6. 启动节点
```
/home/$USER/mvc/bin/mvcd -conf=/home/$USER/mvc/mvc.conf -data_dir=/home/$USER/node_data_dir
```

## 第四步: 启动挖矿

1. 配置cli命令
```
alias mvc-cli="/home/$USER/mvc/bin/mvc-cli -conf=/home/$USER/mvc/mvc.conf"
```
快速启动节点配置方法
```
alias mvc-cli="$NODE_DIR/bin/mvc-cli -conf=$NODE_DIR/mvc.conf"

```
2. 获取挖矿地址
```
mvc-cli getnewaddress "mine"
```
3. 开始挖矿
```
/home/$USER/mine/minerd -a sha256d -o 127.0.0.1:9882 -O user:password --coinbase-addr=addr
```
快速启动节点的挖矿方法
```
$NODE_DIR/minerd -a sha256d -o 127.0.0.1:9882 -O user:password --coinbase-addr=addr
```
user:password替换为配置文件mvc.conf中的rpcuser=user (节点的rpc访问用户名)和rpcpassword=password (节点的rpc访问密码)
coinbase-addr替换为上一步生成的地址，或者使用个人地址

# Mining guidelines for SPACE

 ## [中文](https://github.com/Brochao/space-mining-guide/blob/main/README.md) / english

## Operating System Environment
    Ubuntu 20.04 LTS

## STEP 1： Dependencies 
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
apt-get install libczmq-dev
```

## Run MVC node directly(skip step 2 and step 3)
1. Place [install-node.sh](https://github.com/Brochao/space-mining-guide/blob/main/install-node.sh) and [mvc.conf](https://github.com/Brochao/space-mining-guide/blob/main/mvc.conf)in the same folder($NODE_DIR)
2. Modify `addnode`、`rpcuser` and `rpcpasswd` in mvc.conf
3. chmod 777 ./install-node.sh
4. ./install-node.sh -t -latest

## Step 2: Download the node binary, mining program, and node configuration file


### node

`latest version`: [v0.1.0.0](https://github.com/Brochao/space-mining-guide/releases/download/v0.1.0.0/mvc.tar.gz)

`history version`: none

### mining program

[cpuminer](https://github.com/Brochao/space-mining-guide/releases/download/v0.1.0.0/cpuminer.tar.gz)

### configuration file
[mvc.conf](https://github.com/Brochao/space-mining-guide/blob/main/mvc.conf)



## Step 3: run the node

1. Unzip the node binary to user's directory
```
tar zxvf mvc.tar.gz -C /home/$USER/mvc
```
2. Unzip the mining program to user's directory
```
tar zxvf cpuminer.tar.gz -C /home/$USER/mine
```
3. Copy the configuration file to user's directory
```
cp mvc.conf /home/$USER/mvc
```
4. create the node data directory
```
mkdir -p  /home/$USER/node_data_dir
```
5. Modify the configuration file
```
addnode=ip:port (the node to connect to)
rpcuser=user (user name for the RPC accessing)
rpcpassword=password (password for the RPC accessing)
```
6. Start the node
```
/home/$USER/mvc/bin/mvcd -conf=/home/$USER/mvc/mvc.conf -data_dir=/home/$USER/node_data_dir
```

## Step 4: Start mining

1. alias cli command
```
alias mvc-cli="/home/$USER/mvc/bin/mvc-cli -conf=/home/$USER/mvc/mvc.conf"
```
or (if run MVC node directly)
```
alias mvc-cli="$NODE_DIR/bin/mvc-cli -conf=$NODE_DIR/mvc.conf"

```
2. Create a new address for mining
```
mvc-cli getnewaddress "mine"
```
3. Start mining
```
/home/$USER/mine/minerd -a sha256d -o 127.0.0.1:9882 -O user:password --coinbase-addr=addr
```
or (if run MVC node directly)
```
$NODE_DIR/minerd -a sha256d -o 127.0.0.1:9882 -O user:password --coinbase-addr=addr
```
user:password is same as the configuration in mvc.conf
coinbase-addr:the new address or your own address 

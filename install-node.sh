#!/bin/bash
_url=https://github.com/Brochao/space-mining-guide/releases/download
_net_choose=
_latest_version=0.1.0.0
_version=
_node_file=mvc.tar.gz
_miner_file=cpuminer.tar.gz
_node_install_dir=
_node_data_dir=

# check_file_exit(){

# }
ensure() {
    if ! "$@"; then err "command $*" "failed" ; fi
}

say() {
    printf '[ERROR] %s: %s\n' "$1" "$2"
}

err() {
    say "$1" "$2" >&2
    exit 1
}

need_cmd() {
    if ! check_cmd "$1"; then
        err "command not found" "need '$1'"
    fi
}

check_cmd() {
    command -v "$1" > /dev/null 2>&1
}

usage() {
    cat 1>&2 <<EOF
The node installer for metaverchain

USAGE:
    ./install-node.sh [FLAGS] [OPTIONS]

FLAGS:
    -m, --mainnet             install and query mainnet
    -t, --testnet             install and query testnet

OPTIONS:
        --latest              install the newest version of metaversechain
        --version=<x.x.x.x>   install the specific version (--version=0.1.0.0 for example)
EOF
}

main(){
    if [ $# -eq 0 ] || [ $# -gt 2 ] || [ "$1" = -h ] || [ "$1" = -help ] || [ "$1" = ? ];
    then
        usage
        exit 0
    fi

    if [ "$1" != -m ] && [ "$1" != --mainnet ] && [ "$1" != -t ] && [ "$1" != --testnet ];
    then
        err "net choose [$1]" "not support"
    fi

    if [ "$1" = -m ] || [ "$1" = --mainnet ];
    then
        # TODO
        err "net choose [$1]" "mainnet is not supported yet"
        # _net_choose=mainnet
    fi

    if [ "$1" = -t ] || [ "$1" = --testnet ];
    then
        _net_choose=testnet
    fi


    local tmp_str=$2
    tmp_str=${tmp_str%=*}

    if [ "$2" = --latest ];
    then
        _version=$_latest_version
    elif [ $tmp_str = --version ]; 
    then
        tmp_str=$2
        _version=${tmp_str#*=}
        _version=${_version#*v}
    else
    err "version choose [$2]" "invalid"
    fi


    echo you choose $_net_choose with version $_version 
    # echo continue? "(y/n)"
    # read -n 1 choise
    # echo 
    # if [ $choise != y ];
    # then
    #     echo "installation will be quit, please check your choise"
    #     exit 0
    # fi


    need_cmd wget
    need_cmd tar
    need_cmd pwd

    # echo "please input the installation path of mvc node"
    # echo "if not set"
    # echo "current path will be used"
    # read  path
    # _node_install_dir=$path
    
    # if [ -z $_node_install_dir ];
    # then
        _node_install_dir=$(pwd)
    # fi
    echo "the mvc node will be installed to $_node_install_dir"
    # echo "(y/n)"
    # read -n 1 choise
    # if [ $choise != y ];
    # then
    #     echo "installation will be quit, please select another path"
    #     exit 0
    # fi

    # echo "please input the data storage path of mvc node"
    # echo "in which the blocks data/wallet data/logs will be saved"
    # echo "if not set"
    # echo "current path will be used"
    # read  path
    # _node_data_dir=$path
    
    # if [ -z $_node_data_dir ];
    # then
        _node_data_dir=$(pwd)/node_data_dir
    # fi
    echo "the mvc node data will be saved to $_node_data_dir"
    # echo "(y/n)"
    # read -n 1 choise
    # echo 
    # if [ $choise != y ];
    # then
    #     echo "installation will be quit, please select another path"
    #     exit 0
    # fi

     ensure mkdir -p "$_node_install_dir"
     ensure mkdir -p "$_node_data_dir"

    local temp_path=temp-$(date +%s%N)
    mkdir $temp_path
    cd $temp_path
    echo "downloading node file..."
    echo 
    wget -q --show-progress ${_url}/v${_version}/${_node_file} 
    if [ $? != 0 ];
    then
        err "node downloading" "failed"
    fi

    echo "downloading mining file..."
    echo 
    wget -q --show-progress ${_url}/v${_version}/${_miner_file} 
        if [ $? != 0 ];
    then
        err "miner downloading" "failed"
    fi

   tar zxvf mvc.tar.gz -C $_node_install_dir
   tar zxvf cpuminer.tar.gz -C $_node_install_dir

   cd ..
   rm -rf $temp_path



   $_node_install_dir/bin/mvcd -conf=$_node_install_dir/mvc.conf -data_dir=$_node_data_dir

}

main "$@" || exit 1
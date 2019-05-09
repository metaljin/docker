#!/bin/sh

if [ "$1" = "start_proxy" ]; then
    if [ ! -f /etc/3proxy/3proxy.cfg ]; then
        if [ -z "$PROXY_LOGIN" ] || [ -z "$PROXY_PASSWORD" ]; then
            echo >&2 'error: proxy is uninitialized, variables is not specified '
            echo >&2 '  You need to specify PROXY_LOGIN and PROXY_PASSWORD'
            exit 1
        fi
        
        cat <<EOF>/etc/3proxy/3proxy.cfg
writable
nserver 192.168.140.1
nserver 8.8.8.8
nserver 8.8.4.4
nscache 65536

counter "/etc/3proxy/3proxy.3cf" D "/etc/3proxy/traf"
log
logformat "L%t%. L%t.%. %N.%p %E %U %C:%c %R:%r %O %I %h %T"

monitor /etc/3proxy/3proxy.cfg

users $PROXY_LOGIN:CL:$PROXY_PASSWORD

auth strong
proxy -p3128
socks -p1080
admin -p8080

flush
EOF
        echo "Proxy user login:    $PROXY_LOGIN"
        echo "Proxy user password: $PROXY_PASSWORD"
        echo "Proxy process started!"
    fi
    
        /3proxy /etc/3proxy/3proxy.cfg
else
    exec "$@"
fi

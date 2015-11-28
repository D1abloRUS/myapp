#/bin/bash

mkdir -p /opt/myapp
cp build/libs/*.jar /opt/myapp/myapp.jar

cat << 'EOF' > /etc/init.d/myapp
#!/bin/bash
#chkconfig: - 80 20 
#description: myapp
 
# Source function library.
. /etc/rc.d/init.d/functions
 
PREFIX_DIR=/opt/myapp
 
case "$1" in
    start)
	if [ -f /var/run/myapp.pid ]; then
                echo "Application is running... ";
                exit 0
        fi
        echo -n "Starting myapp application: "
	nohup java -jar ${PREFIX_DIR}/myapp.jar > /var/log/myapp.log 2> /var/log/myapp-errors.log < /dev/null &
	PID=$!
	echo $PID > /var/run/myapp.pid        
	echo
    ;;
    stop)
        echo -n "Stopping myapp application: "
        if [ ! -f /var/run/myapp.pid ]; then
		echo "Application is not running... ";
   		exit 0
	fi
	PID=$(cat /var/run/myapp.pid)
	kill $PID
	rm -f /var/run/myapp.pid
        echo
    ;;
    status)
        status java
    ;;
    restart | reload)
        $0 stop ; $0 start
    ;;
    *)
        echo "Usage: myapp {start|stop|status|reload|restart"
        exit 1
    ;;
esac
EOF

chmod +x /etc/init.d/myapp

/etc/init.d/myapp start
chkconfig myapp on

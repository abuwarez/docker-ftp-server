#!/bin/sh

addgroup \
	-g $GID \
	-S \
	$FTP_USER

adduser \
	-D \
	-G $FTP_USER \
	-h /home/$FTP_USER \
	-s /bin/false \
	-u $UID \
	$FTP_USER

mkdir -p /home/$FTP_USER
chown -R $FTP_USER:$FTP_USER /home/$FTP_USER
echo "$FTP_USER:$FTP_PASS" | /usr/sbin/chpasswd

touch /var/log/vsftpd.log
tail -f /var/log/vsftpd.log | tee /dev/stdout &
touch /var/log/xferlog
tail -f /var/log/xferlog | tee /dev/stdout &

sed -i "s:listen_port=.*\$:listen_port=$PORT21:" /etc/vsftpd.conf
sed -i "s:ftp_data_port=.*\$:ftp_data_port=$PORT20:" /etc/vsftpd.conf
sed -i "s:pasv_min_port=.*\$:pasv_min_port=$MIN_PASSIVE_PORT:" /etc/vsftpd.conf
sed -i "s:pasv_max_port=.*\$:pasv_max_port=$MAX_PASSIVE_PORT:" /etc/vsftpd.conf

cat /etc/vsftpd.conf

printenv


/usr/sbin/vsftpd

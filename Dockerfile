FROM alpine:3.20.3
ENV FTP_USER=foo \
	FTP_PASS=bar \
	GID=1000 \
	UID=1000 \
	PORT20=20 \
	PORT21=21 \
	MIN_PASSIVE_PORT=40000 \
	MAX_PASSIVE_PORT=40009 

RUN apk add --no-cache --update \
	vsftpd==3.0.5-r2

COPY [ "/src/vsftpd.conf", "/etc" ]
COPY [ "/src/docker-entrypoint.sh", "/" ]

ENTRYPOINT [ "/docker-entrypoint.sh" ]

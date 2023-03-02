#!/bin/bash
ETCD_ENDPOINTS=${1}

cat <<EOF >/opt/kubernetes/cfg/flanneld
FLANNEL_OPTIONS="--etcd-endpoints=${ETCD_ENDPOINTS} \
-etcd-cafile=/opt/ssl/etcd/etcd.pem \
-etcd-certfile=/opt/ssl/etcd/etcd.pem \
-etcd-keyfile=/opt/ssl/etcd/etcd-key.pem"
EOF

cat <<EOF >/usr/lib/systemd/system/flanneld.service
[Unit]
Description=Flanneld overlay address etcd agent
After=network-online.target network.target
Before=docker.service

[Service]
Type=notify
EnvironmentFile=/opt/kubernetes/cfg/flanneld
ExecStart=/opt/kubernetes/bin/flanneld --ip-masq \$FLANNEL_OPTIONS
ExecStartPost=/opt/kubernetes/bin/mk-docker-opts.sh -k DOCKER_NETWORK_OPTIONS -d /run/flannel/subnet.env
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable flanneld
systemctl restart flanneld
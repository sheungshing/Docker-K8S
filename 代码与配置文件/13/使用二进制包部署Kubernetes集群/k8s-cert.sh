cat > ca-config.json <<EOF
{
  "signing": {
    "default": {
      "expiry": "87600h"
    },
    "profiles": {
      "kubernetes": {
        "usages": [
            "signing",
            "key encipherment",
            "server auth",
            "client auth"
        ],
        "expiry": "87600h"
      }
    }
  }
}
EOF

cat > ca-csr.json <<EOF
{
   "CN": "kubernetes",
   "key": {
     "algo": "rsa",
     "size": 2048
   },
   "names": [{
    "C": "CN",
    "ST": "BeiJing",
    "L": "BeiJing",
    "O": "k8s",
    "OU": "System"
   }]
   }
EOF

cfssl gencert -initca ca-csr.json | cfssljson -bare ca

cat >server-csr.json<<EOF
{
  "CN": "kubernetes",
  "hosts": [
     "192.168.79.11",
     "127.0.0.1",
     "kubernetes",
     "kubernetes.default",
     "kubernetes.default.svc",
     "kubernetes.default.svc.cluster",
     "kubernetes.default.svc.cluster.local"
  ],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "L": "BeiJing",
      "ST": "BeiJing",
      "O": "system:masters",
      "OU": "System"
    }
  ]
}
EOF

cfssl gencert -ca=ca.pem -ca-key=ca-key.pem \
-config=ca-config.json -profile=kubernetes \
server-csr.json | cfssljson -bare server

cat >admin-csr.json <<EOF
{
  "CN": "admin",
  "hosts": [],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "L": "BeiJing",
      "ST": "BeiJing",
      "O": "system:masters",
      "OU": "System"
    }
  ]
}
EOF
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem \
-config=ca-config.json -profile=kubernetes \
admin-csr.json | cfssljson -bare admin

cat > kube-proxy-csr.json <<EOF
{
  "CN": "system:kube-proxy",
  "hosts": [],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "L": "BeiJing",
      "ST": "BeiJing",
      "O": "k8s",
      "OU": "System"
    }
  ]
}
EOF

cfssl gencert -ca=ca.pem -ca-key=ca-key.pem \
-config=ca-config.json -profile=kubernetes \
kube-proxy-csr.json | cfssljson -bare kube-proxy
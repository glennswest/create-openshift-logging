rm -r -f storage-class
mkdir storage-class
cd storage-class
cat << EOF > sc.yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1 
metadata:
  name: generic
  annotations:
    storageclass.kubernetes.io/is-default-class: 'true'
provisioner: nfs
spec:
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
EOF
oc create -f sc.yaml
for pvnum in {1..10}
do
echo Working on PV${pvnum}
oc delete pv/pv${pvnum}
cat << EOF >  pv${pvnum}.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv${pvnum}
spec:
  capacity:
    storage: 200Gi
  accessModes:
  - ReadWriteOnce
  nfs:
    path: /volume1/pv/pv${pvnum}
    server: 192.168.1.250
  persistentVolumeReclaimPolicy: Retain
  storageClassName: generic
EOF
oc create -f pv${pvnum}.yaml
done

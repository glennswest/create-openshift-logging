#oc create -f eo-namespace.yaml
#oc create -f olo-namespace.yaml
#oc create -f eo-og.yaml
#oc create -f eo-sub.yaml
#sleep 90
#oc get csv --all-namespaces
#oc create -f olo-og.yaml
#oc create -f olo-sub.yaml
#sleep 90
#oc get csv -n openshift-logging
#./create-storage-class.sh
oc create -f olo-instance.yaml




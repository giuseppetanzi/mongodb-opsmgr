# mongodb-opsmgr

Quick instructions on how to use this demo.

After starting up OpenShift/Minishift, create a project for hosting the OpsManager.

oc new-project opsmgr

Give the default service account permission to start the pod with anyuid SCC

oc adm policy add-scc-to-user anyuid system:serviceaccount:opsmgr:default



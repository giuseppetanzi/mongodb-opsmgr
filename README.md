# mongodb-opsmgr

Quick instructions on how to use this demo.

After starting up OpenShift/Minishift, create a project for hosting the OpsManager.

```
oc new-project opsmgr
```

Give the default service account for that project permission to start the pod with anyuid SCC

```
oc adm policy add-scc-to-user anyuid system:serviceaccount:opsmgr:default
```
    
Now instantiate the template within the project

```
oc process -f opsmgr.yaml | oc create -f -
```

A build will automatically start taking some minutes, finally the Ops Manager will be up and running, using a second pod as its own Mongod database (single instance).

As next step, we'll create a set of 3 nodes with Automation Agent preinstalled, to be able to test monitoring and management features within an OpenShift deployment environment.

To complete the next step, it's necessary to access the Ops Manager web interface via the automatically created Route. During the initial Ops Manager configuration the server URL to be used is in the form http://<service_name>.<namespace>:8080. 
    
Take note of mmsGroupID and mmsApiKey, that will be used in the Mongo nodes' configuration as input to the template.

Finally, proceed with creation of Mongo nodes

```
oc new-project servers
oc adm policy add-scc-to-user anyuid system:serviceaccount:opsmgr:default
oc process -f mongo-nodes.yaml NAMESPACE=servers MMS_GROUPID=<MMS_GROUPID> MMS_APIKEY=<MMS_APIKEY> OPSMGR_URL=<OPSMGR_URL> | oc create -f -
```

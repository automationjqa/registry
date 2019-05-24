##### Access to your registry:

##### Installation with endpoint:
```docker login node<id>-<envName>.domain:<endpointPublicPort>```
##### Installation with publicIP:
```docker login node<id>-<envName>.domain:5000```
  
##### Credentials are stored in the registry container:
```/home/registry_auth```

##### LetsEncrypt installation/update log:
```/var/log/cert.log```

##### Tag image:
```docker tag <image> node<id>-<envName>.domain:<endpointPublicPort>\jelastic\<image>:<tag>```

##### Push image:
```docker push node<id>-<envName>.domain:<endpointPublicPort>\jelastic\<image>:<tag>```

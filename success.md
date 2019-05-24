##### Access to your registry:

##### Installation with endpoint:
```docker login node<id>-<envName>.domain:<endpointPublicPort>```
##### Installation with publicIP:
```docker login node<id>-<envName>.domain```
  
##### Credentials are stored in the registry container:
```/home/registry_auth```

##### Tag image:
```docker tag <image> node<id>-<envName>.domain:<endpointPublicPort>\jelastic\<image>:<tag>```

##### Push image:
```docker push node<id>-<envName>.domain:<endpointPublicPort>\jelastic\<image>:<tag>```

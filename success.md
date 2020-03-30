##### Access to your registry:

##### Installation with endpoint:
```docker login ${globals.startPage}:<endpointPublicPort>```
##### Installation with publicIP:
```docker login ${globals.startPage}:5000```
  
##### Credentials are stored in the registry container:
```/home/registry_auth```

##### LetsEncrypt installation/update log:
```/var/log/cert.log```

##### Tag image:
```docker tag <image> ${globals.startPage}:<endpointPublicPort>\jelastic\<image>:<tag>```

##### Push image:
```docker push ${globals.startPage}:<endpointPublicPort>\jelastic\<image>:<tag>```

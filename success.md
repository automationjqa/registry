##### Login to a registry:
~~~~
docker login ${globals.registryURL}:${globals.registryPort}
~~~~
  
##### Credentials are stored in the registry container:
```/home/registry_auth```

##### LetsEncrypt installation/update log:
```/var/log/cert.log```

##### Tag image:
~~~~
docker tag <image> ${globals.registryURL}:${globals.registryPort}/jelastic/<image>:<tag>
~~~~

##### Push image:
~~~~
docker push ${globals.registryURL}:${globals.registryPort}/jelastic/<image>:<tag>
~~~~

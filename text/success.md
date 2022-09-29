##### Login to a registry:
~~~~
docker login ${globals.registryURL}:${globals.registryPort} -u ${globals.registryUser} -p ${globals.registryPassword}
~~~~
  
##### Credentials are stored in the registry container:
```/home/registry_auth```

##### LetsEncrypt installation/update log:
```/var/log/letsencrypt/letsencrypt.log```

##### Tag image:
~~~~
docker tag <image> ${globals.registryURL}:${globals.registryPort}/${globals.registryUser}/<image>:<tag>
~~~~

##### Push image:
~~~~
docker push ${globals.registryURL}:${globals.registryPort}/${globals.registryUser}/<image>:<tag>
~~~~

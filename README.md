# mc-server

Files for a docker image for a fabric minecraft server. Instructions will be general in order to allow updating versions of stuff

1. **Java Version and Dockerfile changes**

Java version can be specified in the first line of the Dockerfile. Change the number to correspond to the most up-to-date version of OpenJDK. 
```
FROM openjdk:<version number here>-jdk-slim
```

The dockerfile can also be used to specify the server RAM. Default is 16GB, but can be changed in the following line:

```
CMD ["java", "-Xmx<RAM amount goes here>", "-jar", "fabric-server-mc.1.21.4-loader.0.16.9-launcher.1.0.1.jar", "nogui"]
```

2. **Fabric version**

The fabric server .jar file can be downloaded here: https://fabricmc.net/use/server/

Other versions (forge, vanilla, etc) can also be used, setup should be identical. Place the file into the current working directory. The current server file is Fabric for minecraft version 1.21.4

3. **Running the Server (first time)**

If the server has already been run before (and all server files have been generated), skip this step

Install java locally, and run the following command:
```
java -Xmx2G -jar fabric-server-mc.1.21.4-loader.0.16.9-launcher.1.0.1.jar nogui
```
Note: **there will be an error and that's fine**
Go into eula.txt and change 'false' to 'true'. 

4. **Creating and pushing the docker image**

Run the following:

```
docker build . --tag <dockerhub username>/<docker image name> --platform linux/amd64
```

If you want to use the image remotely:

```
docker push <dockerhub username>/<docker image name>
```

5. **Running the Server (not first time)**

If you want to run the image locally:

```
docker run -it -d -p 25565:25565 --name fabric-mc-server <dockerhub username>/<docker image name>
```
Note: the -it flag allows using STDIN when interacting with the minecraft server process (see docker attach below)

This command will run the server on localhost:25565. If you want to host it remotely using the docker image, make sure the cloud service is exposing port 25565 as well. The server can then be accessed using <cloud host's ip>:25565

NOTE: Use the following command to attach to the server runtime (to execute commands and such):

```
docker attach <container id>
```

Also, use Ctrl+P followed by Ctrl+Q to detach (Ctrl+C will kill the container)

5. **Backing up the server (from google cloud VM)**

Set up ssh (you can google that)

ssh into the VM and copy the world folder out of the docker container:

```
docker cp <container name>:/usr/src/minecraft/world/ .
```

Exit the ssh, cd into the Documents folder locally, and run the following:

```
gcloud compute scp --recurse <vm name>:/home/blapuma/world/ ~/Documents
```


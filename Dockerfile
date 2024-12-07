# Use an official OpenJDK runtime as a parent image
FROM openjdk:23-jdk-slim

# Set the working directory
WORKDIR /usr/src/minecraft

# Copy all current files into the container
COPY . .

# Expose the Minecraft server port
EXPOSE 25565

# Run the Fabric server WITH 2GB of RAM
CMD ["java", "-Xmx16G", "-jar", "fabric-server-mc.1.21.4-loader.0.16.9-launcher.1.0.1.jar", "nogui"]
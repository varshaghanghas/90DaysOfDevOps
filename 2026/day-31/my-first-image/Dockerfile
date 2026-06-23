# Pull ubuntu base image
FROM ubuntu:latest

# Update package lists and install curl without prompting for inputs
RUN apt-get update && apt-get install -y curl

# Set the default command to print the message
CMD ["echo", "Hello from my custom image!"]
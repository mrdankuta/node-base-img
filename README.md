# Node Troubleshooting Base Image for React Devs

> **Task:** Create a docker image that will serve as a base image for an organization that uses React and NodeJS applications in kubernetes. This image should have network tools that can be used during troubleshooting e.g., curl, telnet, etc.

The goal is to create a base Docker image that can serve as a starting point for React and Node.js application development within the organization, including network tools for troubleshooting.

## DevOps Engineers' Dockerfile

```Dockerfile
FROM node:21-bullseye-slim AS baseImage

RUN apt-get update && apt-get install -y \
    curl \
    telnet \
    netcat \
    dnsutils \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
```

- **Build the Docker image**

```sh
docker build -t theorgrepo/node-base-image:1.0.0 .
```

- **Push the Docker image to a registry**

```sh
docker push theorgrepo/node-base-image:1.0.0
```

## React Devs' Dockerfile

React developers within the organization can then use this base image as a starting point for their applications by creating a new Dockerfile that extends from this base image:

```dockerfile
FROM theorgrepo/node-base-image:1.0.0

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy the application code
COPY . .

# Build the app
RUN npm run build

# Expose the port (if applicable)
EXPOSE 3000

# Define the start command
CMD ["npm", "start"]
```

The Dockerfile for the Application Developers copies the application code, installs the dependencies, builds the React application, and defines the start command.

The base image remains lightweight and reusable across multiple projects within the organization. Developers can then focus on building their applications on top of this base image, which already includes the necessary tools and environment for development and troubleshooting.

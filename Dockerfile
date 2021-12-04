# Angular Docker Image; Multi-stage build courtesy of:
#  https://mherman.org/blog/dockerizing-an-angular-app/
### STAGE 1: Build ###

# We label our stage as ‘builder’
FROM node:latest as build

## Storing node modules on a separate layer will prevent unnecessary npm installs at each build
RUN mkdir -p /app

WORKDIR /app

ENV PATH /app/node_modules/.bin:$PATH
# Stage 1: Compile and Build angular codebase

# Use official node image as the base image
FROM node:latest as build

# Add the source code to app
COPY . .

# Install all the dependencies
RUN npm install
RUN npm install -g @angular/cli@10.0.7

# Generate the build of the application
RUN npm run build --prod --output-path=dist


# Stage 2: Serve app with nginx server

# pre-cleanup
RUN rm -rf /usr/share/nginx/html/*

# Use official nginx image as the base image
FROM nginx:latest

# Copy the build output to replace the default nginx contents.
COPY --from=build /app/dist/ng20e2e-ui /usr/share/nginx/html

# Expose port 80
EXPOSE 80
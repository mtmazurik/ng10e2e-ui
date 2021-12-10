# Angular Docker Image; Multi-stage build
# attribution: https://www.indellient.com/blog/how-to-dockerize-an-angular-application-with-nginx/

### STAGE 1: Compile & build ng codebase

FROM node:latest as build

WORKDIR /app

# all of the files
COPY . /app

# Install only production dependencies;  equivalent to:   npm install against /app/package.json
RUN npm ci --only-production

# Generate the build of the app

RUN npm run build

### STAGE 2: Serve app with nginx server

FROM nginx:latest

## From ‘build’ stage copy over the artifacts in dist folder to default nginx public folder
COPY --from=build /app/dist/ng10e2e-ui /usr/share/nginx/html

EXPOSE 80
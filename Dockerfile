# Angular Docker Image; Multi-stage build
# attribution to: https://dev.to/ollita7/dockerizing-an-angular-app-3nef

### STAGE 1: Installing & Building ###

FROM node:current-alpine as builder 

WORKDIR /app

COPY / ./

COPY package.json ./

RUN npm install -g @angular/cli@10.0.7 && \
    npm install && \
    ng build

COPY . .

### STAGE 2: Setup nginx ### pulls (by default) from Dockerhub

FROM nginx:1.17-alpine
WORKDIR /app

## Copy our default nginx config
COPY nginx/default.conf /etc/nginx/conf.d/

## From ‘builder’ stage copy over the artifacts in dist folder to default nginx public folder
COPY --from=builder /app/dist/ng10e2e-ui /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
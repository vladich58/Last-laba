# build environment
FROM node:16-alpine as build
WORKDIR /app
COPY package.json ./
RUN yarn install --silent
COPY . ./
RUN npm run build
# production environment
FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
RUN addgroup -g 1010 -S vladislav && adduser -u 1010 -D -S -G vladislav vladislav 
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

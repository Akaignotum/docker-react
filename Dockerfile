#BUILD PHASE , v- as determines a Block for building phase, next FROM will automatically start a new Block
FROM node:alpine as builder 
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <- will carry all the important stuff for prod build

#RUN PHASE, default command will start nginx
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
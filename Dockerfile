#BUILD PHASE , v- as determines a Block for building phase, next FROM will automatically start a new Block
FROM node:alpine as builder 
WORKDIR /app
COPY package.json .
# COPY package*.json . (CONFIG FOR AWS EBS)
RUN npm install
COPY . .
RUN npm run build

# /app/build <- will carry all the important stuff for prod build

#RUN PHASE, default command will start nginx
FROM nginx
# EXPOSE 80 (CONFIG for porting in AWS EBS)
COPY --from=builder /app/build /usr/share/nginx/html
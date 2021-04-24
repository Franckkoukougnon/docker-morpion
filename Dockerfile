#FROM ubuntu#optionnel

#RUN yarn start
#RUN yarn test 
#RUN yarn build 
#RUN yarn eject
#RUN apt install -y git 
#RUN rm -rf /var/www/html 
#RUN git clone https://github.com/Franckkoukougnon/jeu-morpion-react.git /var/www/html 
#CMD ["nginx", "-g", "daemon off;"] 

# Specify a base image
FROM node:14.5.0 as build-deps

# Create working directory and copy the app before running yarn install as the artifactory
# credentials can be inside .npmrc
WORKDIR /usr/src/app
COPY . ./

# Run yarn install
RUN yarn install

RUN git clone https://github.com/Franckkoukougnon/jeu-morpion-react.git /var/www/html 

# Build the project
CMD ["yarn", "run", "build"]

# Install serve command for yarn package manager
RUN yarn global add serve

# Navigate to build folder
WORKDIR /usr/src/app/build

# Start the application
CMD serve -p 3000 -s . 

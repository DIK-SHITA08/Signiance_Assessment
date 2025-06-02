# Use official Node.js LTS image
FROM node:18

# Create app directory
WORKDIR /usr/src/app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application
COPY . .

# Expose app port
EXPOSE 3000

# Start the app
CMD [ "npm", "start" ]

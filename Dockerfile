# Nodejs LTS
FROM node:18-alpine

# Working directory
WORKDIR /app

# Copy package files to container
COPY todo_app/package*.json ./

# Install application dependencies
RUN npm install

# Copy rest of application code to the container
COPY todo_app/ .

# Port number
EXPOSE 3000

# Run command
CMD ["npm", "start"]

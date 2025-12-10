FROM node:20-slim

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies (Puppeteer will download its own Chromium)
RUN npm install

# Copy application code
COPY index.js .

# Run the script
CMD ["npm", "start"]

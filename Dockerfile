FROM node:20-slim

# Install only essential system libraries for Puppeteer's bundled Chromium
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libnss3 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libx11-xcb1 \
    libxss1 \
    libasound2 \
    libgconf-2-4 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install Node dependencies (Puppeteer will download its own Chromium)
RUN npm install

# Copy application code
COPY index.js .

# Run the script
CMD ["npm", "start"]

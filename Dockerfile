FROM node:20-slim

# Install Chromium and required system dependencies
RUN apt-get update && apt-get install -y \
    chromium-browser \
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

# Install Node dependencies
RUN npm install

# Copy application code
COPY index.js .

# Run the script with dynamically detected Chromium path
CMD ["/bin/bash", "-c", "export PUPPETEER_EXECUTABLE_PATH=$(which chromium-browser) && echo 'Chromium path: $PUPPETEER_EXECUTABLE_PATH' && npm start"]

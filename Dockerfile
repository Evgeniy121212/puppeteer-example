FROM node:20-slim

# Set up Chrome repository
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

# Install Chrome and required dependencies
RUN apt-get update && apt-get install -y \
    google-chrome-stable \
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

# Run the script with dynamically detected Chrome path
CMD ["/bin/bash", "-c", "export PUPPETEER_EXECUTABLE_PATH=$(which google-chrome-stable) && echo 'Chrome path: $PUPPETEER_EXECUTABLE_PATH' && npm start"]

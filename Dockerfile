# Use Node.js LTS Alpine image (smaller base)
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies and clean cache in one layer to reduce image size
RUN npm ci --only=production --no-audit --no-fund && \
    npm cache clean --force && \
    rm -rf /tmp/*

# Copy only necessary application files
COPY server.js ./
COPY public ./public

# Create output directory
RUN mkdir -p output

# Expose port 3000
EXPOSE 3000

# Start the application
CMD ["node", "server.js"]


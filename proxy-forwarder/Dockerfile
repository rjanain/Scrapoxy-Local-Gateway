FROM node:18-alpine

# Enterprise: Set production environment
ENV NODE_ENV=production

WORKDIR /app

# Enterprise: Install dependencies first (caching)
COPY package.json package-lock.json* ./

# Enterprise: Install for production and clear cache (using install since lockfile might be missing)
RUN npm install --only=production && npm cache clean --force

COPY server.js .

# Enterprise: Run as non-root user for security
USER node

CMD ["node", "server.js"]

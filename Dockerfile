# 1. Build React
FROM node:22 AS react-builder
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ .
ARG VITE_API_BASE
ENV VITE_API_BASE=$VITE_API_BASE
RUN npm run build

# 2. Flask (Python API)
FROM python:3.10-slim AS flask-builder
WORKDIR /flask
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY flaskapi.py improved_cnn_model.h5 ./

# 3. Node + Nginx final image
FROM node:22

WORKDIR /app

# --- Copy Node backend ---
COPY package*.json ./
RUN npm install
COPY server.js .

# --- Copy Flask code ---
COPY --from=flask-builder /flask /flask

# --- Copy React build ---
RUN mkdir -p /app/public
COPY --from=react-builder /app/frontend/dist /app/public

# Install process manager
RUN npm install -g concurrently

EXPOSE 8000 5000

# Run Flask + Node together
CMD ["concurrently", "\"python /flask/flaskapi.py\"", "\"node server.js\""]

🚀 Project Setup & Run Guide

This project is a full-stack tyre defect detection system consisting of:

Flask API → Loads CNN model and makes predictions.

Node.js Server → Handles uploads, integrates with Flask, and saves results in MongoDB.

React Frontend → User interface for uploading and viewing reports.

MongoDB Atlas → Stores reports and prediction results.

📂 Project Structure
projectschool21/
│── Digital images of defective and good condition tyres/   # dataset (ignored in Git)
│── Tire Textures/                                         # dataset (ignored in Git)
│── frontend/                                              # React app
│── node_modules/                                          # ignored in Git
│── flaskapi.py                                            # Flask API
│── server.js                                              # Node backend
│── improved_cnn_model.h5                                  # ML model
│── docker-compose.yml                                     # Multi-container setup
│── Dockerfile.flask                                       # Flask image
│── Dockerfile.node                                        # Node image
│── Dockerfile.frontend                                    # React image
│── requirements.txt                                       # Python dependencies
│── package.json                                           # Node dependencies
│── .env                                                   # Environment variables
│── .gitignore

⚙️ Prerequisites

Docker
 installed

Docker Compose
 installed

MongoDB Atlas account (you already have a connection string)

🔑 Environment Variables

Create a .env file in the project root:

# MongoDB Atlas connection
MONGO_URI=mongodb+srv://<username>:<password>@cluster0.mongodb.net/temp

# Flask
MODEL_PATH=improved_cnn_model.h5
FLASK_HOST=0.0.0.0
FLASK_PORT=5000
TARGET_SIZE=128,128
TARGET_LAYER_INDEX=2
HEATMAP_THRESHOLD=0.6

# Node
PORT=8001
FLASK_PREDICT_URL=http://flask:5000/predict

🐳 Running with Docker
1. Build & Start Containers
docker-compose down -v --remove-orphans
docker-compose build --no-cache
docker-compose up -d

2. Verify Containers
docker ps


You should see 3 containers:

flask_api (Flask backend) → port 5000

node_server (Node backend) → port 8001

react_frontend (React app) → port 3000

🌐 Accessing the Services

Flask API (health check) → http://localhost:5000/health

Node backend → http://localhost:8001/

React frontend → http://localhost:3000/

🧪 Testing
Upload an image (via Node API)
curl -X POST http://localhost:8001/uploads \
  -F "image=@sample.jpg" \
  -F "Rn=AB1234" \
  -F "Pn=9876543210"

Check search results
curl "http://localhost:8001/search?registrationNumber=AB1234"

Get all data (table view)
curl http://localhost:8001/getdata

Health Check Flask
curl http://localhost:5000/health

🛠 Development Notes

Ignore large files & datasets → already added in .gitignore

If you change Flask model (.h5) → rebuild only Flask container:

docker-compose build flask && docker-compose up -d flask


If you modify React frontend → rebuild only frontend:

docker-compose build frontend && docker-compose up -d frontend


Logs for debugging:

docker logs flask_api -f
docker logs node_server -f
docker logs react_frontend -f

🧹 Cleanup

To stop and remove everything:

docker-compose down -v --remove-orphans

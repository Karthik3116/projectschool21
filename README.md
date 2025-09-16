# 🚀 Tyre Defect Detection System

A **full-stack system** for detecting tyre defects using deep learning (CNN).  

### Components
- **Flask API** → Loads trained CNN model and serves predictions  
- **Node.js Server** → Handles uploads, integrates with Flask, stores results in MongoDB  
- **React Frontend** → UI for uploading tyres and viewing reports  
- **MongoDB Atlas** → Stores reports & prediction results  

---

## 📂 Project Structure



projectschool21/
│── Digital images of defective and good condition tyres/ # dataset (ignored in Git)
│── Tire Textures/ # dataset (ignored in Git)
│── frontend/ # React app
│── node_modules/ # ignored in Git
│── flaskapi.py # Flask API
│── server.js # Node backend
│── improved_cnn_model.h5 # ML model
│── docker-compose.yml # Multi-container setup
│── Dockerfile.flask # Flask image
│── Dockerfile.node # Node image
│── Dockerfile.frontend # React image
│── requirements.txt # Python dependencies
│── package.json # Node dependencies
│── .env # Environment variables
│── .gitignore


yaml

---

## ⚙️ Prerequisites
- [Docker](https://docs.docker.com/get-docker/) installed  
- [Docker Compose](https://docs.docker.com/compose/) installed  
- MongoDB Atlas account with connection string  

---

## 🔑 Environment Variables

Create a `.env` file in the **project root**:

```env
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
bash
Copy code
docker-compose down -v --remove-orphans
docker-compose build --no-cache
docker-compose up -d
2. Verify Containers
bash
Copy code
docker ps
You should see:

flask_api → Flask backend (port 5000)

node_server → Node backend (port 8001)

react_frontend → React app (port 3000)

🌐 Accessing the Services
Flask API (health check) → http://localhost:5000/health

Node backend → http://localhost:8001/

React frontend → http://localhost:3000/

🧪 Testing
Upload an Image
bash
Copy code
curl -X POST http://localhost:8001/uploads \
  -F "image=@sample.jpg" \
  -F "Rn=AB1234" \
  -F "Pn=9876543210"
Search by Registration Number
bash
Copy code
curl "http://localhost:8001/search?registrationNumber=AB1234"
Get All Data (Table View)
bash
Copy code
curl http://localhost:8001/getdata
Flask Health Check
bash
Copy code
curl http://localhost:5000/health
🛠 Development Notes
Large datasets & models are ignored via .gitignore

To rebuild Flask (if model changes):

bash
Copy code
docker-compose build flask && docker-compose up -d flask
To rebuild React frontend:

bash
Copy code
docker-compose build frontend && docker-compose up -d frontend
Logs for Debugging
bash
Copy code
docker logs flask_api -f
docker logs node_server -f
docker logs react_frontend -f
🧹 Cleanup
Stop and remove everything:

bash
Copy code
docker-compose down -v --remove-orphans
✅ With this setup, you can train, test, and deploy tyre defect detection seamlessly.

yaml
Copy code

---

Do you want me to also include **screenshots placeholders** (like “🖼 Upload Screen”, “📊 Results Table”) so that when you later run the frontend, you can just add them for GitHub presentation?







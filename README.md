Tyre Defect Detection System tyre-defect-detection-system
This is a full-stack application designed to detect defects in tyres using a Convolutional Neural Network (CNN) model. The system allows users to upload tyre images, receive a classification (good or defective), and view a detailed inspection report. The entire application is containerized with Docker for easy setup and deployment.

🚀 Features
AI-Powered Defect Detection: Utilizes a TensorFlow/Keras CNN model to classify tyre conditions.

Full-Stack Architecture: A React frontend, Node.js backend, and a Python/Flask machine learning API.

Persistent Storage: Inspection reports and prediction results are stored in a MongoDB database.

Containerized: Fully containerized using Docker and Docker Compose for a "one-click" setup.

Detailed Reporting: Users can search for and view historical inspection data for any vehicle.

🛠️ Tech Stack & Architecture
The project is composed of three main services orchestrated by Docker Compose:

Flask API (flask-api): A Python-based service that loads the pre-trained improved_cnn_model.h5 and exposes a prediction endpoint.

Node.js Server (node-server): An Express.js server that handles file uploads, communicates with the Flask API for predictions, and manages data persistence with MongoDB.

React Frontend (react-frontend): A user interface built with Vite and React for uploading images and viewing inspection reports.

MongoDB: A NoSQL database for storing all application data. For this setup, we'll use a MongoDB Atlas cloud instance.

⚙️ Prerequisites
Before you begin, ensure you have the following installed on your system:

Docker

Docker Compose (usually included with Docker Desktop)

A MongoDB Atlas account and a connection string. You can create a free cluster here.

🔑 Setup & Configuration
Clone the Repository

Bash

git clone https://github.com/your-username/tyre-defect-detection-system.git
cd tyre-defect-detection-system
Create the Environment File
Create a file named .env in the root of the project directory and populate it with the following variables. Remember to replace the MongoDB Atlas placeholder with your actual connection string.

Code snippet

# MongoDB Atlas connection string
MONGO_URI=mongodb+srv://<username>:<password>@cluster0.mongodb.net/yourDatabaseName

# Flask API Configuration
MODEL_PATH=improved_cnn_model.h5
FLASK_HOST=0.0.0.0
FLASK_PORT=5000
TARGET_SIZE=128,128
TARGET_LAYER_INDEX=2
HEATMAP_THRESHOLD=0.6

# Node.js Server Configuration
PORT=8001
FLASK_PREDICT_URL=http://flask-api:5000/predict
Note: The FLASK_PREDICT_URL uses the service name flask-api instead of localhost. This is how containers communicate within the Docker network.

🐳 Running the Application with Docker
With Docker and your .env file configured, you can start the entire application stack with a single command.

Build and Start the Containers
Open a terminal in the project root and run the following command. This will build the images for each service and start them in detached mode (-d).

Bash

docker-compose up --build -d
Verify the Containers are Running
Check the status of your containers:

Bash

docker ps
You should see three containers running, similar to the output below:

CONTAINER ID	IMAGE	COMMAND	STATUS	PORTS	NAMES
xxxx	tyre-defect-system_react-frontend	nginx -g 'daemon of...'	Up 2 minutes	0.0.0.0:3000->80/tcp	react-frontend
yyyy	tyre-defect-system_node-server	docker-entrypoint.s...	Up 2 minutes	0.0.0.0:8001->8001/tcp	node-server
zzzz	tyre-defect-system_flask-api	python -u ./flaskap...	Up 2 minutes	0.0.0.0:5000->5000/tcp	flask-api

Export to Sheets
🌐 Accessing the Services
Once the containers are running, you can access the different parts of the application:

React Frontend: Open your browser to http://localhost:3000

Node.js Backend: Accessible at http://localhost:8001

Flask API: Accessible at http://localhost:5000

🧪 API Testing with cURL
You can test the backend functionality directly using cURL commands from your terminal.

Action	Command
Upload an Image	curl -X POST http://localhost:8001/uploads -F "image=@/path/to/your/tyre.jpg" -F "Rn=KA01AB1234" -F "Pn=9876543210"
Search by Vehicle	curl "http://localhost:8001/search?registrationNumber=KA01AB1234"
Get All Data	curl http://localhost:8001/getdata
Health Check (Flask)	curl http://localhost:5000/health

Export to Sheets
🛠️ Development Workflow
Live Reloading: During development, volumes are mounted to sync your local code changes into the containers automatically. The Node.js and React services will hot-reload.

Rebuilding a Specific Service: If you make changes that require a full rebuild (e.g., installing new dependencies or changing the Dockerfile), you can rebuild a single service without affecting the others.

Bash

# Rebuild only the Flask container
docker-compose build flask-api && docker-compose up -d --no-deps flask-api

# Rebuild only the React frontend
docker-compose build react-frontend && docker-compose up -d --no-deps react-frontend
Viewing Logs: To debug or monitor a specific service, you can tail its logs.

Bash

# View logs for the Flask API
docker logs -f flask-api

# View logs for the Node server
docker logs -f node-server
🧹 Cleanup
To stop and completely remove all containers, networks, and volumes created by Docker Compose, run:

Bash

docker-compose down -v







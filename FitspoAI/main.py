from fastapi import FastAPI, UploadFile, File
from PIL import Image
import torch
from ultralytics import YOLO
import io

app = FastAPI()

model = YOLO("yolov8n.pt")

@app.post("/detect/")
async def detect_clothing(file: UploadFile = File(...)):
    contents = await file.read()
    image = Image.open(io.BytesIO(contents))
    
    results = model(image)
    
    detections = []
    
    for result in results:
        for box in result.boxes:
            confidence = float(box.conf[0])
            label_id = int(box.cls[0])
            label = model.names[label_id]
            
            if confidence > 0.5:
                detections.append({
                    "label": label,
                    "confidence": confidence,
                    "box": box.xyxy[0].tolist()
                })
            
    return {"detections": detections}

//
//  DetectionViewModel.swift
//  Fitspo
//
//  Created by Dylan Luo on 2/19/26.
//

import Foundation

struct DetectionResult: Codable, Identifiable {
    var id: UUID { UUID() }
    let label: String
    let confidence: Double
    let box: [Double]
}

struct DetectionResponse: Codable {
    let detections: [DetectionResult]
}

class DetectionViewModel: ObservableObject {
    
    @Published var detections: [DetectionResult] = []
    @Published var isLoading = false
    
    func uploadImage(_ imageData: Data) {
        guard let url = URL(string: "http://127.0.0.1:8000/detect/") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        isLoading = true
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            guard let data = data else { return }

            if let responseString = String(data: data, encoding: .utf8) {
                print("Server response:", responseString)
            }

            
            if let decoded = try? JSONDecoder().decode(DetectionResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.detections = decoded.detections
                }
            }
        }
        .resume()
    }
    
}

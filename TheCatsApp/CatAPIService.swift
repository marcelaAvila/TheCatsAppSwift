//
//  CatAPIService.swift
//  TheCatsApp
//
//  Created by Marcela Avila Beltran on 8/06/23.
//

import Foundation

class CatAPIService {
    private let apiKey = "bda53789-d59e-46cd-9bc4-2936630fde39" // API-Key proporcionada

    func fetchBreeds(completion: @escaping ([Cat.infoCat]?, Error?) -> Void) {
        let urlString = "https://api.thecatapi.com/v1/breeds"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                return
            }
            
            do {
                let breeds = try JSONDecoder().decode([Cat.infoCat].self, from: data)
                completion(breeds, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    func fetchCatImage(withReferenceID referenceID: String, completion: @escaping (String?, Error?) -> Void) {
        let urlString = "https://api.thecatapi.com/v1/images/\(referenceID)"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("x-api-key", forHTTPHeaderField: apiKey)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let imageURLString = json?["url"] as? String {
                    completion(imageURLString, nil)
                } else {
                    completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Image URL not found"]))
                }
            } catch {
                completion(nil, error)
            }
        }.resume()
    }

}

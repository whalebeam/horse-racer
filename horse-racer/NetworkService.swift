//
//  NetworkService.swift
//  horse-racer
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case unableToParse
    case invalidStatusCode(Int)
    case invalidResponse
    case server
    case unknown
}

// TODO: Make generic/tidy up

final class NetworkService {
    
    private static var baseURL = "https://reqres.in/api/"
    
    func fetch(url: URL, completion: @escaping (Result<Race, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            let decoder = JSONDecoder()
            
            guard error == nil else {
                completion(.failure(.server))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completion(.failure(.invalidStatusCode(response.statusCode)))
                return
            }
            
            guard let d = data, let modelData = try? decoder.decode(Race.self, from: d) else {
                completion(.failure(.unableToParse))
                return
            }
            
            // success
            
            completion(.success(modelData))
            
        }.resume()
        
    }
    
}

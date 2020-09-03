//
//  NetworkService.swift
//  horse-racer
//

import Foundation

enum NetworkError: Swift.Error {
    case invalidURL
    case unableToParse
    case statusCode
    case server
    case unknown
}

// TODO: Make generic/tidy up

final class NetworkService {
    
    func fetch(url: URL, completion: @escaping (Result<Race, NetworkError>) -> Void) {
        
        let urlr = URL(string: "https://reqres.in/api/users?page=2")!
        
        URLSession.shared.dataTask(with: urlr) { (data, response, error) in
            
            let decoder = JSONDecoder()
            
            guard error == nil else {
                completion(.failure(.server))
                return
            }
            
            guard let res = response as? HTTPURLResponse, res.statusCode == 200 else {
                completion(.failure(.statusCode))
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

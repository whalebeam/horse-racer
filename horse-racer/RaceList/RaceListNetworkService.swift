//
//  RaceListNetworkService.swift
//  horse-racer
//

import Foundation


// TODO: Fix networking to pull in from a local json file

final class RaceListNetworkService {
    
    var isUnitTest: Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
    
    var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    func fetch(url: URL, completion: @escaping (Result<[Race], NetworkError>) -> Void) {
    
        if isUnitTest || isDebug {
            
            let json = loadJson(filename: "races_example")
            
            guard let model = json else {
                completion(.failure(.invalidResponse))
                return
            }
            
            completion(.success(model))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            guard error == nil else {
                completion(.failure(.server))
                return
            }

            guard let res = response as? HTTPURLResponse, res.statusCode == 200 else {
                completion(.failure(.invalidStatusCode(500)))
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

            guard let d = data, let model = try? decoder.decode([Race].self, from: d) else {
                completion(.failure(.unableToParse))
                return
            }
            
            completion(.success(model))
            
        }.resume()
        
    }
}

extension RaceListNetworkService {
    
    func loadJson(filename fileName: String) -> [Race]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let jsonData = try decoder.decode([Race].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
}

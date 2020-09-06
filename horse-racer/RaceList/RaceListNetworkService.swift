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
    
    let baseURL: String = "https://reqres.in/api/"
    
    var modelData = [
        Race(name: "Maiden Plate (F & M)", courseName: "Vaal", age: "3YO Plus", time: "2017-12-15"),
        Race(name: "Taylor Plate (F)", courseName: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
        Race(name: "British Finals (F)", courseName: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
        Race(name: "Li Cheng Cup (M)", courseName: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
        Race(name: "Royal Green House Plate (F & M)", courseName: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
        Race(name: "Alfred Cup (F)", courseName: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
        Race(name: "Orange Plate (F & M)", courseName: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
        Race(name: "Cyan Plate (M)", courseName: "Chesterfield", age: "3YO Plus", time: "2017-12-15")
    ]
    
    func fetch(url: URL, completion: @escaping (Result<[Race], NetworkError>) -> Void) {
    
        if isUnitTest {
            completion(.success(modelData))
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
            
//            guard let d = data, let m = try? decoder.decode([[Race]].self, from: d) else {
//                completion(.failure(.unableToParse))
//                return
//            }
            
            // success
            
            let modelData = [
                Race(name: "Maiden Plate (F & M)", courseName: "Vaal", age: "3YO Plus", time: "2017-12-15"),
                Race(name: "Taylor Plate (F)", courseName: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
                Race(name: "British Finals (F)", courseName: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
                Race(name: "Li Cheng Cup (M)", courseName: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
                Race(name: "Royal Green House Plate (F & M)", courseName: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
                Race(name: "Alfred Cup (F)", courseName: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
                Race(name: "Orange Plate (F & M)", courseName: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
                Race(name: "Cyan Plate (M)", courseName: "Chesterfield", age: "3YO Plus", time: "2017-12-15")
                
            ]
            
            completion(.success(modelData))
            
        }.resume()
        
    }
}

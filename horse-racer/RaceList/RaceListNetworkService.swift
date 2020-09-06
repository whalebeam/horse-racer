//
//  RaceListNetworkService.swift
//  horse-racer
//

import Foundation


// TODO: Fix networking to pull in from a local json file

final class RaceListNetworkService {
    
    var isDebug: Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
    
    private let modelData = [
        Race(name: "Maiden Plate (F & M)", course_name: "Vaal", age: "3YO Plus", time: "2017-12-15"),
        Race(name: "Taylor Plate (F)", course_name: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
        Race(name: "British Finals (F)", course_name: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
        Race(name: "Li Cheng Cup (M)", course_name: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
        Race(name: "Royal Green House Plate (F & M)", course_name: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
        Race(name: "Alfred Cup (F)", course_name: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
        Race(name: "Orange Plate (F & M)", course_name: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
        Race(name: "Cyan Plate (M)", course_name: "Chesterfield", age: "3YO Plus", time: "2017-12-15")
        
    ]
    
    func fetch(url: URL, completion: @escaping (Result<[Race], NetworkError>) -> Void) {
            
        let urlr = URL(string: "https://reqres.in/api/users?delay=1")!
    
        if isDebug {
            completion(.success(modelData))
            return
        }
        
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
            
//            guard let d = data, let m = try? decoder.decode([[Race]].self, from: d) else {
//                completion(.failure(.unableToParse))
//                return
//            }
            
            // success
            
            let modelData = [
                Race(name: "Maiden Plate (F & M)", course_name: "Vaal", age: "3YO Plus", time: "2017-12-15"),
                Race(name: "Taylor Plate (F)", course_name: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
                Race(name: "British Finals (F)", course_name: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
                Race(name: "Li Cheng Cup (M)", course_name: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
                Race(name: "Royal Green House Plate (F & M)", course_name: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
                Race(name: "Alfred Cup (F)", course_name: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
                Race(name: "Orange Plate (F & M)", course_name: "Chesterfield", age: "3YO Plus", time: "2017-12-15"),
                Race(name: "Cyan Plate (M)", course_name: "Chesterfield", age: "3YO Plus", time: "2017-12-15")
                
            ]
            
            completion(.success(modelData))
            
        }.resume()
        
    }
}

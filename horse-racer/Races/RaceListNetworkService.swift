//
//  RaceListNetworkService.swift
//  horse-racer
//
//  Created by David Gray on 04/09/2020.
//  Copyright © 2020 whalebeam. All rights reserved.
//

import Foundation


final class RaceListNetworkService {
    
    func fetch(url: URL, completion: @escaping (Result<[Race], NetworkError>) -> Void) {
            
            let urlr = URL(string: "https://reqres.in/api/users")!
            
            URLSession.shared.dataTask(with: urlr) { (data, response, error) in
                
//                let decoder = JSONDecoder()
                
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
                
                
                let modelData = [
                    Race(name: "Maiden Plate (F & M)", course_name: "Vaal", age: "3YO Plus", time: "2017-12-15"),
                    Race(name: "Taylor Plate (F)", course_name: "Chesterfield", age: "3YO Plus", time: "2017-12-15")
                    
                ]
                
                // success
                
                completion(.success(modelData))
                
            }.resume()
            
        }
    
}

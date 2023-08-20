//
//  URLSessionServiceManager.swift
//  MVVMTMDB
//
//  Created by Cenk Bahadır Çark on 20.08.2023.
//

import Foundation

final class URLSessionServiceManager: Networking {
    func fetchData<T>(endpoint: APIEndPoint, parameters: [Parameter], completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
        var components = URLComponents(string: Constant.baseURL + endpoint.rawValue)
        components?.queryItems = parameters.map { $0.queryItem }
        
        guard let url = components?.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            }catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
    
    
}

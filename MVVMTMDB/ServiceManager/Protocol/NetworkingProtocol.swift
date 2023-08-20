//
//  NetworkingProtocol.swift
//  MVVMTMDB
//
//  Created by Cenk Bahadır Çark on 20.08.2023.
//

import Foundation

protocol Networking {
    func fetchData<T: Decodable>(endpoint: APIEndPoint, parameters: [Parameter], completion: @escaping (Result<T, Error>) -> Void)
}

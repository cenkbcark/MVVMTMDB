//
//  MainDataProviderProtocol.swift
//  MVVMTMDB
//
//  Created by Cenk Bahadır Çark on 20.08.2023.
//

import Foundation

final class MainDataProvider: MainDataProviderProtocol {
    
    private let serviceManager: Networking
    
    init(serviceManager: Networking) {
        self.serviceManager = serviceManager
    }
    
    func fetchPopularMovies(endPoint: APIEndPoint, parameters: [Parameter], completion: @escaping (Result<PopularMovieModel, Error>) -> Void) {
        serviceManager.fetchData(endpoint: endPoint, parameters: parameters, completion: completion)
    }
    func fetchNowPlayingMovies(endPoint: APIEndPoint, parameters: [Parameter], completion: @escaping (Result<NowPlayingMovieResponse, Error>) -> Void) {
        serviceManager.fetchData(endpoint: endPoint, parameters: parameters, completion: completion)
    }
    
}

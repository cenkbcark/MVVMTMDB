//
//  MainDataProvider.swift
//  MVVMTMDB
//
//  Created by Cenk Bahadır Çark on 20.08.2023.
//

import Foundation

protocol MainDataProviderProtocol {
    func fetchPopularMovies(endPoint: APIEndPoint, parameters: [Parameter], completion: @escaping (Result<PopularMovieModel, Error>) -> Void)
    func fetchNowPlayingMovies(endPoint: APIEndPoint, parameters: [Parameter], completion: @escaping (Result<NowPlayingMovieResponse, Error>) -> Void)
}

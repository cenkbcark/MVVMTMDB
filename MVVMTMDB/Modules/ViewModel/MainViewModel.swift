//
//  MainViewModel.swift
//  MVVMTMDB
//
//  Created by Cenk Bahadır Çark on 20.08.2023.
//

import Foundation

final class MainViewModel: MainViewModelProtocol {
    weak var delegate: MainViewModelDelegate?
    var popularMovies: [PopularResultMovie] = []
    var nowPlayingMovies: [NowPlayingResultMovie] = []
    var cellType: [TableCellType] = []
    
    private let dataProvider: MainDataProviderProtocol
    
    init(dataProvider: MainDataProviderProtocol) {
        self.dataProvider = dataProvider
        self.cellType.append(.profile)
        self.cellType.append(.premium)
    }
    
    func fetchPopularMovies() {
        dataProvider.fetchPopularMovies(endPoint: .popular, parameters: [.apiKey("87fd921402216fc7603c5c63d278f30c"), .page("1")]) { result in
            switch result {
            case .success(let success):
                if let movies = success.results {
                    self.popularMovies = movies
                    self.cellType.append(.popular)
                    self.notify(with: .didFetchPopular)
                }else {
                    self.notify(with: .errorFetchPopular(error: "An error occured while listing popular movies."))
                    self.notify(with: .reloadTableView)
                }
            case .failure(let error):
                self.notify(with: .errorFetchPopular(error: error.localizedDescription))
            }
        }
    }
    
    func fetchNowPlayingMovies() {
        dataProvider.fetchNowPlayingMovies(endPoint: .nowPlaying, parameters: [.apiKey("87fd921402216fc7603c5c63d278f30c"), .page("1")]) { result in
            switch result {
            case .success(let success):
                if let movies = success.results {
                    self.nowPlayingMovies = movies
                    self.cellType.append(.nowPlaying)
                    self.notify(with: .didFetchNowPlaying)
                }else {
                    self.notify(with: .errorFetchNowPlaying(error: "An error occured while listing now playing movies."))
                    self.notify(with: .reloadTableView)
                }
            case .failure(let error):
                self.notify(with: .errorFetchNowPlaying(error: error.localizedDescription))
            }
        }
    }
    
    private func notify(with notify: MainViewNotify) {
        DispatchQueue.main.async {
            self.delegate?.handle(notify: notify)
        }
    }
}

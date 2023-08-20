//
//  MainViewModelProtocol.swift
//  MVVMTMDB
//
//  Created by Cenk Bahadır Çark on 20.08.2023.
//

import Foundation

protocol MainViewModelProtocol {
    var delegate: MainViewModelDelegate? { get set }
    var popularMovies: [PopularResultMovie] { get set}
    var nowPlayingMovies: [NowPlayingResultMovie] { get set }
    var cellType: [TableCellType] { get set }
    
    func fetchPopularMovies()
    func fetchNowPlayingMovies()
}

protocol MainViewModelDelegate: AnyObject {
    func handle(notify: MainViewNotify)
}

enum MainViewNotify {
    case didFetchPopular
    case didFetchNowPlaying
    case errorFetchPopular(error: String)
    case errorFetchNowPlaying(error: String)
    case reloadTableView
}

enum TableCellType {
    case profile
    case premium
    case popular
    case nowPlaying
}

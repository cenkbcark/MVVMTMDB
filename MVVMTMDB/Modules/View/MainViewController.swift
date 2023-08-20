//
//  MainViewController.swift
//  MVVMTMDB
//
//  Created by Cenk Bahadır Çark on 20.08.2023.
//

import UIKit

final class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MainViewModelProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        registerCellsForTableView()
        viewModel?.fetchPopularMovies()
    }
    
    private func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerCellsForTableView() {
        
        let profileCellName = String(describing: ProfileCell.self)
        let profileCellNib = UINib(nibName: profileCellName, bundle: .main)
        tableView.register(profileCellNib, forCellReuseIdentifier: profileCellName)
        
        let premiumCellName = String(describing: PremiumCell.self)
        let premiumCellNib = UINib(nibName: premiumCellName, bundle: .main)
        tableView.register(premiumCellNib, forCellReuseIdentifier: premiumCellName)
        
        let popularCellName = String(describing: PopularCell.self)
        let popularCellNib = UINib(nibName: popularCellName, bundle: .main)
        tableView.register(popularCellNib, forCellReuseIdentifier: popularCellName)
    }

}
extension MainViewController: MainViewModelDelegate {
    func handle(notify: MainViewNotify) {
        switch notify {
        case .didFetchPopular:
            tableView.reloadData()
        case .didFetchNowPlaying:
            tableView.reloadData()
        case .errorFetchPopular(error: let error):
            print(error)
        case .errorFetchNowPlaying(error: let error):
            print(error)
        case .reloadTableView:
            tableView.reloadData()
        }
    }
}
extension MainViewController: UITableViewDelegate {
    
}
extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let cellTypeCount = viewModel?.cellType.count else { return 0 }
        return cellTypeCount
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = viewModel?.cellType[section]
        else { return 0 }
        
        switch section {
        case .profile:
            return 1
        case .premium:
            return 1
        case .popular:
            return 1
        case .nowPlaying:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = viewModel?.cellType[indexPath.section] else {
            return UITableViewCell()
        }
        switch section {
        case .profile:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileCell {
                return cell
            }
        case .premium:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PremiumCell", for: indexPath) as? PremiumCell {
                return cell
            }
        case .popular:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PopularCell", for: indexPath) as? PopularCell {
                cell.preparePopular(with: viewModel?.popularMovies)
                return cell
            }
        case .nowPlaying:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PopularCell", for: indexPath) as? PopularCell {
                cell.preparePopular(with: viewModel?.popularMovies)
                return cell
            }
        }
        return UITableViewCell()
    }
}

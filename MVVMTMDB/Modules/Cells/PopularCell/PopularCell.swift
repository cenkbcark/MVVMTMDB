//
//  PopularCell.swift
//  MVVMTMDB
//
//  Created by Cenk Bahadır Çark on 20.08.2023.
//

import UIKit

final class PopularCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var movieList: [PopularResultMovie]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareCollectionView()
        registerPopularCell()
    }
    
    private func prepareCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func registerPopularCell() {
            let cellIdentifier = String(describing: PopularCollectionCell.self)
            let nib = UINib(nibName: cellIdentifier, bundle: .main)
            collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        }
    
    func preparePopular(with model: [PopularResultMovie]?) {
        self.movieList = model
        collectionView.reloadData()
    }
}
extension PopularCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let list = movieList?.count else { return 0 }
        return list
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionCell", for: indexPath) as? PopularCollectionCell {
            cell.prepareCell(movieList?[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

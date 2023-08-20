//
//  PopularCollectionCell.swift
//  MVVMTMDB
//
//  Created by Cenk Bahadır Çark on 20.08.2023.
//

import UIKit

final class PopularCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak private var movieImageView: UIImageView!
    @IBOutlet weak private var favoriteContainerView: UIView!
    @IBOutlet weak private var movieNameLbl: UILabel!
    @IBOutlet weak private var movieRateLbl: UILabel!
    @IBOutlet weak private var blueView: UIVisualEffectView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        
    }
    
    func prepareCell(_ model: PopularResultMovie?) {
        guard let model = model else { return }
        self.movieNameLbl.text = model.originalTitle
        self.movieRateLbl.text = "\(model.voteAverage)"
    }
    
    private func configureCell() {
        favoriteContainerView.layer.cornerRadius = 20
        movieImageView.layer.cornerRadius = 20
        roundCorner()
    }

    private func roundCorner() {
        let cornerRadius: CGFloat = 20
        let maskPath = UIBezierPath(
            roundedRect: blueView.bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        blueView.layer.mask = maskLayer
    }
    
}

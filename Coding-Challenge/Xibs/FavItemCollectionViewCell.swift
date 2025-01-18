//
//  FavItemCollectionViewCell.swift
//  Coding-Challenge
//
//  Created by Waqar Shoukat on 26/11/2024.
//

import UIKit

class FavItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    
    static let cellIdentifier = "FavItemCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureMovieCell(_ movieModel: MoviesResult?) {
        movieName.text = movieModel?.collectionName
        
        //MARK: - Show Movies Images
        let movieURL = URL(string: movieModel?.artworkUrl100 ?? "")
        imgView.sd_setImage(with: movieURL, placeholderImage: UIImage(named: "Image-Placeholder"))
        imgView.contentMode = .scaleAspectFill
        imgView.setRounded()
    }

}

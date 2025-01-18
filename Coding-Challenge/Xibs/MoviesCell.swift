//
//  MoviesCell.swift
//  Coding-Challenge
//
//  Created by Waqar Shoukat on 25/11/2024.
//

import UIKit
import SDWebImage

class MoviesCell: UITableViewCell {
    
//    MARK: - Outlets
    
    @IBOutlet private weak var mainBGview: UIView!
    @IBOutlet private weak var moviesImg: UIImageView!
    @IBOutlet private weak var artistName: UILabel!
    @IBOutlet private weak var movieGenre: UILabel!
    @IBOutlet private weak var movieDuration: UILabel!
    @IBOutlet private weak var movieName: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    
    static let cellIdentifier = "MoviesCell"
    var movie: MoviesResult?
    var updateFavorite: ((MoviesResult?) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureMovieCell(_ movieModel: MoviesResult?) {
        movie = movieModel
        movieName.text = movieModel?.collectionName
        artistName.text = movieModel?.artistName
        movieGenre.text = movieModel?.primaryGenreName
        
        //MARK: - Show Movies Images
        let movieURL = URL(string: movieModel?.artworkUrl100 ?? "")
        moviesImg.sd_setImage(with: movieURL, placeholderImage: UIImage(named: "Image-Placeholder"))
    }
    
    @IBAction func favButtonClicked(_ sender: Any) {
        self.movie?.isFavorite.toggle()
        let imageName = (movie?.isFavorite == true) ? "heart.fill" : "heart"
        favButton.setImage(UIImage(systemName: imageName), for: .normal)
        updateFavorite?(movie)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

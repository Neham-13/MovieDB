//
//  MovieCollectionViewCell.swift
//  MovieDB
//
//  Created by Neha2 Mishra on 11/05/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImgView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpMovieCell(details: MovieViewModel) {
        handleImage(details: details)
        movieTitleLabel.text = "  \(details.title ?? "")"
    }

    private func handleImage(details: MovieViewModel) {
        guard let imageUri = details.imageUrl else {
            return
        }
        if let image = CacheManager.shared.getImage(identifier: imageUri) {
            movieImgView.image = image
        } else {
            let imageUrl = URL(string: StringConstants.imageBaseURL + imageUri)! 
            URLSession.shared.dataTask(with: imageUrl, completionHandler: { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() { [weak self] in
                    if let image = UIImage(data: data) {
                        self?.movieImgView.image = image
                        CacheManager.shared.cacheImage(image: image, identifier: imageUri)
                    }
                }
            }).resume()
        }
    }
}

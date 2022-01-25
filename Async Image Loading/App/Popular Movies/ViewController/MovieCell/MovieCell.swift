//
//  MovieCell.swift
//  Async Image Loading
//
//  Created by Sachin Ambegave on 26/01/22.
//

import UIKit

class MovieCell: UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    @IBOutlet private var titleLabel: UILabel!
    
    @IBOutlet private var thumbnailImageView: UIImageView!
    
    @IBOutlet private var activityIndicatorView: UIActivityIndicatorView!
    
    private lazy var imageLoader = ImageLoader()
    
    private var imageRequest: Cancellable?

    func configure(_ movie: MovieCellModel) {
        titleLabel.text = movie.title
        
        activityIndicatorView.startAnimating()
        thumbnailImageView.image = movie.image
        // Request Image Using Image Loader if image from movie model is not a placeholder image
        if movie.image == PopularMoviesViewModel.placeholderImage {
            imageRequest = imageLoader.load(for: movie, completion: { [weak self] fetchedMovie, fetchedImage in
                // update the model if the same image does not already exists for that movie model
                if let img = fetchedImage, fetchedMovie.image != img {
                    movie.image = img
                    self?.thumbnailImageView.image = img
                }
            })
        }
    }

    // MARK: - Overrides

    override func prepareForReuse() {
        super.prepareForReuse()

        thumbnailImageView.image = nil
        
        // Cancel Image Request
        imageRequest?.cancel()
    }
}

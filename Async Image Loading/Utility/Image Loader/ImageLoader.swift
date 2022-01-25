//
//  ImageLoader.swift
//  Async Image Loading
//
//  Created by Sachin Ambegave on 26/01/22.
//

import UIKit.UIImage

final class ImageLoader {
    func load(for movie: MovieCellModel, completion: @escaping (MovieCellModel, UIImage?) -> Void) -> Cancellable {
        let task = URLSession.shared.dataTask(with: movie.posterURL!) { data, _, _ in
            var image: UIImage?
            defer {
                // Execute Handler on Main Thread
                DispatchQueue.main.async {
                    // pass back the image and update the movie model
                    completion(movie, image)
                }
            }

            print("#Async image download started for : \(movie.posterURL!.absoluteString)")

            if let data = data, let img = UIImage(data: data) {
                image = img
            }
        }
        task.resume()

        return task
    }
}

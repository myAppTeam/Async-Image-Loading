//
//  PopularMoviesViewModel.swift
//  Async Image Loading
//
//  Created by Sachin Ambegave on 25/01/22.
//

import Foundation
import UIKit.UIImage

struct PopularMoviesViewModel {
    var popularMovies: Observable<[MovieCellModel]> = Observable([])
    static let placeholderImage = UIImage(systemName: "rectangle")!
    
    func loadMovies() {
        let path = Bundle.main.path(forResource: "movies", ofType: "json")!
        let data = FileManager.default.contents(atPath: path)!
        let movies = try! JSONDecoder().decode([Movie].self, from: data)
        
        let popularMoviesValue = movies.compactMap {
            MovieCellModel(id: $0.id, title: $0.title, overview: $0.overview, poster: $0.poster, image: PopularMoviesViewModel.placeholderImage)
        }
        
        popularMovies.value = popularMoviesValue
    }
}

//
//  Movie.swift
//  Async Image Loading
//
//  Created by Sachin Ambegave on 25/01/22.
//

import Foundation
import UIKit.UIImage

struct Movie {
    let id: Int
    let title: String
    let overview: String
    let poster: String
}

extension Movie: Hashable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Movie: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case poster = "poster_path"
    }
}

class MovieCellModel {
    let id: Int
    let title: String
    let overview: String
    let poster: String
    var image: UIImage

    init(id: Int, title: String, overview: String, poster: String, image: UIImage) {
        self.id = id
        self.title = title
        self.overview = overview
        self.poster = poster
        self.image = image
    }

    public var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(poster)")!
    }
}

enum Section {
    case main
}

extension MovieCellModel: Hashable {
    static func == (lhs: MovieCellModel, rhs: MovieCellModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

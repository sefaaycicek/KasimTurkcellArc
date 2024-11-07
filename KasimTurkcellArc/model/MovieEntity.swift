//
//  MovieEntity.swift
//  KasimTurkcellArc
//
//  Created by Sefa Aycicek on 7.11.2024.
//

import UIKit

class MovieResponse : Codable {
    let success : Bool
    let result : [MovieEntity]
    
    init(success: Bool, result: [MovieEntity]) {
        self.success = success
        self.result = result
    }
}

class MovieEntity: Codable {
    let title : String
    let year : String
    let type : String
    let poster : String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
    }
    
    init(title: String, year: String, type: String, poster: String) {
        self.title = title
        self.year = year
        self.type = type
        self.poster = poster
    }
}

class MovieUIModel {
    let title : String
    let year : String
    let poster : String
    
    init(title: String, year: String, poster: String) {
        self.title = title
        self.year = year
        self.poster = poster
    }
    
    init (from movie: MovieEntity) {
        self.title = movie.title
        self.year = movie.year
        self.poster = movie.poster
    }
    
    var url : URL? {
        return URL(string: poster)
    }
}

//
//  Endpoints.swift
//  KasimTurkcellArc
//
//  Created by Sefa Aycicek on 7.11.2024.
//

import UIKit

enum Endpoints: String {
    case post = "posts"
    case movie = "imdbSearchByName?query="
    
    var asPostUrl : URL {
        return URL(string: Constants.postBaseURL + rawValue)!
    }
    
    func asMovieUrl(query: String)-> URL {
        return URL(string: Constants.movieBaseURL + rawValue + "\(query)")!
    }
}

class Constants {
    static let postBaseURL: String = "https://jsonplaceholder.typicode.com/"
    static let movieBaseURL: String = "https://api.collectapi.com/imdb/"
    
    static var apiKey = "apikey 5IlsFwtkraxsj2NtgYY4sS:7CfJyGGSTlxLJWAEXmIbf"
}

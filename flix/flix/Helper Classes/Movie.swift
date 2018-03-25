//
//  Movie.swift
//  flix
//
//  Created by Angel Chara'e Mitchell on 3/25/18.
//  Copyright © 2018 Angel Chara'e Mitchell. All rights reserved.
//

import Foundation
class Movie {
    var title: String
    var posterUrl: URL?
    var backdropUrl: URL?
    var overview: String
    var release_date: String
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No Description"
        release_date = (dictionary["release_date"] as? String)!
        
        let baseURLString = "https://image.tmdb.org/t/p/w500/"
        let posterPath = dictionary["poster_path"] as! String
        posterUrl = URL(string: baseURLString + posterPath)!
        
        
        let backdropPath = dictionary["backdrop_path"] as? String ?? "No title"
        backdropUrl = URL(string: baseURLString + backdropPath)

    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        return movies
    }
}

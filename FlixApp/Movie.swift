//
//  Movie.swift
//  FlixApp
//
//  Created by Harika Lingareddy on 2/12/18.
//  Copyright © 2018 Harika Lingareddy. All rights reserved.
//

import Foundation


class Movie {
    var title: String
    var posterUrl: URL?
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        
        // Set the rest of the properties
    }
}

class func movies(dictionaries: [[String: Any]]) -> [Movie] {
    var movies: [Movie] = []
    for dictionary in dictionaries {
        let movie = Movie(dictionary: dictionary)
        movies.append(movie)
    }
    
    return movies
}

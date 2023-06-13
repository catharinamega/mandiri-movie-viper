//
//  Movie.swift
//  Mandiri-Movie-Viper
//
//  Created by Catharina Adinda Mega Cahyani on 12/06/23.
//

import Foundation

struct MovieResponse: Decodable{
    let results: [Movie]
}

struct Movie: Decodable, Hashable{
    
    let genres: [Genre]?
    let id:Int?
    let title:String?
    let backdropPath: String?
    let posterPath: String?
    let overview: String?
    let voteAverage: Double?
    let voteCount: Int?
    let runtime: Int?
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id // Compare based on a unique identifier, such as the movie ID
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // Use the movie ID to generate the hash value
    }
}



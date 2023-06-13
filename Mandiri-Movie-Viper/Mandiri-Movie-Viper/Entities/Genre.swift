//
//  Movie.swift
//  Mandiri-Movie-Viper
//
//  Created by Catharina Adinda Mega Cahyani on 12/06/23.
//

import Foundation

struct GenreResponse: Decodable{
    let genres : [Genre]
}

struct Genre: Decodable{
    
    let id:Int?
    let name:String?
    var movies:[Movie]?
}

//
//  Review.swift
//  Mandiri-Movie-Viper
//
//  Created by Catharina Adinda Mega Cahyani on 13/06/23.
//

import Foundation
struct ReviewResponse: Decodable{
    let results : [Review]
}

struct Review: Decodable, Identifiable{
    
//    idnya dari id movie
//    let id:Int?
    let id: String?
    let author:String?
    let content:String?
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // Use the movie ID to generate the hash value
    }
    

}

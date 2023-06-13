//
//  Genre+Stub.swift
//  Mandiri-Movie-Viper
//
//  Created by Catharina Adinda Mega Cahyani on 12/06/23.
//

import Foundation

extension Genre {
    
    static var stubbedGenres: [Genre] {
        let response: GenreResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_genres")
        return response!.genres
    }
    
    static var stubbedGenre: Genre {
        stubbedGenres[0]
    }
    
}

//extension Bundle {
//    
//    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
//        guard let url = self.url(forResource: filename, withExtension: "json") else {
//            return nil
//        }
//        let data = try Data(contentsOf: url)
//        let jsonDecoder = Utils.jsonDecoder
//        let decodedModel = try jsonDecoder.decode(D.self, from: data)
//        return decodedModel
//    }
//}

//
//  MovieByGenreListState.swift
//  Mandiri-Movie-Viper
//
//  Created by Catharina Adinda Mega Cahyani on 12/06/23.
//

import Foundation
import SwiftUI

class MovieByGenrePresenter: ObservableObject {
    
    @Published var movies: [Movie]?
    @Published var isLoading: Bool = false
    @Published var error: NSError?

    private let genreService: GenreService
    
    init(genreService: GenreService = GenreStore.shared) {
        self.genreService = genreService
    }
    
    func loadMovies(genre_id:Int, completion: @escaping(Int, [Movie]?) -> ()) {
        self.movies = nil

        self.genreService.fetchMovieByGenre(genre_id: genre_id) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.movies = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
            completion(genre_id, self.movies)
        }
        
       
    }
    
}

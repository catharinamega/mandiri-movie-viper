//
//  MovieListState.swift
//  Mandiri-Movie-Viper
//
//  Created by Catharina Adinda Mega Cahyani on 12/06/23.
//

import Foundation
import SwiftUI

class GenreListPresenter: ObservableObject {
    
    @Published var genres: [Genre] = []
    @Published var isLoading: Bool = false
    @Published var error: NSError?
    
    private let genreService: GenreService
    
    init(genreService: GenreService = GenreStore.shared) {
        self.genreService = genreService
    }
    
    func loadGenres(completion: @escaping() -> ()) {
        self.genres = []
        
        self.genreService.fetchGenres() { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.genres = response.genres
                
            case .failure(let error):
                self.error = error as NSError
            }
            completion()
            
            
        }
    }
    
    func setMovies(genre_id:Int, listMovies:[Movie]){
        if let index = genres.firstIndex(where: {$0.id == genre_id}){
            genres[index].movies = listMovies
        }
        genres.forEach { genre in
            print(genre.movies, genre_id, genre.id)
        }
        
    }
    
}

//
//  MovieDetailPresenter.swift
//  Mandiri-Movie-Viper
//
//  Created by Catharina Adinda Mega Cahyani on 13/06/23.
//

import Foundation
import SwiftUI

class MovieDetailPresenter: ObservableObject {
    
    private let movieService: GenreService
    
    @Published var movies: [Movie]?
    @Published var reviews: [Review]?
    
    @Published var movie: Movie?
    @Published var review: Review?

    @Published var isLoading = false
    @Published var error: NSError?
    
    init(movieService: GenreService = GenreStore.shared) {
        self.movieService = movieService
    }
    
    func loadMovie(id: Int) {
        self.movie = nil
        self.isLoading = false
        self.movieService.fetchMovie(id: id) {[weak self] (result) in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let movie):
                self.movie = movie
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
//    func loadReviews(id: Int) {
//        self.review = nil
//        self.isLoading = false
//        self.movieService.fetchReviewByMovie(movie_id: id) { [weak self] (result) in
//            guard let self = self else { return }
//
//            self.isLoading = false
//            switch result {
//            case .success(let reviews):
//                self.reviews = reviews
//            case .failure(let error):
//                self.error = error as NSError
//            }
//
//        }
//    }

    func loadMovieReviews(movie_id:Int, completion: @escaping(Int, [Review]?) -> ()) {
        self.reviews = nil
        self.isLoading = false
        
        self.movieService.fetchReviewByMovie(movie_id: movie_id) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.reviews = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
            completion(movie_id, self.reviews)
            print("REVIEWS GET \(String(describing: self.reviews))")
        }
        
        
//        self.genreService.fetchMovieByGenre(genre_id: genre_id) { [weak self] (result) in
//            guard let self = self else { return }
//            switch result {
//            case .success(let response):
//                self.movies = response.results
//
//            case .failure(let error):
//                self.error = error as NSError
//            }
//            completion(genre_id, self.movies)
//        }
        
       
    }
    
    func setReviews(movie_id:Int, listReviews:[Review]){
            movie?.reviews = listReviews
//        print("USERNAME SET REVIEWS: \(listReviews[0].username)")
    }
    
    
    
}

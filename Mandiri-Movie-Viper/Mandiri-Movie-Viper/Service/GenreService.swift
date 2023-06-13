//
//  GenreService.swift
//  Mandiri-Movie-Viper
//
//  Created by Catharina Adinda Mega Cahyani on 12/06/23.
//

import Foundation

protocol GenreService{
    func fetchGenres(completion: @escaping (Result<GenreResponse, EndPointError>) -> ())
//    func fetchGenre(id: Int, completion: @escaping (Result<Genre, EndPointError>) -> ())
//    func searchGenre(query: String, completion: @escaping (Result<GenreResponse, GenreError>) -> ())
    func fetchMovieByGenre(genre_id: Int, completion: @escaping (Result<MovieResponse, EndPointError>) -> ())
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, EndPointError>) -> ())
    
    func fetchReviewByMovie(movie_id: Int, completion: @escaping (Result<ReviewResponse, EndPointError>) -> ())
    
   
    
}

enum EndPoint: String, CaseIterable {
    case genre = "/genre/movie/list"
    case movie = "/discover/movie"
    case review = "/reviews"
}

enum EndPointError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}


////
////  MovieService.swift
////  Mandiri-Movie-Viper
////
////  Created by Catharina Adinda Mega Cahyani on 12/06/23.
////
//
//import Foundation
//
//protocol MovieService {
//    
//    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
//    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ())
//    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
//}
//
//enum MovieListEndpoint: Int, CaseIterable, Identifiable {
//    
//    var id: Int { rawValue }
//    
////    case nowPlaying = "now_playing"
////    case upcoming
////    case topRated = "top_rated"
////    case popular
//    
///// SALAH
////    case action
////    case adventure
////    case animation
////    case comedy
////    case crime
////    case documentary
////    case drama
////    case family
////    case fantasy
////    case history
////    case horror
////    case music
////    case mystery
////    case romance
////    case scienceFiction = "science_fiction"
////    case tvMovie = "tv_movie"
////    case thriller
////    case war
////    case western
//    
//    case action = 28
//    case adventure = 12
//    case animation = 16
//    case comedy = 35
//    case crime = 80
//    case documentary = 99
//    case drama = 18
//    case family = 10751
//    case fantasy = 14
//    case history = 36
//    case horror = 27
//    case music = 10402
//    case mystery = 9648
//    case romance = 10749
//    case scienceFiction = 878
//    case tvMovie = 10770
//    case thriller = 53
//    case war = 10752
//    case western = 37
//    
//    var description: String {
//        switch self {
//        case .action: return "Action"
//        case .adventure: return "Adventure"
//        case .animation: return "Animation"
//        case .comedy: return "Comedy"
//        case .crime: return "Crime"
//        case .documentary: return "Documentary"
//        case .drama: return "Drama"
//        case .family: return "Family"
//        case .fantasy: return "Fantasy"
//        case .history: return "History"
//        case .horror: return "Horror"
//        case .music: return "Music"
//        case .mystery: return "Mystery"
//        case .romance: return "Romance"
//        case .scienceFiction: return "Science Fiction"
//        case .tvMovie: return "TV Movie"
//        case .thriller: return "Thriller"
//        case .war: return "War"
//        case .western: return "Western"
//        }
//    }
//}
//
//enum MovieError: Error, CustomNSError {
//    
//    case apiError
//    case invalidEndpoint
//    case invalidResponse
//    case noData
//    case serializationError
//    
//    var localizedDescription: String {
//        switch self {
//        case .apiError: return "Failed to fetch data"
//        case .invalidEndpoint: return "Invalid endpoint"
//        case .invalidResponse: return "Invalid response"
//        case .noData: return "No data"
//        case .serializationError: return "Failed to decode data"
//        }
//    }
//    
//    var errorUserInfo: [String : Any] {
//        [NSLocalizedDescriptionKey: localizedDescription]
//    }
//    
//}

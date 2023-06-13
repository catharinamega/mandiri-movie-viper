//
//  GenreStore.swift
//  Mandiri-Movie-Viper
//
//  Created by Catharina Adinda Mega Cahyani on 12/06/23.
//

import Foundation

class GenreStore: GenreService {
 
//    single tone class sifatnya static
    static let shared = GenreStore()
    private init() {}
    
    private let apiKey = "8ed6d46aaed154271c160ca1fcaf73da"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchGenres(completion: @escaping (Result<GenreResponse, EndPointError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)\(EndPoint.genre.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    
    
    func fetchMovieByGenre(genre_id: Int, completion: @escaping (Result<MovieResponse, EndPointError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)\(EndPoint.movie.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        print("GENRE ID: \(genre_id)")
        self.loadURLAndDecode(url: url, params: [
            "with_genres": String(genre_id)
        ], completion: completion)
        
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, EndPointError>) -> ()) {
            guard let url = URL(string: "\(baseAPIURL)/movie/\(id)") else {
                completion(.failure(.invalidEndpoint))
                return
            }
            self.loadURLAndDecode(url: url, params: [
                "append_to_response": "videos,credits"
            ], completion: completion)
        }
    
    //    func searchGenre(query: String, completion: @escaping (Result<GenreResponse, EndPointError>) -> ()) {
    //        guard let url = URL(string: "\(baseAPIURL)/search/genre/") else {
    //            completion(.failure(.invalidEndpoint))
    //            return
    //        }
    //        self.loadURLAndDecode(url: url, params: [
    //            "language": "en-US",
    //            "include_adult": "false",
    //            "region": "US",
    //            "query": query
    //        ], completion: completion)
    //    }
    
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, EndPointError>) -> ()) {
        
        print("PARAMS: \(params)")
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        print(finalURL.absoluteString)
        
        urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let d = data, let response = String(data: d, encoding: .utf8) {
                print("response : " + response)
            }
            
            if error != nil {
                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
            } catch {
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
        
        
    }
    
    private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, EndPointError>, completion: @escaping (Result<D, EndPointError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
    
    
}

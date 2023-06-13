//
//  ContentView.swift
//  Mandiri-Movie-Viper
//
//  Created by Catharina Adinda Mega Cahyani on 12/06/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var genreList = GenreListPresenter()
    @ObservedObject private var movieList = MovieByGenrePresenter()
    var genres: [Genre]?
    var movies: [Movie]?
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: true){
                ForEach(self.genreList.genres, id: \.id) { genre in
                    
                    VStack(alignment: .leading, spacing: 0){
                        
                        Text(genre.name ?? "")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                            .onAppear{
                                print("MOVIES: ",genre.movies ?? []) }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .top, spacing: 16) {
                                ForEach(genre.movies ?? [], id: \.self) { movie in
                                    
//                                    Text(movie.title ?? "")
                                    NavigationLink(destination: MovieDetailView(movieId: movie.id ?? 0)) {
                                        MovieBackdropCard(movie: movie)
                                            .frame(width: 272, height: 200)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    //                                            .padding(.leading, movie.id == genre.movies.first!.id ? 16 : 0)
                                    //                                            .padding(.trailing, movie.id == genre.movies.last!.id ? 16 : 0)
                                    
                                    
                                    
                                    
                                    
                                    
                                }
                            }
                        }
                        
                        
                    }
                    .onAppear{
                        
                        self.movieList.loadMovies(genre_id: genre.id!) { genre_id, list_movies in
                            self.genreList.setMovies(genre_id: genre_id, listMovies: list_movies!)
                        }
                    }
                    
                }
            }
        }
        .padding()
        .onAppear{
            
            self.genreList.loadGenres {
                //                self.genres = self.genreList.genres
                //                self.movieList.loadMovies(genre_id: 37) { genre_id, list_movies in
                //                    self.genreList.setMovies(genre_id: genre_id, listMovies: list_movies!)
                //                }
            }
            //            load movie list berdasarkan genre
            
            //            completion kasi genreList.setMovies()
            
        }
        
    }
    
    func getMovies(id:Int) {
        self.genreList.loadGenres {
            
            self.movieList.loadMovies(genre_id: id) { genre_id, list_movies in
                self.genreList.setMovies(genre_id: genre_id, listMovies: list_movies!)
            }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

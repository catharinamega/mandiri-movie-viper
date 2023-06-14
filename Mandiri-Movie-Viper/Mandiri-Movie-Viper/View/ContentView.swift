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
    @ObservedObject private var router = MovieListDetailRouter()
    
    var genres: [Genre]?
    var movies: [Movie]?
    
    var body: some View {
        NavigationView {
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
                                        
                                        NavigationLink(destination: router.makeDetailView(movie: movie)
                                        )
                                        {
                                            MovieBackdropCard(movie: movie)
                                                .frame(width: 272, height: 200)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        
                                        
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
                   
                }
              
            }
        }
        
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  MovieDetailView.swift
//  Mandiri-Movie-Viper
//
//  Created by Catharina Adinda Mega Cahyani on 13/06/23.
//

import SwiftUI


struct MovieDetailView: View {
    
    //    @Binding var movieList: MovieByGenrePresenter
    //    @Binding var movieDetailState: MovieDetailPresenter
    var movie: Movie
    @State private var updatedReviews: [Review] = []
    @ObservedObject  var movieDetailState = MovieDetailPresenter()
    @ObservedObject  var movieReviewDetailState = MovieByGenrePresenter()
    
    var body: some View {
        ZStack {
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error) {
                self.movieDetailState.loadMovie(id: self.movie.id ?? 0)
                
                self.movieDetailState.loadMovieReviews(movie_id: self.movie.id ?? 0) { movie_id,      list_movies in
                    self.movieReviewDetailState.setReviews(movie_id: self.movie.id ?? 0, listReviews: self.movie.reviews ?? [])
                    
                }
//                self.movieDetailState.loadMovieReview(movie_id: self.movie.id ?? 0)
                
//                self.movieReviewDetailState.loadMovieReviews(movie_id: self.movie.id ?? 0) { movie_id,      list_reviews in
//                    self.movieReviewDetailState.setReviews(movie_id: self.movie, listReviews: list_reviews ?? [])
//                }
//
//
//                self.movieDetailState.setReviews(movie_id: self.movie.id ?? 0, listReviews: self.movie.reviews ?? [])
//
//                self.movieReviewDetailState.setReviews(movie_id: self.movie, listReviews: self.movie.reviews ?? [])
            }
            
            if movieDetailState.movie != nil {
                MovieDetailListView(movie: self.movieDetailState.movie!, detailList: movieReviewDetailState,
                                    reviewsList: $updatedReviews
                )
//                .onAppear{
//                    self.movieDetailState.setReviews(movie_id: self.movie.id ?? 0, listReviews: self.movie.reviews ?? [])
//
//                }
                
                
            }
        }
        .navigationBarTitle(self.movie.title ?? "")
        .onAppear {
            self.movieDetailState.loadMovie(id: self.movie.id ?? 0)
            
            

//            self.movieDetailState.setReviews(movie_id: self.movie.id ?? 0, listReviews: self.movie.reviews ?? [])
//
//            self.movieReviewDetailState.setReviews(movie_id: self.movie, listReviews: self.movie.reviews ?? [])
           
            self.movieReviewDetailState.loadMovieReviews(movie_id: self.movie.id ?? 0) { [self] movie_id, list_reviews in
//                DI SINI BARU DIISI REVIEWSNYA
//                self.movieReviewDetailState.setReviews(movie_id: self.movie.id ?? 0, listReviews: list_reviews ?? [])
                self.updatedReviews = list_reviews ?? []
              
                
            }
            
            
            
        }
    }
}

struct MovieDetailListView: View {
    
    let movie: Movie
    let detailList: MovieByGenrePresenter
    @Binding var reviewsList:[Review]
//        @Binding var detailList: MovieDetailPresenter
    
    //    let review: Review
    @State private var selectedTrailer: MovieVideo?
    let imageLoader = ImageLoader()
    
    var body: some View {
        List {
            MovieDetailImage(imageLoader: imageLoader, imageURL: self.movie.backdropURL)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            HStack {
                Text(movie.genreText)
                Text("·")
                Text(movie.yearText ?? "")
                Text(movie.durationText)
            }
            
            Text(movie.overview ?? "")
            HStack {
                if !movie.ratingText.isEmpty {
                    Text(movie.ratingText).foregroundColor(.yellow)
                }
                Text(movie.scoreText)
            }
            
            Divider()
            
            HStack(alignment: .top, spacing: 4) {
                if movie.cast != nil && movie.cast!.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Starring").font(.headline)
                        ForEach(self.movie.cast!.prefix(9)) { cast in
                            Text(cast.name)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    
                }
                
                if movie.crew != nil && movie.crew!.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        if movie.directors != nil && movie.directors!.count > 0 {
                            Text("Director(s)").font(.headline)
                            ForEach(self.movie.directors!.prefix(2)) { crew in
                                Text(crew.name)
                            }
                        }
                        
                        if movie.producers != nil && movie.producers!.count > 0 {
                            Text("Producer(s)").font(.headline)
                                .padding(.top)
                            ForEach(self.movie.producers!.prefix(2)) { crew in
                                Text(crew.name)
                            }
                        }
                        
                        if movie.screenWriters != nil && movie.screenWriters!.count > 0 {
                            Text("Screenwriter(s)").font(.headline)
                                .padding(.top)
                            ForEach(self.movie.screenWriters!.prefix(2)) { crew in
                                Text(crew.name)
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
            }
            
            Divider()
            
            if movie.youtubeTrailers != nil && movie.youtubeTrailers!.count > 0 {
                Text("Trailers").font(.headline)
                
                ForEach(movie.youtubeTrailers!) { trailer in
                    Button(action: {
                        self.selectedTrailer = trailer
                    }) {
                        HStack {
                            Text(trailer.name)
                            Spacer()
                            Image(systemName: "play.circle.fill")
                                .foregroundColor(Color(UIColor.systemBlue))
                        }
                    }
                }
            }
            
            Divider()
            
            VStack{
                Text("User Review")
                    .font(.headline)
                    .padding(.top)
                
                Divider()
                
                ForEach(reviewsList) { list in
                    Text(list.author ?? "")
                        .bold()
                    
                    Text(list.content ?? "")
                    
                    Divider()
                    
                }
            }
        }
        .onAppear{
//                        self.detailList.loadMovieReviews(movie_id: movie.id ?? 0) { movie_id, list_reviews in
//                                                    self.detailList.setReviews(movie_id: movie_id, listReviews: list_reviews ?? [])
//                                                }
        }
        .sheet(item: self.$selectedTrailer) { trailer in
            SafariView(url: trailer.youtubeURL!)
        }
    }
}

struct MovieDetailImage: View {
    
    @ObservedObject var imageLoader: ImageLoader
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}



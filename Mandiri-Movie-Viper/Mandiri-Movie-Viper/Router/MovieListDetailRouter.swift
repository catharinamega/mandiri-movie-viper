//
//  MovieListDetailRouter.swift
//  Mandiri-Movie-Viper
//
//  Created by Catharina Adinda Mega Cahyani on 14/06/23.
//

import Foundation
import SwiftUI

class MovieListDetailRouter: ObservableObject {
    
    func makeDetailView(movie: Movie) -> some View {
        
        return  MovieDetailView( movie: movie)
    }
}



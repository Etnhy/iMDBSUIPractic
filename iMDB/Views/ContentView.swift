//
//  ContentView.swift
//  iMDB
//
//  Created by Evhenii Mahlena on 08.06.2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var moviesViewModel = MoviesViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack {
                Picker("", selection: $moviesViewModel.indexEndpoint) {
                    Text("nowPlaying").tag(0)
                    Text("popular").tag(1)
                    Text("upcoming").tag(2)
                    Text("topRated").tag(3)
                }
                .pickerStyle(.segmented)
                MoviesList(movies: moviesViewModel.movies)
            }
            .navigationBarTitle("Movies")
        }
    }   // Body
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}

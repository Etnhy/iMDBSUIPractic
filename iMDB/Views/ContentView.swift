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
                    Text("Playing Now").tag(0)
                    Text("Popular").tag(1)
                    Text("Upcoming").tag(2)
                    Text("Top Rated").tag(3)
                }
                .pickerStyle(.segmented)
                MoviesList(movies: moviesViewModel.movies)
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Search") {
                        ContentViewSearch()
                    }
                }
            })
            .navigationBarTitle("Movies")
        }
    }   // Body
    
    var searchButton = {

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}

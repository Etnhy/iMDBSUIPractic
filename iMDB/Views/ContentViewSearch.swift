//
//  ContentViewSearch.swift
//  iMDB
//
//  Created by Evhenii Mahlena on 09.06.2022.
//

import SwiftUI

struct ContentViewSearch: View {
    @ObservedObject var moviesModel = MoviewSearchViewModel()
    var body: some View {
            VStack {
                SearchView(searchTerm:$moviesModel.name)
                
                MoviesList(movies: moviesModel.movies)
            }
    }
}

struct ContentViewSearch_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewSearch()
    }
}

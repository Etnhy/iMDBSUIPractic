//
//  SearchView.swift
//  iMDB
//
//  Created by Evhenii Mahlena on 09.06.2022.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var searchTerm: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 20)
            TextField("Search",text: self.$searchTerm)
                .font(.largeTitle)
                .foregroundColor(.primary)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchTerm: .constant(""))
    }
}

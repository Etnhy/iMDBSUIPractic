//
//  CastsList.swift
//  iMDB
//
//  Created by Evhenii Mahlena on 08.06.2022.
//

import SwiftUI

struct CastsList: View {
    
    @ObservedObject var castsViewModel: CastViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(castsViewModel.casts) { cast in
                    VStack {
                        MoviewPosterImage(imageLoader:
                                            ImageLoaderCache.shared.loaderFor(cast: cast), posterSize: .cast)
                        
                        Text("\(cast.character)").font(.footnote)
                        Text("\(cast.name)")

                    }
                }
            } //hstack
            .frame(height: 200)
            .padding(10)
        }
    }
}

struct CastsList_Previews: PreviewProvider {
    static var previews: some View {
        CastsList(castsViewModel: CastViewModel(movieId: 611914))
    }
}

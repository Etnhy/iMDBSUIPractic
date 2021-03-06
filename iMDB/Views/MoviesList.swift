//
//  MoviesList.swift
//  iMDB
//
//  Created by Evhenii Mahlena on 08.06.2022.
//

import SwiftUI


struct MoviesList: View {

    var movies: [Movie]

    var body: some View {
        List {
            ForEach(movies) { movie in
                NavigationLink(destination: DetailView(movie: movie)) {
                    HStack {
                        MoviewPosterImage(imageLoader: ImageLoaderCache.shared.loaderFor(movie: movie), posterSize: .medium)
                        VStack {
                            Text("\(movie.title)").font(.title)
                            Text(formatter.string(from: movie.releaseDate))
                            Text("\(movie.overview)")
                                .lineLimit(4)
                        }
                    }
                }
            }
        }
    }
}
let components1 = DateComponents(calendar: calendar, year: 2019, month: 7, day: 26)
let sampleMovie1 = Movie(id: 466272, title: "Once Upon a Time... in Hollywood",
                    overview: "A faded television actor and his stunt double strive to achieve fame and success in the film industry during the final years of Hollywood's Golden Age in 1969 Los Angeles.", posterPath:
"/8j58iEBw9pOXFD2L0nt0ZXeHviB.jpg", releaseDate: calendar.date(from: components1)!)

let components2 = DateComponents(calendar: calendar, year: 2011, month: 9, day: 5)
let sampleMovie2 = Movie(id: 33539, title: "Once Upon a Forest",
                    overview: "AA young mouse, mole and hedgehog risk their lives to find a cure for their badger friend, who's been poisoned by men.", posterPath:
"/hfys5FQ9WhZZdO3dxPY54AG7iMR.jpg", releaseDate: calendar.date(from: components2)!)


struct MoviesList_Previews: PreviewProvider {
    static var previews: some View {
        MoviesList(movies: [sampleMovie, sampleMovie1, sampleMovie2])
    }
}

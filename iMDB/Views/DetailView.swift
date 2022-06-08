//
//  DetailView.swift
//  iMDB
//
//  Created by Evhenii Mahlena on 08.06.2022.
//

import SwiftUI


let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()

struct DetailView: View {
    
    var movie: Movie
    var body: some View {
        VStack {
            MoviewPosterImage(imageLoader: ImageLoaderCache.shared.loaderFor(movie: movie), posterSize: .big)
            Text(formatter.string(from: movie.releaseDate))
                .font(.subheadline)
                .foregroundColor(.blue)
            Text("\(movie.overview)")
                .lineLimit(6)
            CastsList(castsViewModel: CastViewModel(movieId: movie.id))
        }
        .padding(20)
        .navigationBarTitle(Text(movie.title), displayMode: .inline)
    }
}
let calendar = Calendar.current
let components = DateComponents(calendar: calendar, year: 1984, month: 1, day: 23)

let sampleMovie = Movie(id: 311, title: "Once Upon a Time in America",
                        overview: "A former Prohibition-era Jewish gangster returns to the Lower East Side of Manhattan over thirty years later, where he once again must confront the ghosts and regrets of his old life", posterPath:
    "/x733R4ISI0RbKeHhVkXdTMFmTFr.jpg", releaseDate: calendar.date(from: components)!)


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(movie: sampleMovie)
    }
}

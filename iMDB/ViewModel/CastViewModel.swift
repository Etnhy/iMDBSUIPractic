//
//  CastViewMovel.swift
//  iMDB
//
//  Created by Evhenii Mahlena on 08.06.2022.
//

import Combine

final class CastViewModel: ObservableObject {
    @Published var moviewId: Int = 642372
    @Published var casts = [MovieCast]()
    
    init(movieId: Int) {
        self.moviewId = movieId
        $moviewId.flatMap { (movieId) -> AnyPublisher<[MovieCast], Never> in
            MovieApi.shared.fetchCredits(for: movieId)
        }
        .assign(to: \.casts, on: self)
        .store(in: &self.cancellableSet)
    }
    private var cancellableSet: Set<AnyCancellable> = []

}

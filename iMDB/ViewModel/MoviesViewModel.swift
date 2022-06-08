//
//  MoviesViewModel.swift
//  iMDB
//
//  Created by Evhenii Mahlena on 08.06.2022.
//

import Foundation
import Combine

final class MoviesViewModel: ObservableObject {
    // input
    @Published var indexEndpoint: Int = 2
    // output
    @Published var movies = [Movie]()
    
    init() {
          $indexEndpoint
           .flatMap { (indexEndpoint) -> AnyPublisher<[Movie], Never> in
                MovieApi.shared.fetchMovies(from:
                                    Endpoint( index: indexEndpoint)!)
           }
         .assign(to: \.movies, on: self)
         .store(in: &self.cancellableSet)
   }
    
    private var cancellableSet: Set<AnyCancellable> = []
}

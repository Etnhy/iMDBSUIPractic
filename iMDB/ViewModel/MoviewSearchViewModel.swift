//
//  MoviewSearchViewModel.swift
//  iMDB
//
//  Created by Evhenii Mahlena on 08.06.2022.
//

import Combine
import Foundation

final class MoviewSearchViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var movies = [Movie]()
    
    init() {
        $name
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { name -> AnyPublisher<[Movie], Never> in
                Future<[Movie],Never> { (promise) in
                    if 2...30 ~= name.count {
                        MovieApi.shared.fetchMovies(from: .search(searchString: name))
                            .sink( receiveValue: {value in promise(.success(value))})
                            .store(in: &self.cancellableSet)
                    } else {
                        promise(.success([Movie]()))
                    }
                }
                .eraseToAnyPublisher()
            }
            .assign(to: \.movies, on: self)
            .store(in: &self.cancellableSet)
    }
    private var cancellableSet: Set<AnyCancellable> = []
    deinit {
        for cancell in cancellableSet {
            cancell.cancel()
        }
    }

}

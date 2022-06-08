//
//  ImageLoader.swift
//  iMDB
//
//  Created by Evhenii Mahlena on 08.06.2022.
//

import Combine
import UIKit


class ImageLoaderCache {
    static let shared = ImageLoaderCache()
    var loaders: NSCache<NSString, ImageLoader> = NSCache()
    
    func loaderFor(movie: Movie) -> ImageLoader {
        let key = NSString(string: "\(movie.id)")
        if let loader = loaders.object(forKey: key) {
            return loader
        } else {
            let pathString = ImageAPI.Size.medium.path (poster: movie.posterPath)
            let loader = ImageLoader(url: pathString)
            loaders.setObject(loader, forKey: key)
            return loader
        }
    }
    
    func loaderFor(cast: MovieCast) -> ImageLoader {
        let key = NSString(string: "\(cast.id)")
        if let loader = loaders.object(forKey: key) {
            return loader
        } else {
            guard let path = cast.profilePath else {
                return ImageLoader (url: nil)
            }
            let pathString = ImageAPI.Size.cast.path (poster: path)
            let loader = ImageLoader(url: pathString)
            loaders.setObject(loader, forKey: key)
            return loader
        }
    }
}


final class ImageLoader: ObservableObject {
    
    @Published var url:     URL?        /*      input    */
    @Published var image:   UIImage?    /*      output   */
    
    init(url: URL?) {
        self.url = url
        $url.flatMap { (path) -> AnyPublisher<UIImage?, Never> in
            self.fetchImage(for: url) }
        .assign(to: \.image, on: self)
        .store(in: &self.cancellableSet)
        
    }
    private var cancellableSet: Set<AnyCancellable> = []
    
    
    private func fetchImage(for url: URL?) -> AnyPublisher <UIImage?,Never> {
        guard url != nil, image == nil else {
            return Just(nil).eraseToAnyPublisher()
        }
        return
        URLSession.shared.dataTaskPublisher(for: url!)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
}

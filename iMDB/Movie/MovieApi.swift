//
//  MovieApi.swift
//  iMDB
//
//  Created by Evhenii Mahlena on 08.06.2022.
//

import SwiftUI
import Combine

enum Endpoint {
    
    case topRated, upcoming, nowPlaying, popular
    case search (searchString: String)
    case credits (movieId: Int)
    
    var baseURL:URL {URL(string: "https://api.themoviedb.org/3")!}
    
    func path() -> String {
        switch self {
        case .popular:
            return "movie/popular"
        case .topRated:
            return "movie/top_rated"
        case .upcoming:
            return "movie/upcoming"
        case .nowPlaying:
            return "movie/now_playing"
        case .search (_):
            return "/search/movie"
        case let .credits (movieId):
            return "movie/\(String(movieId))/credits"
        }
    }
    
    var absoluteURL: URL? {
        let queryURL = baseURL.appendingPathComponent(self.path())
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else {
            return nil
        }
        switch self {
        case .search (let name):
            urlComponents.queryItems = [URLQueryItem(name: "query",     value: name),
                                        URLQueryItem(name: "api_key",   value: APIConstants.apiKey),
                                        URLQueryItem(name: "language",  value: "en"),
                                        URLQueryItem(name: "region",    value: "US"),
                                        URLQueryItem(name: "page",      value: "1")
            ]
        default:
            urlComponents.queryItems = [URLQueryItem(name: "api_key",   value: APIConstants.apiKey),
                                        URLQueryItem(name: "language",  value: "en"),
                                        URLQueryItem(name: "region",    value: "US"),
                                        URLQueryItem(name: "page",      value: "1")
            ]
        }
        return urlComponents.url
    }
    
    init? (index: Int) {
        switch index {
        case 0: self = .nowPlaying
        case 1: self = .popular
        case 2: self = .upcoming
        case 3: self = .topRated
        default: return nil
        }
    }
}

struct APIConstants {
    /// TMDB API key url: https://themoviedb.org
    static let apiKey: String = "2e7cf1a16bc88e75c35c5da677150af4"
    
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
}


class MovieApi {
    public static let shared = MovieApi()
    
    
    /* fetch Movies */
    func fetchMovies(from endpoint: Endpoint)
                                    -> AnyPublisher<[Movie], Never> {
        guard let url = endpoint.absoluteURL else {
                    return Just([Movie]()).eraseToAnyPublisher() // 0
        }
        return fetch(url)                                        // 1
            .map { (response: MoviesResponse) -> [Movie] in      // 2
                            response.results }
               .replaceError(with: [Movie]())                    // 3
               .eraseToAnyPublisher()                            // 4
    }

    
    
    /* Fetch actors */
    func fetchCredits(for movieId: Int) -> AnyPublisher<[MovieCast], Never> {
        guard let url = Endpoint.credits(movieId: movieId).absoluteURL else {
            return Just([MovieCast]()).eraseToAnyPublisher()
        }
        return fetch(url)
            .map { (response: MovieCreditResponse) -> [MovieCast] in
                response.cast}
            .replaceError(with: [MovieCast]())
            .eraseToAnyPublisher()
    }
    
    func fetch<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data }
            .decode(type: T.self, decoder: APIConstants.jsonDecoder)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}

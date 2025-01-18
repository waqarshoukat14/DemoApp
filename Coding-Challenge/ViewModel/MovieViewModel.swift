//
//  MovieViewModel.swift
//  Coding-Challenge
//
//  Created by Waqar Shoukat on 25/11/2024.
//

import Foundation
import Combine

typealias NotficationName = Notification.Name
extension NotficationName {
    static let notifyWhenComplete = NotficationName("notifyWhenComplete")
}

class MovieViewModel {
    
    var movies: [MoviesResult]?
    var cancellable = Set<AnyCancellable>()
    let dispatchGroup = DispatchGroup()
    let movieService = MovieService()
    
    private let favoriteMoviesKey = "FavoriteMovies"
    
    func fetchMoviesList() {
        movieService.fetchMovies()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    self.dispatchGroup.notify(queue: .main) {
                        NotificationCenter.default.post(Notification(name: .notifyWhenComplete))
                    }
                }
            }, receiveValue: { [weak self] movies in
                self?.movies = movies.results
            })
            .store(in: &cancellable)
    }
    
    func toggleFavoriteStatus(for movie: MoviesResult) {
        var favoriteTrackIds = UserDefaults.standard.array(forKey: favoriteMoviesKey) as? [Int] ?? []
        
        if movie.isFavorite {
            favoriteTrackIds.append(movie.trackId ?? 0)
        } else {
            favoriteTrackIds.removeAll { $0 == movie.trackId }
        }
        UserDefaults.standard.set(favoriteTrackIds, forKey: favoriteMoviesKey)
    }
}

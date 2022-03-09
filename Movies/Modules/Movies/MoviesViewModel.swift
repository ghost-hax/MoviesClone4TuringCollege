//
//  MoviesViewModel.swift
//  Movies
//
//  Created by David on 04/02/2022.
//

import Foundation
import Combine

enum ViewState: Equatable {
    case none
    case loading
    case finishedLoading
    case error(String)
}

protocol MoviesViewModelType {
    var stateBinding: Published<ViewState>.Publisher { get }
    var movieCount:Int { get }
    var movies:[Movie] { get }
    func searchMovies(keyword: String, apiRequest:ApiRequest)
    func markFavourite(isSelected:Bool, index:Int)
    func showFavouriteMovies()
}

final class MoviesViewModel: MoviesViewModelType {
    
    var stateBinding: Published<ViewState>.Publisher{ $state }
    
    private let repository:MovieRepositoryType
    private var cancellables:Set<AnyCancellable> = Set()
        
    @Published  var state: ViewState = .none

    var movies:[Movie] = []
    
    var movieCount: Int {
        return movies.count
    }
    
    init(repository:MovieRepositoryType) {
        self.repository = repository
    }

    func searchMovies(keyword: String, apiRequest:ApiRequest) {
        if keyword.count > 0 {
            getMovies(apiRequest: apiRequest)
        }else {
            showFavouriteMovies()
        }
    }
    
    private func getMovies(apiRequest: ApiRequestType) {
        
        state = ViewState.loading
        let publisher =   self.repository.getMovies(apiRequest: apiRequest)
        
        let cancalable = publisher.sink { [weak self ]completion in
            switch completion {
            case .finished:
                break
            case .failure(_):
                self?.state = ViewState.error("Network Not Availale")
            }
        } receiveValue: { [weak self] movies in
            self?.movies = movies
            self?.state = ViewState.finishedLoading
        }

        self.cancellables.insert(cancalable)
    }
    
    func markFavourite(isSelected: Bool, index: Int) {
        let movie = self.movies[index]
        movie.isFav = isSelected
        repository.saveOrRemoveFav(movie: movie)
    }
    
    func showFavouriteMovies() {
        
        let cancalable = repository.fetchFavMovies().sink { completion in
            
        } receiveValue: { [weak self] movies in
            self?.movies = movies
            self?.state = ViewState.finishedLoading
        }

        self.cancellables.insert(cancalable)

    }
    
    deinit {
        cancellables.forEach { cancellable in
            cancellable.cancel()
        }
    }
}


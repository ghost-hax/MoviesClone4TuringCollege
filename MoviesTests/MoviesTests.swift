//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by David on 04/02/2022.
//

import XCTest
@testable import Movies

class MoviesTests: XCTestCase {
    
    var viewModel:MoviesViewModel!
    var respository:MovieRepository!
    var networkManager:MockNetworkManager!
    var movieCoreDataRepo:MockMovieCoreDataRepository!
    
    override func setUpWithError() throws {
        
        networkManager = MockNetworkManager()
        movieCoreDataRepo = MockMovieCoreDataRepository()
        
        respository = MovieRepository(networkManager: networkManager, movieCoreDataRepo: movieCoreDataRepo)
        viewModel = MoviesViewModel(repository: respository)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testSearchMovie_success() {
        
        let movieApiRquest = ApiRequest(baseUrl: EndPoint.baseUrl, path: "movie_success", params: [:])
               
        viewModel.searchMovies(keyword: "a", apiRequest: movieApiRquest)
        
        XCTAssertEqual(viewModel.movieCount, 20)
        XCTAssertEqual(viewModel.movies.count, 20)
        print(viewModel.movies.count)
        
//        XCTAssertEqual(viewModel.movies[0].isFav, false)
//
//        XCTAssertEqual(viewModel.movies[1].isFav, true)

    }
    
    func testSearchMovieForFavouriteMovies_success() {
        
        let movieApiRquest = ApiRequest(baseUrl: EndPoint.baseUrl, path: "movie_success", params: [:])
               
        viewModel.searchMovies(keyword: "", apiRequest: movieApiRquest)
        
        XCTAssertEqual(viewModel.movieCount, 1)
        XCTAssertEqual(viewModel.movies.count, 1)
        
        XCTAssertEqual(viewModel.movies[0].isFav, true)

    }
    
}

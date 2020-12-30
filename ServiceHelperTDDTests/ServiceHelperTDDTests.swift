//
//  ServiceHelperTDDTests.swift
//  ServiceHelperTDDTests
//
//  Created by Nikhil Dange on 30/12/20.
//  Copyright © 2020 Nikhil Dange. All rights reserved.
//

import XCTest
@testable import ServiceHelperTDD

class ServiceHelperTDDTests: XCTestCase {
    
    //invalidURL
    func testURLOfGetMovie() {
        let serviceHelper = MovieServiceHelper(networkHelper: NetworkHelperMockWithData())
        let page = -1
        serviceHelper.getMoviesData(on: page) { (data, error) in
            XCTAssertNil(data)
            XCTAssertEqual(error!, MovieAPIError.invalidURLRequest)
        }
    }
    
    func testGetMovieOnEmptyResponse() {
        let serviceHelper = MovieServiceHelper(networkHelper: NetworkHelperMockWithEmptyData())
        let page = 1
        serviceHelper.getMoviesData(on: page) { (data, error) in
            XCTAssertNil(data)
            XCTAssertEqual(error, MovieAPIError.emptyResponse)
        }
    }
    
    
    //-servererror
    //-statuscode
    //-jsonparse
    //-empty
}


class NetworkHelperMockWithEmptyData: NetworkHelperProtocol {
    
    func callMoviesData(on page: Int, completion: @escaping MovieResponse) {
        let response = MoviePage(page: page, movies: [], totalPages: 1000, totalResults: 2000)
        completion(response, nil)
    }
    
}


class NetworkHelperMockWithData: NetworkHelperProtocol {
    
    func callMoviesData(on page: Int, completion: @escaping MovieResponse) {
        let response = MoviePage(page: page, movies: [Movie(id: 1, video: false, voteCount: 1, voteAverage: 2.0, title: "Star Wars", releaseDate: "1977-05-25", originalLanguage: "EN", originalTitle: "Star Wars", genreIDS: [12,28], backdropPath: nil, adult: false, overview: "Princess Leia is captured and held hostage by the evil Imperial forces in their effort to take over the galactic Empire. Venturesome Luke Skywalker and dashing captain Han Solo team together with the loveable robot duo R2-D2 and C-3PO to rescue the beautiful princess and restore peace and justice in the Empire.", posterPath: "/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg", popularity: 146.974, mediaType: "movie")], totalPages: 1000, totalResults: 2000)
        completion(response, nil)
    }
    
}

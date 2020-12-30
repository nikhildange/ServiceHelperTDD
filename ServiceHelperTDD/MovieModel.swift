//
//  MovieModel.swift
//  ServiceHelperTDD
//
//  Created by Nikhil Dange on 30/12/20.
//  Copyright © 2020 Nikhil Dange. All rights reserved.
//

import Foundation

// MARK: - MoviePage
struct MoviePage: Codable {
    let page: Int
    let movies: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie
struct Movie: Codable {
    let id: Int
    let video: Bool
    let voteCount: Int
    let voteAverage: Double
    let title, releaseDate, originalLanguage, originalTitle: String
    let genreIDS: [Int]
    let backdropPath: String?
    let adult: Bool
    let overview: String
    let posterPath: String?
    let popularity: Double
    let mediaType: String

    enum CodingKeys: String, CodingKey {
        case id, video
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case title
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case posterPath = "poster_path"
        case popularity
        case mediaType = "media_type"
    }
}

//
//  Movie.swift
//  lenskartMovies
//
//  Created by Santhosh Konduru on 29/05/21.
//

import Foundation

class Movie: NSObject, Codable {
    
    var adult: Bool?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var id: Int?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var isVideo: Bool?
    var vote_average: Double?
    var vote_count: Int?
    var original_language: String?
    
    
    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdrop_path = "backdrop_path"
        case genre_ids = "genre_ids"
        case id = "id"
        case original_title = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case poster_path = "poster_path"
        case release_date = "release_date"
        case title = "title"
        case isVideo = "isVideo"
        case vote_average = "vote_average"
        case original_language = "original_language"
    }
    
    
}

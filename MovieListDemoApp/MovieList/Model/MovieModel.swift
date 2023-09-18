//
//  MovieModel.swift
//  MovieListDemoApp
//
//  Created by Muhammad Mazhar on 06/09/2023.
//

internal struct MovieModel : Decodable {
    var title = ""
    var description = ""
    var rating = ""
    var duration = ""
    var genre = ""
    var releasedDate = ""
    var trailerLink = ""
//    var movieThumbnail: String?
    var onWatchList: Bool? = false
}


struct ResponseData: Decodable {
    var movies: [MovieModel]
}

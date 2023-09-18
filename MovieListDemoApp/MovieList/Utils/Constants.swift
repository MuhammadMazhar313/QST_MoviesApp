//
//  Constants.swift
//  MovieListDemoApp
//
//  Created by Muhammad Mazhar on 06/09/2023.
//

import Foundation

enum SortingKey: String {
    case title  = "title"
    case releasedDate = "releasedDate"
}

enum Identifiers: String {
    case movieListCell = "MovieListCell"
    case jsonFileName  = "movies"
    case jsonFileType  = "json"
    case movieStroyBoard = "Movie"
    case sortDialog      = "SortMovieDialog"
}

enum VCIds: String {
    case movieListVC = "MovieListViewController"
    case movieDetailVC = "MovieDetailViewController"
    case sortMovieDialog = "SortMovieDialog"
}

enum Constants : String {
    case addToWatchList = "+ ADD TO WATCHLIST"
    case removeFromWatchList = "REMOVE FROM WATCHLIST"
}

enum VCTiltes : String {
case movieList = "Movies"
}

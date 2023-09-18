//
//  MovieListVM.swift
//  MovieListDemoApp
//
//  Created by Muhammad Mazhar on 06/09/2023.
//

import Foundation
import SwiftyJSON

internal protocol MovieListVMDelegate: AnyObject {
    func populateMovies()
}

internal class MovieListVM {
    var moviesList = [MovieModel]()
    weak var delegate: MovieListVMDelegate?
    
    internal func getMovies(){
        // get movies from json file and populate
        moviesList = loadJson(filename: Identifiers.jsonFileName.rawValue) ?? [MovieModel]()
        delegate?.populateMovies()
    }
    
    internal func loadJson(filename fileName: String) -> [MovieModel]? {
        if let path : String = Bundle.main.path(forResource: fileName, ofType: Identifiers.jsonFileType.rawValue) {
            if let data = NSData(contentsOfFile: path) {
                do{
                    let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data as Data)
                    return jsonData.movies
                }catch{
                    print(error)
                }
            }
        }
        return nil
    }
}

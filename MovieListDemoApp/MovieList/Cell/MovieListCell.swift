//
//  MovieListCell.swift
//  MovieListDemoApp
//
//  Created by Muhammad Mazhar on 06/09/2023.
//

import UIKit

internal class MovieListCell: UITableViewCell {
    
    static let identifier = Identifiers.movieListCell.rawValue
    
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var durationInfoLbl: UILabel!
    @IBOutlet var onMyWatchListLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initializeDelegate()
        movieImage.layer.cornerRadius = 5
    }
    
    private func initializeDelegate() {
    }
    
    func populateCell(model: MovieModel) {
        populateImage(imagePath: Utilities.getCustomImagePath(name: model.title))
        titleLbl.text = model.title + " " + (!model.releasedDate.isEmpty ? getReleaseYearOnly(date: model.releasedDate) : "")
        durationInfoLbl.text = model.duration + (!model.genre.isEmpty ? ( " - " + model.genre) : "" )
        onMyWatchListLbl.isHidden = !(model.onWatchList ?? false)
        onMyWatchListLbl.superview?.isHidden = !(model.onWatchList ?? false)
    }
    
    func getReleaseYearOnly(date: String) -> String {
        return ("(" + (date.split(separator: " ").last ?? "") + ")")
    }
    

    func populateImage(imagePath: String){
        if let image = UIImage(named: imagePath) {
            movieImage.image = image
        } else {
            print("Image not found.")
        }
    }
}

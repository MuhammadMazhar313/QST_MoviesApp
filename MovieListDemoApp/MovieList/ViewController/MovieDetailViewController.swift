//
//  MovieDetailViewController.swift
//  MovieListDemoApp
//
//  Created by Muhammad Mazhar on 13/09/2023.
//

import UIKit

protocol MovieDetailDelegate {
    func onBackPressed(model: MovieModel)
}

class MovieDetailViewController: UIViewController {
    
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var watchListBtn: UIButton!
    @IBOutlet var watchTrailerBtn: UIButton!
    @IBOutlet var shortDescription: UILabel!
    @IBOutlet var genre: UILabel!
    @IBOutlet var releaseDate: UILabel!
    @IBOutlet var backBtnImg: UIImageView!
    @IBOutlet var previousVC: UILabel!
    @IBOutlet var rating: UILabel!
    
    var model: MovieModel?
    var delegate : MovieDetailDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addTapGesture()
//        assignDelegates()
        populateData()
    }
    
    func setupViews(){
        movieImage.layer.cornerRadius = 5
        watchTrailerBtn.layer.cornerRadius = 14
        watchTrailerBtn.layer.borderWidth = 1
        watchListBtn.layer.cornerRadius = 12
        previousVC.text = VCTiltes.movieList.rawValue
    }
    
    func addTapGesture(){
        watchListBtn.addTarget(self, action: #selector(self.handleWatchListTap), for: .touchUpInside)
        watchTrailerBtn.addTarget(self, action: #selector(self.handleWatchTrailerTap), for: .touchUpInside)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.handleBackBtnTap))
        self.backBtnImg.addGestureRecognizer(gesture)
    }
    
    @objc func handleBackBtnTap(){
        delegate?.onBackPressed(model: model ?? MovieModel())
    }
    
    @objc func handleWatchListTap(){
        if let onMyWatchList = model?.onWatchList , onMyWatchList {
            model?.onWatchList = false
            watchListBtn.setTitle(Constants.addToWatchList.rawValue, for: .normal)
        }else {
            model?.onWatchList = true
            watchListBtn.setTitle(Constants.removeFromWatchList.rawValue, for: .normal)
        }
    }
    
    @objc func handleWatchTrailerTap(){
        let url = URL(string: model?.trailerLink ?? "")!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }else{
            print("Can`t open this url !")
        }
    }
    
    func getFormattedReleaseDate(date: String) -> String {
        if date.split(separator: " ").count > 2 {
            let dateArray = date.split(separator: " ")
            let finalDate = (dateArray.last ?? "") + ", " + dateArray[0] + " " + dateArray[1]
            return String(finalDate)
        }
        return date
    }
    
    func populateData(){
        if let model = model {
            genre.text = model.genre
            titleLbl.text = model.title
            releaseDate.text = getFormattedReleaseDate(date: model.releasedDate)
            shortDescription.text = model.description
            if model.onWatchList ?? false {
                watchListBtn.setTitle(Constants.removeFromWatchList.rawValue, for: .normal)
            }else {
                watchListBtn.setTitle(Constants.addToWatchList.rawValue, for: .normal)
            }
            
            // populate rating
            let boldText  = model.rating
            let normalText = "/10"
            let attributedString = NSMutableAttributedString(string: "")
            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 19)]
            let boldString = NSMutableAttributedString(string: boldText, attributes:attrs)
            attributedString.append(boldString)
            attributedString.append(NSAttributedString(string: normalText))
            rating.attributedText = attributedString
            
            // populate image
            if let image = UIImage(named: Utilities.getCustomImagePath(name: model.title)) {
                movieImage.image = image
            } else {
                print("Image not found.")
            }
        }
    }
}

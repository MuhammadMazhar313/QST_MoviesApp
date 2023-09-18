//
//  SortMovieDialog.swift
//  MovieListDemoApp
//
//  Created by Muhammad Mazhar on 18/09/2023.
//

import UIKit

protocol sortingDialogProtocol {
    func sortTheListFor(key: SortingKey)
}

class SortMovieDialog: UIViewController {
    
    @IBOutlet var outerView: UIView!
    @IBOutlet var titleBtn: UIButton!
    @IBOutlet var releaseDateBtn: UIButton!
    @IBOutlet var cancelBtn: UIButton!
    
    var delegate: sortingDialogProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addTapGesture()
    }

    func setupViews(){
        outerView.layer.cornerRadius = 5
        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    }
    
    func addTapGesture(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCancelTap))
        self.cancelBtn.addGestureRecognizer(gesture)
        
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTitleTap))
        self.titleBtn.addGestureRecognizer(gesture1)

        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(self.handleReleaseDateTap))
        self.releaseDateBtn.addGestureRecognizer(gesture2)
    }
    
    @objc func handleCancelTap() {
        self.dismiss(animated: true)
    }
    
    @objc func handleTitleTap() {
        delegate?.sortTheListFor(key: .title)
        self.dismiss(animated: true)
    }
    
    @objc func handleReleaseDateTap() {
        delegate?.sortTheListFor(key: .releasedDate)
        self.dismiss(animated: true)
    }
}

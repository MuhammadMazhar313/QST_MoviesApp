//
//  ViewController.swift
//  MovieListDemoApp
//
//  Created by Muhammad Mazhar on 06/09/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var btnStart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(handleTap), userInfo: nil, repeats: false)
//        addTapGesture()
    }

    func addTapGesture(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.btnStart.addGestureRecognizer(gesture)
    }

    @objc func handleTap() {
        print("Next Tapped")
        let storyboard = UIStoryboard(name: "Movie", bundle: nil)
        let secondView = storyboard.instantiateViewController(withIdentifier: VCIds.movieListVC.rawValue) as! MovieListViewController
        
        secondView.modalPresentationStyle = .currentContext
        self.present(secondView, animated: true)
    }
    
}


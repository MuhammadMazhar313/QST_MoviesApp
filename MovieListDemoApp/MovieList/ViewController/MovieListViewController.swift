//
//  MovieListViewController.swift
//  MovieListDemoApp
//
//  Created by Muhammad Mazhar on 06/09/2023.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet var sortMoviesLbl: UILabel!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var movieTableView: UITableView!
    
    var viewModel = MovieListVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        addTapGesture()
        assignDelegates()
        viewModel.getMovies()
    }
    
    func setupTableView() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
    }
    
    func addTapGesture(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSortTap))
        self.sortMoviesLbl.addGestureRecognizer(gesture)
    }
    
    func assignDelegates(){
        viewModel.delegate = self
    }
    
    @objc func handleSortTap() {
        print("Sort label tapped")
        let storyboard = UIStoryboard(name: Identifiers.movieStroyBoard.rawValue, bundle: nil)
        let secondView = storyboard.instantiateViewController(withIdentifier: VCIds.sortMovieDialog.rawValue) as! SortMovieDialog
        secondView.delegate = self
        secondView.modalPresentationStyle = .currentContext
        secondView.modalTransitionStyle = .crossDissolve
        self.present(secondView, animated: true)
    }
    
    func updateMoviesList(model: MovieModel){
        /* There should be some movie identifier to match the model
           But now for the current time, we can search as per title */
        
        if let movieIndex = getMatchedMovieIndex(model: model) {
            viewModel.moviesList[movieIndex] = model
        }
    }
    
    func  getMatchedMovieIndex(model: MovieModel) -> Int?{
        for (index, movie) in viewModel.moviesList.enumerated() {
            if movie.title == model.title {
                return index
            }
        }
        return nil
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moviesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.identifier)
            as? MovieListCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        let movie = viewModel.moviesList[indexPath.row]
        cell.populateCell(model: movie)
        return cell
    }

    func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openDetailsScreen(model: viewModel.moviesList[indexPath.row])
    }

    func openDetailsScreen(model: MovieModel){
        let storyboard = UIStoryboard(name: Identifiers.movieStroyBoard.rawValue, bundle: nil)
        let secondView = storyboard.instantiateViewController(withIdentifier: VCIds.movieDetailVC.rawValue) as! MovieDetailViewController
        secondView.model = model
        secondView.delegate = self
        secondView.modalPresentationStyle = .currentContext
        self.present(secondView, animated: true)
        
    }
}

extension MovieListViewController: MovieListVMDelegate {
    func populateMovies() {
        movieTableView.reloadData()
    }
}

extension MovieListViewController: MovieDetailDelegate{
    func onBackPressed(model: MovieModel) {
        updateMoviesList(model: model)
        movieTableView.reloadData()
        self.dismiss(animated: true)
    }
}

extension MovieListViewController: sortingDialogProtocol {
    func sortTheListFor(key: SortingKey) {
        if key == .title {
            print("sort by title")
            viewModel.moviesList.sort { $0.title < $1.title }
            movieTableView.reloadData()
        }else if key == .releasedDate {
            print("sort by released date")
            viewModel.moviesList.sort { $0.releasedDate < $1.releasedDate }
            movieTableView.reloadData()
        }
        
        self.dismiss(animated: true)
    }
}

//
//  ViewController.swift
//  Coding-Challenge
//
//  Created by Waqar Shoukat on 25/11/2024.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet private weak var tbleView: UITableView!
    @IBOutlet private weak var favCollectionView: UICollectionView!
    @IBOutlet weak var favoriteViewHeight: NSLayoutConstraint!
    
    private var viewModel: MovieViewModel = MovieViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    private func configuration() {
        configureTableView()
        fetchDataFromServer()
        configureCollectionView()
    }
    
    private func configureTableView() {
        tbleView.delegate = self
        tbleView.dataSource = self
        let nibName = UINib(nibName: MoviesCell.cellIdentifier, bundle: nil)
        tbleView.register(nibName, forCellReuseIdentifier: MoviesCell.cellIdentifier)
    }
    
    private func configureCollectionView() {
        favCollectionView.delegate = self
        favCollectionView.dataSource = self
        let nibName = UINib(nibName: FavItemCollectionViewCell.cellIdentifier, bundle: nil)
        favCollectionView.register(nibName, forCellWithReuseIdentifier: FavItemCollectionViewCell.cellIdentifier)
    }
    
    private func registerObserver() {
        NotificationCenter.default.addObserver(forName: .notifyWhenComplete,
                                               object: nil, queue: nil) { _ in self.needToReloadViews() }
    }
    
    private func needToReloadViews() {
        tbleView.reloadData()
        favCollectionView.reloadData()
    }
    
    //MARK: - remove observer to avoid memory leakage
    deinit { NotificationCenter.default.removeObserver(self) }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesCell.cellIdentifier, for: indexPath) as? MoviesCell else { return UITableViewCell() }
        cell.configureMovieCell(viewModel.movies?[indexPath.row])
        cell.updateFavorite = { [weak self] data in
            guard let self = self, let data = data else { return }
            self.viewModel.movies = self.viewModel.movies?.map { movie in
                var updatedMovie = movie
                if movie.trackId == data.trackId {
                    updatedMovie.isFavorite = data.isFavorite
                }
                return updatedMovie
            }
            let hasFavorites = self.viewModel.movies?.contains(where: { $0.isFavorite }) ?? false
            self.favoriteViewHeight.constant = hasFavorites ? 85.0 : 0.0
            self.favCollectionView.reloadData()
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension MovieViewController {
    private func fetchDataFromServer() {
        viewModel.fetchMoviesList()
        registerObserver()
    }
    
    func toggleFavoriteStatus(for movie: MoviesResult) {
        viewModel.toggleFavoriteStatus(for: movie)
        needToReloadViews()
    }
}

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let movies = viewModel.movies else {
            return 0
        }
        
        let favoriteCount = movies.filter { $0.isFavorite }.count
        return favoriteCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavItemCollectionViewCell.cellIdentifier, for: indexPath) as? FavItemCollectionViewCell else { return UICollectionViewCell() }
        let favMovies = viewModel.movies?.filter { $0.isFavorite }
        cell.configureMovieCell(favMovies?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 85.0, height: 85.0)
    }
}


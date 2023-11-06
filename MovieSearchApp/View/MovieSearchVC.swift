//
//  ViewController.swift
//  MovieSearchApp
//
//  Created by BerkH on 4.11.2023.
//

import UIKit
import Kingfisher

class MovieSearchVC: UIViewController, MovieViewModelOutput {
    
    func updateView(search: [Movie]?, error: String?) {
        if let error = error {
            self.titleError.text = "No movie found"
            print(error)
            self.movieSearchCollectionView.isHidden = true
            self.titleError.isHidden = false
        } else {
            if let search = search {
                self.searchs = search
                self.movieSearchCollectionView.isHidden = false
                self.titleError.isHidden = true
                print(searchs)
                self.movieSearchCollectionView.reloadData()
            }
        }
    }
    var searchs: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.movieSearchCollectionView.reloadData()
            }
        }
    }
    private let viewModel: MovieViewModel
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let titleError: UILabel = {
        let label = UILabel()
        label.text = "Search a movie"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let movieSearchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieSearchCVC.self, forCellWithReuseIdentifier: "movieCell")
        return collectionView
    }()
    
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.movieOutput = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupViews()
    }

    private func setupViews(){
        view.backgroundColor = .black
        movieSearchCollectionView.backgroundColor = .black
        
        movieSearchCollectionView.delegate = self
        movieSearchCollectionView.dataSource = self
        movieSearchCollectionView.isScrollEnabled = true
        movieSearchCollectionView.showsVerticalScrollIndicator = false
        self.movieSearchCollectionView.isHidden = true
        self.titleError.isHidden = false
        
        view.addSubview(titleError)
        view.addSubview(movieSearchCollectionView)
        
        NSLayoutConstraint.activate([
            movieSearchCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            movieSearchCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieSearchCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieSearchCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            movieSearchCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            titleError.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleError.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
        ])
    }
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        searchController.searchBar.tintColor = UIColor.systemGray
        searchController.searchBar.searchTextField.backgroundColor = UIColor.white
        searchController.searchBar.searchTextField.leftView?.tintColor = UIColor.systemGray
        if let searchTextField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField.clipsToBounds = true
            searchTextField.layer.cornerRadius = 15.0
            searchTextField.attributedPlaceholder = NSAttributedString(string: searchTextField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
            searchTextField.textColor = UIColor.systemGray
        }
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

}

extension MovieSearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieSearchCVC else {
            fatalError("Hücre oluşturulamadı")
        }
        let search = searchs[indexPath.item]
        cell.lblTitle.text = search.title
        cell.lblYear.text = search.year
        if let url = URL(string: search.poster) {
            cell.imgMovie.kf.setImage(with: url)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = searchs[indexPath.item]
        let selectedMovieId = selectedMovie.imdbID
        
        let movieDetailService: APIManagerProtocol = APIManager()
        let viewModel = MovieDetailViewModel(movieDetailService: movieDetailService)
        let movieDetailVC = MovieDetailsVC(viewModel: viewModel)
        movieDetailVC.selectedMovieId = selectedMovieId
        navigationController?.pushViewController(movieDetailVC, animated: true)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 200)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
extension MovieSearchVC: UISearchResultsUpdating{
     func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            let formattedSearchText = searchText.replacingOccurrences(of: " ", with: "+")
            let urlString = Constants.Urls.searchMovieExtension + formattedSearchText

            if let url = URL(string: urlString) {
                let movieService: APIManagerProtocol = APIManager()
                let viewModel = MovieViewModel(movieService: movieService, movieOutput: self)
                viewModel.fetchMovieSearchs(url: url)
            }
        }
    }
}

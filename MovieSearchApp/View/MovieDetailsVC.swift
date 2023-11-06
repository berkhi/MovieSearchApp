//
//  MovieDetailsVC.swift
//  MovieSearchApp
//
//  Created by BerkH on 5.11.2023.
//

import UIKit
import Kingfisher

class MovieDetailsVC: UIViewController, MovieDetailViewModelOutput {
    func updateView(search: MovieDetail?, error: String?) {
        DispatchQueue.main.async{
            if let search = search{
                self.lblTitle.text = search.title
                self.lblYear.text = search.year
                self.lblActors.text = search.actors
                self.lblCountry.text = search.country
                self.lblDirector.text = "Director: \(search.director)"
                self.lblRating.text = "IMDB Rating: \(search.imdbRating)"
                if let url = URL(string: search.poster) {
                    self.imgMovie.kf.setImage(with: url)
                }
                print(search)
            }else{
                if let error{
                    print(error)
                }
            }
        }
        
    }
    private let viewModel: MovieDetailViewModel
    var selectedMovieId: String?
    
    let detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let imgMovie: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let lblTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let lblYear: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let lblActors: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let lblCountry: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let lblDirector: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let lblRating: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.movieDetailOutput = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.viewModel.fetchMovieDetail(for: selectedMovieId ?? "")
    }
    
    private func setupViews(){
        view.backgroundColor = UIColor.black
        
        detailStackView.addArrangedSubview(imgMovie)
        detailStackView.addArrangedSubview(lblTitle)
        detailStackView.addArrangedSubview(lblYear)
        detailStackView.addArrangedSubview(lblActors)
        detailStackView.addArrangedSubview(lblCountry)
        detailStackView.addArrangedSubview(lblDirector)
        detailStackView.addArrangedSubview(lblRating)
        
        view.addSubview(detailStackView)
        
        NSLayoutConstraint.activate([
            detailStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            detailStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            detailStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            
            imgMovie.topAnchor.constraint(equalTo: detailStackView.topAnchor),
            imgMovie.leadingAnchor.constraint(equalTo: detailStackView.leadingAnchor),
            imgMovie.trailingAnchor.constraint(equalTo: detailStackView.trailingAnchor),
            imgMovie.heightAnchor.constraint(equalToConstant: 350),
            
            lblTitle.topAnchor.constraint(equalTo: imgMovie.bottomAnchor, constant: 8),
            lblTitle.leadingAnchor.constraint(equalTo: detailStackView.leadingAnchor),
            lblTitle.trailingAnchor.constraint(equalTo: detailStackView.trailingAnchor),
            
            lblYear.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 8),
            lblYear.leadingAnchor.constraint(equalTo: detailStackView.leadingAnchor),
            lblYear.trailingAnchor.constraint(equalTo: detailStackView.trailingAnchor),
            
            lblActors.topAnchor.constraint(equalTo: lblYear.bottomAnchor, constant: 8),
            lblActors.leadingAnchor.constraint(equalTo: detailStackView.leadingAnchor),
            lblActors.trailingAnchor.constraint(equalTo: detailStackView.trailingAnchor),
            
            lblCountry.topAnchor.constraint(equalTo: lblActors.bottomAnchor, constant: 8),
            lblCountry.leadingAnchor.constraint(equalTo: detailStackView.leadingAnchor),
            lblCountry.trailingAnchor.constraint(equalTo: detailStackView.trailingAnchor),
            
            lblDirector.topAnchor.constraint(equalTo: lblCountry.bottomAnchor, constant: 8),
            lblDirector.leadingAnchor.constraint(equalTo: detailStackView.leadingAnchor),
            lblDirector.trailingAnchor.constraint(equalTo: detailStackView.trailingAnchor),
            
            lblRating.topAnchor.constraint(equalTo: lblDirector.bottomAnchor, constant: 8),
            lblRating.leadingAnchor.constraint(equalTo: detailStackView.leadingAnchor),
            lblRating.trailingAnchor.constraint(equalTo: detailStackView.trailingAnchor),
            lblRating.bottomAnchor.constraint(equalTo: detailStackView.bottomAnchor, constant: -8)
        ])

    }
    
}


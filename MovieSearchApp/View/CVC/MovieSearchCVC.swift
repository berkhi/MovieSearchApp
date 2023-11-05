//
//  MovieSearchCVC.swift
//  MovieSearchApp
//
//  Created by BerkH on 5.11.2023.
//

import UIKit

class MovieSearchCVC: UICollectionViewCell {
    
    let imgMovie: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    let lblTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lblYear: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
//        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
    }
    
    func addViews(){
        addSubview(imgMovie)
        addSubview(lblTitle)
        addSubview(lblYear)
        
        imgMovie.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imgMovie.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        imgMovie.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imgMovie.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        lblTitle.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: imgMovie.trailingAnchor, constant: 32).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        lblTitle.textAlignment = .center

        lblYear.topAnchor.constraint(equalTo: lblTitle.bottomAnchor).isActive = true
        lblYear.leadingAnchor.constraint(equalTo: imgMovie.trailingAnchor, constant: 32).isActive = true
        lblYear.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        lblYear.textAlignment = .center
        
    }
    
    func configureUI() {
        backgroundColor = .white
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 10
    }
}

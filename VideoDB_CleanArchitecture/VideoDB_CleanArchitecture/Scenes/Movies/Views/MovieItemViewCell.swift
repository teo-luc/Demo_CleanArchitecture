//
//  MovieViewCell.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/6/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import UIKit
import Kingfisher

class MovieItemViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView  : UIImageView!
    @IBOutlet weak var titleLabel       : UILabel!
    @IBOutlet weak var overviewLabel    : UILabel!
    @IBOutlet weak var releaseDateLabel : UILabel!
    @IBOutlet weak var ratingLabel      : UILabel!
    
    func bind(viewModel: MovieItemViewModel) {
        titleLabel.text       = viewModel.title
        overviewLabel.text    = viewModel.overview
        releaseDateLabel.text = viewModel.releaseDate
        ratingLabel.text      = viewModel.rating
        posterImageView.kf.setImage(with: viewModel.posterPath)
    }
}

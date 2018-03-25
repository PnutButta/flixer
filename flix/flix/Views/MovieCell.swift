//
//  MovieCell.swift
//  flix
//
//  Created by Angel Chara'e Mitchell on 2/7/18.
//  Copyright © 2018 Angel Chara'e Mitchell. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    var movie: Movie! {
        didSet {
            if movie.posterUrl != nil {
                poster.af_setImage(withURL: movie.posterUrl!)
            }
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
        }
    }
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  DetailViewController.swift
//  flix
//
//  Created by Angel Chara'e Mitchell on 2/17/18.
//  Copyright © 2018 Angel Chara'e Mitchell. All rights reserved.
//

import UIKit
import AlamofireImage

enum MovieKeys {
    static let backdropPath = "backdrop_path"
    static let posterPath = "poster_path"
}

class DetailViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    var photoUrl: URL!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posterImageView.layer.borderWidth = 2.0
        posterImageView.layer.borderColor = UIColor.white.cgColor
        
        if let movie = movie {
            titleLabel.text = movie.title
            releaseLabel.text = movie.release_date
            overviewLabel.text = movie.overview

            if posterImageView != nil {
                posterImageView.af_setImage(withURL: movie.posterUrl!)
            }

            if backgroundImageView != nil {
                backgroundImageView.af_setImage(withURL: movie.backdropUrl!)
            }
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

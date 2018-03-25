//
//  SuperheroViewController.swift
//  flix
//
//  Created by Angel Chara'e Mitchell on 2/26/18.
//  Copyright © 2018 Angel Chara'e Mitchell. All rights reserved.
//

import UIKit
import AlamofireImage


class SuperheroViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var movies: [Movie] = []
    var refresh: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(SuperheroViewController.pullToRefresh(_:)),
                          for: .valueChanged)
        
        self.navigationItem.title = "Superhero"
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.backgroundColor = UIColor(red: 1.0, green: 0.25, blue: 0.25, alpha: 0.8)
        }
        
        collectionView.dataSource = self
        fetchMovies()

        // Do any additional setup after loading the view.
    }
    
    @objc func  pullToRefresh(_ refresh: UIRefreshControl) {
        fetchMovies()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let newMovie = movies[indexPath.item]
        if newMovie.posterUrl != nil {
            cell.posterImageView.af_setImage(withURL: newMovie.posterUrl!)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell =  sender as! UICollectionViewCell
        if let indexPath = collectionView.indexPath(for: cell) {
            let newMovie = movies[indexPath.item]
            let destinationViewController = segue.destination as! DetailViewController
            destinationViewController.movie = newMovie
            destinationViewController.photoUrl = newMovie.posterUrl
        }
    }
    
    func fetchMovies() {
        MovieApiManager().superheroMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.collectionView.reloadData()
                self.refresh.endRefreshing()
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

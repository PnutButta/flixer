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
        let url = URL(string: "https://api.themoviedb.org/3/movie/284054/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: [])
                    as! [String: Any]
                let movieDictionaries = dataDictionary["results"] as! [[String : Any]]
                self.movies = Movie.movies(dictionaries: movieDictionaries)
                
                //Reload your table view data
                self.collectionView.reloadData()
                self.refresh.endRefreshing()
            }
        }
        task.resume()
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

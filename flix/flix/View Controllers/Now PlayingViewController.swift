//
//  Now PlayingViewController.swift
//  flix
//
//  Created by Angel Chara'e Mitchell on 2/6/18.
//  Copyright © 2018 Angel Chara'e Mitchell. All rights reserved.
//

import UIKit
import AlamofireImage

class Now_PlayingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var movies: [Movie] = []
    var refresh: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Now Playing"
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.backgroundColor = UIColor(red: 1.0, green: 0.25, blue: 0.25, alpha: 0.8)
        }
            
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(Now_PlayingViewController.pullToRefresh(_:)),
                          for: .valueChanged)
        tableView.insertSubview(refresh, at: 0)
        
        tableView.estimatedRowHeight = 208
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self

        fetchMovies()
    }
    
    @objc func  pullToRefresh(_ refresh: UIRefreshControl) {
        fetchMovies()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.movie = movies[indexPath.row]
        return cell
    }
    
    func fetchMovies() {
        MovieApiManager().popularMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
                self.refresh.endRefreshing()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell =  sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let newMovie = movies[indexPath.row]
            let destinationViewController = segue.destination as! DetailViewController
            destinationViewController.movie = newMovie
            destinationViewController.photoUrl = newMovie.posterUrl
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

////
////  NowPlayingViewController.swift
////  FlixApp
////
////  Created by Harika Lingareddy on 1/14/18.
////  Copyright © 2018 Harika Lingareddy. All rights reserved.
////
//
//import UIKit
//
//class NowPlayingViewController: UIViewController, UITableViewDataSource {
//
//    @IBOutlet weak var tableView: UITableView!
//    var movies: [[String: Any]] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.dataSource = self
//
//        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
//        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
//        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
//        let task = session.dataTask(with: request) { (data, response, error) in
//            // This will run when the network request returns
//            if let error = error {
//                print(error.localizedDescription)
//            } else if let data = data {
//                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//
//                //print(dataDictionary)
//                let movies = dataDictionary["results"] as! [[String: Any]]
////                for movie in movies {
////                    let title = movie["title"] as! String
////                    print(title)
////                }
//
//                self.movies = movies
//                self.tableView.reloadData()
//
//
//                // TODO: Get the array of movies
//                // TODO: Store the movies in a property to use elsewhere
//                // TODO: Reload your table view data
//
//            }
//        }
//        task.resume()
//
//        // Do any additional setup after loading the view.
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return movies.count
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
//
//        let movie = movies[indexPath.row]
//        let title = movie["title"] as! String
//        let overview = movie["overview"] as! String
//
//        cell.titleLabel.text = title
//        cell.overviewLabel.text = overview
//
//        return cell
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}

//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Harika Lingareddy on 1/14/18.
//  Copyright © 2018 Harika Lingareddy. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource {
    var movies: [[String: Any]] = []
    var refresh: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(NowPlayingViewController.pull(_:)), for: .valueChanged)
        tableView.insertSubview(refresh, at: 0)
        
        tableView.dataSource = self
        fetch()
        
        //        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        //        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        //        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        //        let task = session.dataTask(with: request) { (data, response, error) in
        //            // This will run when the network request returns
        //            if let error = error {
        //                print(error.localizedDescription)
        //            } else if let data = data {
        //                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        //                //print(dataDictionary)
        //                let movies = dataDictionary["results"] as! [[String: Any]]
        //                //                for movie in movies {
        //                //                    let title = movie["title"] as! String
        //                //                    print(title)
        //                //                }
        //
        //                self.movies = movies
        //                self.tableView.reloadData()
        //                // TODO: Get the array of movies
        //                // TODO: Store the movies in a property to use elsewhere
        //                // TODO: Reload your table view data
        //
        //            }
        //        }
        //        task.resume()
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func pull(_ refresh: UIRefreshControl) {
        fetch()
    }
    
    func fetch() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                //print(dataDictionary)
                let movies = dataDictionary["results"] as! [[String: Any]]
                //                for movie in movies {
                //                    let title = movie["title"] as! String
                //                    print(title)
                //                }
                
                self.movies = movies
                self.tableView.reloadData()
                self.refresh.endRefreshing()
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        
        
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        let posterpathstring = movie["poster_path"] as! String
        
        let baseurlstring = "https://image.tmdb.org/t/p/w500"
        
        let posterURL = URL(string: baseurlstring + posterpathstring)!
        
        cell.posterImageView.af_setImage(withURL: posterURL)
        
        return cell
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



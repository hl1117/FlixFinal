import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource {
    //var movies: [[String: Any]] = []
    var movies: [Movie] = []
    var refresh: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(NowPlayingViewController.pull(_:)), for: .valueChanged)
        tableView.insertSubview(refresh, at: 0)
        
        tableView.dataSource = self
        fetch()
        
     
    }
    
    @objc func pull(_ refresh: UIRefreshControl) {
        fetch()
    }
    
    func fetch() {
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
//                self.refresh.endRefreshing()
//                // TODO: Get the array of movies
//                // TODO: Store the movies in a property to use elsewhere
//                // TODO: Reload your table view data
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
            }
        }
        
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.movie = movies[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



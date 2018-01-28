//
//  DetailViewController.swift
//  FlixApp
//
//  Created by Harika Lingareddy on 1/18/18.
//  Copyright © 2018 Harika Lingareddy. All rights reserved.
//

import UIKit

enum moviekeys {
    static let title = "title"
    static let backdropPath = "backdrop_path"
    static let posterPath = "poster_path"
}

class DetailViewController: UIViewController {

    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releasedateLabel: UILabel!
    
    var movie: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            titleLabel.text = movie[moviekeys.title] as? String
            releasedateLabel.text = movie["release_date"] as? String
            overviewLabel.text = movie["overview"] as? String
            
            let backdropPathString = movie[moviekeys.backdropPath] as! String
            let posterPathString = movie[moviekeys.posterPath] as! String
            let baseurlstring = ("https://image.tmdb.org/t/p/w500")
            let backdropURL = URL(string: baseurlstring + backdropPathString)!
            backdropImageView.af_setImage(withURL: backdropURL)
            let posterpathURL = URL(string: baseurlstring + posterPathString)!
            posterImageView.af_setImage(withURL: posterpathURL)
            
        }

        // Do any additional setup after loading the view.
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

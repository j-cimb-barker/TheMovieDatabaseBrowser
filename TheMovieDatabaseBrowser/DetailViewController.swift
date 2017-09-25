//
//  DetailViewController.swift
//  TheMovieDatabaseBrowser
//
//  Created by Joel Barker on 11/09/2017.
//  Copyright © 2017 Talking Cucumber Ltd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var movie = Movie ()
    
    @IBOutlet var moviePosterImageView: UIImageView!
    
    @IBOutlet var movieDetailsTextView: UITextView!
    
    @IBOutlet var votesLabel: UILabel!
    
    @IBOutlet var voteAvgLabel: UILabel!
    
    @IBOutlet var popLabel: UILabel!
    
    @IBOutlet var releaseLabel: UILabel!
    
    func configureView() {
        // Update the user interface for the detail item.

        self.movieDetailsTextView.text = movie.overView
        self.votesLabel.text = movie.voteCount.description
        self.voteAvgLabel.text = movie.voteAverage.description
        self.popLabel.text = movie.popularity.description
        
        // TODO : maybe reformat the date so it looks nicer...?
        self.releaseLabel.text = movie.relDate
        
        // TODO : images should be discovered a lot better:
        //To build an image URL, you will need 3 pieces of data. The base_url, size and file_path. Simply combine them all and you will have a fully qualified URL.
        // https://developers.themoviedb.org/3/configuration
        let imgUrlStr = "https://image.tmdb.org/t/p/w500/" + movie.posterPath
        
        self.title = "";
        
        // TODO : would be nice to have default image for movies that don't have images
        moviePosterImageView.imageFromServerURL(urlString: imgUrlStr)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}


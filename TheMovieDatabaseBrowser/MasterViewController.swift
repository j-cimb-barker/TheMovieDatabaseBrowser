//
//  MasterViewController.swift
//  TheMovieDatabaseBrowser
//
//  Created by Joel Barker on 11/09/2017.
//  Copyright © 2017 Talking Cucumber Ltd. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()

    let headings = ["New in Theatres", "Popular", "Highest Rated This Year"]
    
    var popularMovies = [Movie] ()
    var newMovies = [Movie] ()
    var ratedMovies = [Movie] ()
    
    var selectedMovie = Movie ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // prettify the table
        self.tableView.separatorStyle = .none
        
        self.tableView.backgroundView?.backgroundColor = UIColor.white
        
        // remove nav bar line
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")

        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        TheMovieDatabaseApi.getPopularMoviesBlock { (movies : [Movie], errorStr: String) in
            
            Logging.JLog(message: "errorStr : \(errorStr)")
            Logging.JLog(message: "movies : \(movies.count)")
            
            self.popularMovies = movies
            self.checkFinishedDownloading()
            
            Logging.JLog(message: "popularMovies : \(self.popularMovies.count)")
            
            if errorStr != "" {
                self.showErrorMessage(msg: errorStr)
            }
        }
        
        TheMovieDatabaseApi.getNewMoviesInTheatreBlock { (movies : [Movie], errorStr: String) in
            
            Logging.JLog(message: "errorStr : \(errorStr)")
            Logging.JLog(message: "movies : \(movies.count)")
            
            self.newMovies = movies
            self.checkFinishedDownloading()

            
            Logging.JLog(message: "popularMovies : \(self.newMovies.count)")
            
            if errorStr != "" {
                self.showErrorMessage(msg: errorStr)
            }
        }
        
        TheMovieDatabaseApi.getTopRatedMoviesThisYearBlock { (movies : [Movie], errorStr: String) in
            
            Logging.JLog(message: "errorStr : \(errorStr)")
            Logging.JLog(message: "movies : \(movies.count)")
            
            self.ratedMovies = movies
            self.checkFinishedDownloading()

            
            Logging.JLog(message: "popularMovies : \(self.ratedMovies.count)")
            
            if errorStr != "" {
                self.showErrorMessage(msg: errorStr)
            }
        }
        
    }
    
    func showErrorMessage (msg: String) {
        
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // ui updates on the main thread...
        DispatchQueue.main.async { [unowned self] in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    

    
    func checkFinishedDownloading () {
        
        Logging.JLog(message: "ratedMovies : \(ratedMovies.count)")
        Logging.JLog(message: "popularMovies : \(popularMovies.count)")
        Logging.JLog(message: "newMovies : \(newMovies.count)")
        
        DispatchQueue.main.async { [unowned self] in
            
            if (self.ratedMovies.count > 0) && (self.popularMovies.count > 0) && (self.newMovies.count > 0) {
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed

        // hide the title on the main page
        self.title = ""
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // this will set the back button title on the next page
        self.title = "Movies"
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(_ sender: Any) {
        objects.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.movie = selectedMovie
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true

        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return headings.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        Logging.JLog(message: "headings : \(headings.count)")
        
        return 1
    }

    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        
        let headerLabel = UILabel(frame: CGRect(x: 27, y: 40, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Helvetica", size: 20)
        headerLabel.textColor = UIColor.black
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return headings [section]
    }
        
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        guard let tableViewCell = cell as? CollectionTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSource(self, withRow: indexPath.section)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //cell.textLabel!.text = headings [indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    /*
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }*/


}

// MARK: - CollectionView methods

extension MasterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch collectionView.tag {
        case 1:
            return popularMovies.count
        case 2:
            return ratedMovies.count
        default:
            return newMovies.count
            
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell

        var movieShow = Movie ()
        
        switch collectionView.tag {
        case 1:
            movieShow = popularMovies [indexPath.item]
        case 2:
            movieShow = ratedMovies [indexPath.item]
        default:
            movieShow = newMovies [indexPath.item]
            
        }
        
        cell.movieTitleLabel.text = movieShow.title

        // TODO : images should be discovered a lot better:
        //To build an image URL, you will need 3 pieces of data. The base_url, size and file_path. Simply combine them all and you will have a fully qualified URL.
        // https://developers.themoviedb.org/3/configuration
        let imgUrlStr = "https://image.tmdb.org/t/p/w500/" + movieShow.backdropPath
        
        
        // TODO : would be nice to have default image for movies that don't have images
        cell.movieImageView.imageFromServerURL(urlString: imgUrlStr)
        
        cell.movieImageView.layer.cornerRadius = 5.0;
        cell.movieImageView.layer.masksToBounds = true;
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        Logging.JLog(message: "selected cell : \(collectionView.tag), idx : \(indexPath.row), sec : \(indexPath.section)")
        
        
        
        switch collectionView.tag {
        case 1:
            selectedMovie = popularMovies [indexPath.row]
        case 2:
            selectedMovie = ratedMovies [indexPath.row]
        default:
            selectedMovie = newMovies [indexPath.row]

        }
        
        
        self.performSegue(withIdentifier: "showDetail", sender: nil)
//        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}






//
//  TheMovieDatabaseApi.swift
//  TheMovieDatabaseBrowser
//
//  Created by Joel Barker on 11/09/2017.
//  Copyright © 2017 Talking Cucumber Ltd. All rights reserved.
//
//  Handles interaction

import Foundation
import UIKit

class TheMovieDatabaseApi {
    
    static let sharedInstance = TheMovieDatabaseApi ()
    
    static let API_KEY = "fb698af1206e7d2003d5f69ff2e5f492"
    
    static func getNewMoviesInTheatreBlock (completionClosure: @escaping (_ movies :[Movie], _ errorStr: String) ->()) {
    
        // assume from last month
        let lastMonth = Calendar.current.date(byAdding: .day, value: -31, to: Date())
        let lastMonthStr = lastMonth?.toString(dateFormat: "yyyy-MM-dd")
        
        // need to avoid finding planned releases
        let today = Date ()
        
        let todayStr = today.toString(dateFormat: "yyyy-MM-dd")
        
        let urlFragment = "discover/movie?primary_release_date.gte=" + lastMonthStr! + "&primary_release_date.lte=" + todayStr + "&sort_by=primary_release_date.asc"
        
        
        self.getMoviesFromMovieDatabaseBlock(urlFragment: urlFragment) { (movies : [Movie], errorStr: String) in
            completionClosure(movies, errorStr)
        }
        
    }
    
    static func getTopRatedMoviesThisYearBlock (completionClosure: @escaping (_ movies :[Movie], _ errorStr: String) ->()) {
        
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let yearStr = Int (year).description
        
        let urlFragment = "discover/movie?primary_release_year=" + yearStr + "&vote_count.gte=1000&sort_by=vote_average.desc"
        
        Logging.JLog (message: "urlFragment : \(urlFragment)")
        
        self.getMoviesFromMovieDatabaseBlock(urlFragment: urlFragment) { (movies : [Movie], errorStr: String) in
            completionClosure(movies, errorStr)
        }
        
    }
    
    static func getPopularMoviesBlock (completionClosure: @escaping (_ movies :[Movie], _ errorStr: String) ->()) {
        
        let urlFragment = "discover/movie?sort_by=popularity.desc"
        
        self.getMoviesFromMovieDatabaseBlock(urlFragment: urlFragment) { (movies : [Movie], errorStr: String) in
            completionClosure(movies, errorStr)
        }

        
    }
    
    

    static func getMoviesFromMovieDatabaseBlock (urlFragment: String,
                                                 completionClosure: @escaping (_ movies :[Movie], _ errorStr: String) ->()) {
        
        Logging.JLog(message: "urlFragment1 : \(urlFragment)")
        
        ///discover/movie?sort_by=popularity.desc
        //https://api.themoviedb.org/3/movie/76341?api_key={api_key}
        
        URLCache.shared.removeAllCachedResponses()
        
        let urlStr = "https://api.themoviedb.org/3/" + urlFragment + "&api_key=" + API_KEY
        
        //let urlStr = "https://api.themoviedb.org/3/discover/movie?primary_release_year=2017&sort_by=vote_average.desc"  + "&api_key=" + API_KEY
        
        Logging.JLog(message: "urlStr1 : \(urlStr)")
        
        let url = URL(string: urlStr)
        var urlRequest = URLRequest (url: url!)
        urlRequest.cachePolicy = .reloadIgnoringCacheData
        
        let session = URLSession.shared
        
        var movies = [Movie] ()
        var errorStr = ""
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                Logging.JLog(message: "error...!")
                Logging.JLog(message: error.debugDescription)
                
                errorStr = (error?.localizedDescription)!
                
                completionClosure(movies, errorStr)
                return;
            }
            // make sure we got data
            guard let responseData = data else {
                Logging.JLog(message: "Error: did not receive data")
                
                errorStr = "No data returned from server."
                
                
                
                completionClosure(movies, errorStr)
                return
            }
            
            Logging.JLog(message: "responseData : \(responseData)")
            
            let jsonStr = String(data: responseData, encoding: .utf8)
            
            Logging.JLog(message: "jsonStr : \(jsonStr!)")
            
            // should be json...
            do {
                
                let jsonObj = try JSONSerialization.jsonObject(with: responseData, options: [])
                
                var jsonDict = [String : Any]()
                
                if let jsonArray = jsonObj as? [[String : Any]] {
                    
                    // its an array...
                    if jsonArray.count == 0 {
                        
                        Logging.JLog(message: "invalid response")
                        errorStr = "Server returned invalid response."
                        
                        completionClosure(movies, errorStr)
                    }
                    
                    jsonDict = jsonArray[0]
                    
                } else {
                    // or a dict
                    jsonDict = (jsonObj as? [String : Any])!
                }
                
                Logging.JLog(message: "jsonDict : \(jsonDict)")
                
                let movieDicts = jsonDict ["results"] as! [[String:Any]]
                
                
                
                for movieDict in movieDicts {
                    
                    Logging.JLog(message: "making movie from : \(movieDict)")
                    
                    let movie = Movie (jsonDict: movieDict)
                    
                    Logging.JLog(message: "movieMade : \(movie.toStr())")
                    
                    movies.append (movie)
                }
                
                Logging.JLog(message: "movies found : \(movies.count)")
                
                
                
                completionClosure(movies, errorStr)
                
                
            } catch  {
                
                
                print("error trying to convert data to JSON")
                completionClosure(movies, errorStr)
            }
        }
        task.resume()

        
    }
    
    
    
    
    

    
    
    
    


}


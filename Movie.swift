//
//  File.swift
//  TheMovieDatabaseBrowser
//
//  Created by Joel Barker on 11/09/2017.
//  Copyright © 2017 Talking Cucumber Ltd. All rights reserved.
//

import Foundation

class Movie {
    
    var voteCount = 0
    var id = 0
    var isVideo = false
    var voteAverage = 0.0
    var title = ""
    var popularity = 0.0
    var posterPath = ""
    var origLang = "en"
    var origTitle = ""
    var genreIds = [Int]()
    var backdropPath = ""
    var isAdult = false
    var overView = ""
    var relDate = ""
    
    init () {
        self.voteCount = 0
        self.id = 0
        self.isVideo = false
        self.voteAverage = 0.0
        self.title = ""
        self.popularity = 0.0
        self.posterPath = ""
        self.origLang = "en"
        self.origTitle = ""
        self.genreIds = [Int]()
        self.backdropPath = ""
        self.isAdult = false
        self.overView = ""
        self.relDate = ""
    }
    
    init (jsonDict: [String : Any]) {
     
        self.voteCount = jsonDict ["vote_count"] as! Int!
        self.id = jsonDict ["id"] as! Int!
        
        self.isVideo = jsonDict ["video"] as! Bool
        
        self.voteAverage = jsonDict ["vote_average"] as! Double!
        self.title = jsonDict ["title"] as! String
        self.popularity = jsonDict ["popularity"] as! Double!

        if !(jsonDict ["poster_path"] is NSNull) {
            if let posterPathCheck = jsonDict ["poster_path"] as! String?
            {
                self.posterPath = posterPathCheck
            }
        }
        

        
        self.origLang = jsonDict ["original_language"] as! String
        self.origTitle = jsonDict ["original_title"] as! String

        self.genreIds = jsonDict ["genre_ids"] as! [Int]
        
        if jsonDict ["backdrop_path"] == nil {
            Logging.JLog(message: "sss")
        }
        
        if !(jsonDict ["backdrop_path"] is NSNull) {
            if let backdropPathCheck = jsonDict ["backdrop_path"] as! String? {
                self.backdropPath = backdropPathCheck
            }
        
        }
            
        
        
        self.isAdult = jsonDict ["adult"] as! Bool
        
        self.overView = jsonDict ["overview"] as! String
        self.relDate = jsonDict ["release_date"] as! String
        
    }
    
    func toStr () -> String {
        
        var retStr = ""
        
        retStr = retStr + "id : \(self.id)"
        retStr = retStr + ", voteCount : \(self.voteCount)"
        retStr = retStr + ", videoStr : \(self.isVideo)"
        retStr = retStr + ", voteAverage : \(self.voteAverage)"
        retStr = retStr + ", title : \(self.title)"
        retStr = retStr + ", popularity : \(self.popularity)"
        retStr = retStr + ", origLang : \(self.origLang)"
        retStr = retStr + ", genreIds : \(self.genreIds)"
        retStr = retStr + ", backdropPath : \(self.backdropPath)"
        retStr = retStr + ", overView : \(self.overView)"
        retStr = retStr + ", adultStr : \(self.isAdult)"
        retStr = retStr + ", relDate : \(self.relDate)"
        
        return retStr
    }

    
    /*
    {"vote_count":4381,"id":211672,"video":false,"vote_average":6.4,"title":"Minions","popularity":1119.773447,"poster_path":"\/q0R4crx2SehcEEQEkYObktdeFy.jpg","original_language":"en","original_title":"Minions","genre_ids":[10751,16,12,35],"backdrop_path":"\/uX7LXnsC7bZJZjn048UCOwkPXWJ.jpg","adult":false,"overview":"Minions Stuart, Kevin and Bob are recruited by Scarlet Overkill, a super-villain who, alongside her inventor husband Herb, hatches a plot to take over the world.","release_date":"2015-06-17"}*/
    
    
}

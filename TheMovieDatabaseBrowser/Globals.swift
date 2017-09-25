//
//  Globals.swift
//  VivusQR
//
//  Created by Joel Barker on 11/09/2017.
//  Copyright © 2017 Talking Cucumber Ltd. All rights reserved.
//
//  Singleton for useful constants that are used everywhere.

import Foundation

class Globals {

     static let shared = Globals ()
    
    let GOT_NEW_MOVIES = "com.talkingcucumberltd.moviebrowser.gotnewmovies"

    let GOT_POPULAR_MOVIES = "com.talkingcucumberltd.moviebrowser.gotpopularmovies"
    
    let GOT_TOP_RATED_MOVIES_FOR_YEAR = "com.talkingcucumberltd.moviebrowser.gottopratedmoviesforyear"

    let ERROR_GETTING_MOVIES = "com.talkingcucumberltd.moviebrowser.errorgettingmovies"
 
}



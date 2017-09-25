//
//  TheMovieDatabaseApiTest.swift
//  TheMovieDatabaseBrowser
//
//  Created by Joel Barker on 11/09/2017.
//  Copyright © 2017 Talking Cucumber Ltd. All rights reserved.
//

import XCTest

class TheMovieDatabaseApiTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    var exp:XCTestExpectation?

    var exp1:XCTestExpectation?

    var exp2:XCTestExpectation?
    
    
    
    func testGetSomeMovies () {
        
        exp = expectation(description: "Some movies found")
        
        TheMovieDatabaseApi.getNewMoviesInTheatreBlock { (movies : [Movie], errorStr: String) in
            
            Logging.JLog(message: "errorStr : \(errorStr)")
            Logging.JLog(message: "movies : \(movies.count)")
            
            for movie in movies {
                Logging.JLog(message: "movie : \(movie.toStr())")
            }
            
            if movies.count > 0 {
                self.exp?.fulfill()
            }
        }
        
        waitForExpectations(timeout: 20) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testGetSomeTopRatedMovies () {
        
        exp = expectation(description: "Some movies found")
        
        TheMovieDatabaseApi.getTopRatedMoviesThisYearBlock { (movies : [Movie], errorStr: String) in
            
            Logging.JLog(message: "errorStr : \(errorStr)")
            Logging.JLog(message: "movies : \(movies.count)")
            
            for movie in movies {
                Logging.JLog(message: "movie : \(movie.toStr())")
            }
            
            if movies.count > 0 {
                self.exp?.fulfill()
            }
        }
        
        waitForExpectations(timeout: 20) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testGetSomePopularMovies () {
        
        exp = expectation(description: "Some movies found")
        
        TheMovieDatabaseApi.getPopularMoviesBlock { (movies : [Movie], errorStr: String) in
            
            Logging.JLog(message: "errorStr : \(errorStr)")
            Logging.JLog(message: "movies : \(movies.count)")
            
            for movie in movies {
                Logging.JLog(message: "movie : \(movie.toStr())")
            }
            
            if movies.count > 0 {
                self.exp?.fulfill()
            }
        }
        
        waitForExpectations(timeout: 20) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    
    
    
    
    

    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

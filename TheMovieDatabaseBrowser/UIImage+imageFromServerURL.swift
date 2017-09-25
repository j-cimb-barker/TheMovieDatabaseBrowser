//
//  UIImage+imageFromServerURL.swift
//  TheMovieDatabaseBrowser
//
//  Created by Joel Barker on 11/09/2017.
//  Copyright © 2017 Talking Cucumber Ltd. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {

    // NB: Would usually not use this. This was only used to avoid using a third-party library
    //     and to avoid network performance problems. It's not great seperation either...
    public func imageFromServerURL(urlString: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                Logging.JLog(message: error.debugDescription)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
                
                self.layer.cornerRadius = 25;
                self.layer.masksToBounds = true;
                
            })
            
        }).resume()
    }}

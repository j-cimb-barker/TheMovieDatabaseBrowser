//
//  Date+ToString.swift
//  TheMovieDatabaseBrowser
//
//  Created by Joel Barker on 12/09/2017.
//  Copyright © 2017 Talking Cucumber Ltd. All rights reserved.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}

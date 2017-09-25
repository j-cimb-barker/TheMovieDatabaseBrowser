
//
//  VivusQR
//
//  Created by Joel Barker on 15/06/2017.
//  Copyright © 2017 Talking Cucumber Ltd. All rights reserved.
//

import Foundation

class Logging {
    
    class func JLog(message: String, functionName: String = #function, fileName: String = #file, lineNum: Int = #line) {
        
        NSLog("\(fileName): \(functionName): \(lineNum): \(message)")
    }
    
}

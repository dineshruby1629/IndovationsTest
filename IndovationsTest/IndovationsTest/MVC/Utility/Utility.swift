//
//  Utilitys.swift
//  IndovationsTest
//
//  Created by dinesh chandra on 18/12/19.
//  Copyright © 2019 Indovations. All rights reserved.
//

import UIKit

class Utility: NSObject {

    class func dateformatter(_ date : String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let getDate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "MMM d, yyyy || h:mm a"
        return  dateFormatter.string(from: getDate!)
    }
    
}

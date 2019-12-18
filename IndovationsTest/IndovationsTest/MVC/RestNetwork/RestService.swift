//
//  RestService.swift
//  IndovationsTest
//
//  Created by dinesh chandra on 18/12/19.
//  Copyright © 2019 Indovations. All rights reserved.
//

import UIKit

class RestService: NSObject {
    
    static func getPostsList(_ url : String, finish : @escaping(Posts)->Void)
    {
        
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            
            guard data != nil else {
                finish(Posts())
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let postInfo = try jsonDecoder.decode(Posts.self, from: data!)
                finish(postInfo)
            } catch {
                print("Error is \(error)")
            }
        }.resume()

    }
    
}

//
//  JSONMockLoader.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation

struct JSONMockLoader {
    
    private init() {}
    
    public static func loadJSONFrom(file: String, usingClass: NSObject) -> [String: AnyObject]? {
        let testBundle = Bundle(for: type(of: usingClass))
        if let path = testBundle.path(forResource: file, ofType: "json") {
            do {
                let jsonData = try? NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    return try! JSONSerialization.jsonObject(
                        with: jsonData! as Data,
                        options: JSONSerialization.ReadingOptions.mutableContainers
                        ) as! [String: AnyObject]
                }
            }
        }
        return nil
    }
    
    public static func loadJSONData(file: String, usingClass: NSObject) -> Data? {
        let testBundle = Bundle(for: type(of: usingClass))
        if let path = testBundle.url(forResource: file, withExtension: "json") {
            do {
                return try? Data(contentsOf: path)
            }
        }
        return nil
    }
}

//
//  APIClient.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation

class APIClient {
    
    lazy var session: SessionProtocol = URLSession.shared
    
}

protocol SessionProtocol {
    func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: SessionProtocol {
    
}

extension APIClient {
    
}

//
//  Requests.swift
//  Dictionary
//
//  Created by Abdorahman Youssef on 7/4/19.
//  Copyright © 2019 abdelrahman.youssef. All rights reserved.
//

import Foundation

typealias Success = (Data?) -> Void
typealias Failure = (Error?) -> Void

class APIClient {
    
    static let baseURL = "https://www.jsonfiles.transliminal.org/"
    
    static func fetchJsonFile(withUrl url: String, success: @escaping Success, failure: @escaping Failure) {
        
        let fullString = baseURL + url
        guard let fullUrl = URL.init(string: fullString) else {
            failure(nil)
            return
        }
        
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession.init(configuration: sessionConfiguration)
        var request = URLRequest(url: fullUrl)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { (data, urlResponse, error) in
            if let error = error {
                failure(error)
            }else {
                if let data = data{
                    success(data)
                }
            }
        }
    }
}

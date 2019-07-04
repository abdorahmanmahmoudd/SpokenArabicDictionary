//
//  Requests.swift
//  Dictionary
//
//  Created by Abdorahman Youssef on 7/4/19.
//  Copyright © 2019 abdelrahman.youssef. All rights reserved.
//

import Foundation

class Requests {
    
    static func fetchArabicJsonFile(success: @escaping Success, failure: @escaping Failure) {
        let url = "ARABIC_WORD.json"
        APIClient.fetchJsonFile(withUrl: url, success: success, failure: failure)
    }
    
    static func fetchEnglishJsonFile(success: @escaping Success, failure: @escaping Failure) {
        let url = "ENGLISH_WORD.json"
        APIClient.fetchJsonFile(withUrl: url, success: success, failure: failure)
    }
    
    static func fetchConjugationsJsonFile(success: @escaping Success, failure: @escaping Failure) {
        let url = "CONJUGATIONS.json"
        APIClient.fetchJsonFile(withUrl: url, success: success, failure: failure)
    }
}

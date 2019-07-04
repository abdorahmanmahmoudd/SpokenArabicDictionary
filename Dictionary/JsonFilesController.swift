//
//  JsonFilesController.swift
//  Dictionary
//
//  Created by Abdorahman Youssef on 7/4/19.
//  Copyright © 2019 abdelrahman.youssef. All rights reserved.
//

import Foundation

class JsonFilesController {
    
    let dispatchGroup: DispatchGroup?
    
    init() {
        dispatchGroup = DispatchGroup.init()
    }
    
    func prepareDispatchGroup() {
        dispatchGroup?.notify(queue: DispatchQueue.main, execute: {
            print("Files downloaded")
        })
    }
    
    func updateJsonFiles() {
        
        updateArabicJsonFile()
        updateEnglishJsonFile()
        updateConjugationJsonFile()
        prepareDispatchGroup()
        
    }
    
    func updateArabicJsonFile() {
        
        dispatchGroup?.enter()
        
        Requests.fetchArabicJsonFile(success: { [weak self] (data) in
            guard let self = self else {
                return
            }
            self.dispatchGroup?.leave()
            
        }) { [weak self] (error) in
            guard let self = self else {
                return
            }
            self.dispatchGroup?.leave()
        }
    }
    
    func updateEnglishJsonFile() {
        
        dispatchGroup?.enter()
        
        Requests.fetchEnglishJsonFile(success: { [weak self] (data) in
            guard let self = self else {
                return
            }
            self.dispatchGroup?.leave()
            
        }) { [weak self] (error) in
            guard let self = self else {
                return
            }
            self.dispatchGroup?.leave()
        }
    }
    
    func updateConjugationJsonFile() {
        
        dispatchGroup?.enter()
        
        Requests.fetchConjugationsJsonFile(success: { [weak self] (data) in
            guard let self = self else {
                return
            }
            self.dispatchGroup?.leave()
            
        }) { [weak self] (error) in
            guard let self = self else {
                return
            }
            self.dispatchGroup?.leave()
        }
    }
}

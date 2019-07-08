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
    
    private func prepareDispatchGroup(completion: @escaping (() -> Void)) {
        dispatchGroup?.notify(queue: DispatchQueue.main, execute: {
            print("Files downloaded")
            completion()
        })
    }
    
    func updateJsonFiles(withCompletion completion: @escaping (() -> Void)) {
        
        updateArabicJsonFile()
        updateEnglishJsonFile()
        updateConjugationJsonFile()
        prepareDispatchGroup(completion: completion)
        
    }
    
    private func updateArabicJsonFile() {
        
        dispatchGroup?.enter()
        
        Requests.fetchArabicJsonFile(success: { [weak self] (data) in
            guard let self = self else {
                return
            }
            
            let jsonDecoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ" //2019-07-01T01:44:24.3381583+02:00
            jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            do  {
                if let data = data {
                    
                    let _ = try jsonDecoder.decode(ArabicSheet.self, from: data)
                    let fileManager = FileManager.default
                    let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create: true)
                    let filePath = documentDirectory.appendingPathComponent(ArabicWordsFile , isDirectory: false)
                    print(filePath.absoluteString)
                    try data.write(to: filePath, options: Data.WritingOptions.completeFileProtection)
                    
                }
            }catch let error {
                print(error)
            }
            
            self.dispatchGroup?.leave()
            
        }) { [weak self] (error) in
            guard let self = self else {
                return
            }
            self.dispatchGroup?.leave()
        }
    }
    
    private func updateEnglishJsonFile() {
        
        dispatchGroup?.enter()
        
        Requests.fetchEnglishJsonFile(success: { [weak self] (data) in
            guard let self = self else {
                return
            }
            
            let jsonDecoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ" //2019-07-01T01:44:24.3381583+02:00
            jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            do {
                if let data = data {
                    let _ = try jsonDecoder.decode(EnglishSheet.self, from: data)
                    let fileManager = FileManager.default
                    let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create: true)
                    let filePath = documentDirectory.appendingPathComponent(EnglishWordsFile , isDirectory: false)
                    print(filePath.absoluteString)
                    try data.write(to: filePath, options: Data.WritingOptions.completeFileProtection)
                }
            } catch let error {
                print(error)
            }
            
            self.dispatchGroup?.leave()
            
        }) { [weak self] (error) in
            guard let self = self else {
                return
            }
            self.dispatchGroup?.leave()
        }
    }
    
    private func updateConjugationJsonFile() {
        
        dispatchGroup?.enter()
        
        Requests.fetchConjugationsJsonFile(success: { [weak self] (data) in
            guard let self = self else {
                return
            }
            
            let jsonDecoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ" //2019-07-01T01:44:24.3381583+02:00
            jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            do {
                if let data = data {
                    let _ = try jsonDecoder.decode(ConjugationSheet.self, from: data)
                    let fileManager = FileManager.default
                    let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create: true)
                    let filePath = documentDirectory.appendingPathComponent(ConjugationsFile , isDirectory: false)
                    print(filePath.absoluteString)
                    try data.write(to: filePath, options: Data.WritingOptions.completeFileProtection)
                }
            } catch let error {
                print(error)
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

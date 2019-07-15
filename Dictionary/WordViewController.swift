//
//  WordViewController.swift
//  Dictionary
//
//  Created by abdelrahman.youssef on 6/23/17.
//  Copyright © 2017 abdelrahman.youssef. All rights reserved.
//

import UIKit

class WordViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var wordLabel: UILabel!
    
    var wordId: NSUUID?
    var PartOfSpeechArray : [(partOfSpeechText: String , words : [ArabicWord])] = [("",[])]
    var selectedWord : EnglishWord?
    var matchedArabicWords = [ArabicWord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()
        fillData()
    }
    
    func configuration(){
    
        tableView.tableFooterView = UIView(frame:CGRect.zero)
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 36;
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return PartOfSpeechArray[section].words.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cellIdentifier = "DetailsCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
        cell.textLabel?.text = PartOfSpeechArray[indexPath.section].words[indexPath.row].WORD
        
        return cell
    }
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return PartOfSpeechArray.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if PartOfSpeechArray[section].partOfSpeechText != partOfSpeechCategory[0] { // blank case
            return UITableView.automaticDimension
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if PartOfSpeechArray[section].partOfSpeechText != partOfSpeechCategory[0] { // blank case
            
            let headerView = UIView(frame: CGRect(x: 16, y: 0, width: tableView.frame.size.width, height: 40))
            
            headerView.backgroundColor = UIColor.white
            
            let headerLabel = UILabel(frame: CGRect(x: 16, y: 0, width: headerView.frame.size.width, height: headerView.frame.size.height))
            
            headerLabel.textColor = UIColor(red:182.0/255.0, green: 182.0/255.0, blue: 182.0/255.0, alpha: 1.0)
            
            headerLabel.textAlignment = NSTextAlignment.left
            
            headerLabel.font = UIFont.italicSystemFont(ofSize: 18)
            
            
            headerLabel.attributedText = NSAttributedString(string: PartOfSpeechArray[section].partOfSpeechText, attributes:
                convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.underlineStyle): NSUnderlineStyle.single.rawValue]))
            
            
            //        headerLabel.attributedText = NSAttributedString(string: PartOfSpeechArray[section].partOfSpeechText, attributes:
            //            [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
            
            headerView.addSubview(headerLabel)
            
            return headerView
        }
        
        return UIView()

    }
    
    func fillData(){
        
        activityIndicator.startAnimating()
        if let word = selectedWord{
            
            self.wordLabel.text = word.WORD
            
            for item in partOfSpeechCategory {
                
                self.PartOfSpeechArray.append((partOfSpeechText: item , words: []))
            }
            
            for word in matchedArabicWords{

                if let partOfSpeech = word.PART_OF_SPEECH {
                    
                    self.PartOfSpeechArray[partOfSpeech + 1].words.append(word)
                }
            }
            self.PartOfSpeechArray = self.PartOfSpeechArray.filter({ (part) -> Bool in
                return part.words.count > 0
            })
            
//            //order words descending
//            for part in PartOfSpeechArray{
//
//                part.words.sort({ (word1, word2) -> Bool in
//                    return word1.wORD < word2.wORD
//                })
//            }
        }
        activityIndicator.stopAnimating()
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

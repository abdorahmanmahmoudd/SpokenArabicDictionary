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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configuration(){
    
        tableView.tableFooterView = UIView(frame:CGRect.zero)
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return PartOfSpeechArray[section].words.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cellIdentifier = "DetailsCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
        cell.textLabel?.text = PartOfSpeechArray[indexPath.section].words[indexPath.row].wORD
        
        return cell
    }
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return PartOfSpeechArray.count
        
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) ->String?{
        return PartOfSpeechArray[section].partOfSpeechText
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 16, y: 0, width: tableView.frame.size.width, height: 40))
            
        headerView.backgroundColor = UIColor.white
        
        let headerLabel = UILabel(frame: CGRect(x: 16, y: 0, width: headerView.frame.size.width, height: headerView.frame.size.height))
        
        headerLabel.textColor = UIColor(red:182.0/255.0, green: 182.0/255.0, blue: 182.0/255.0, alpha: 1.0)
        
        headerLabel.textAlignment = NSTextAlignment.left
        
        headerLabel.font = UIFont.italicSystemFont(ofSize: 18)
        
        headerLabel.attributedText = NSAttributedString(string: PartOfSpeechArray[section].partOfSpeechText, attributes:
            [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
        
        headerView.addSubview(headerLabel)

        return headerView
    

    }
    
    func fillData(){
        
        activityIndicator.startAnimating()
        if let word = selectedWord{
            
            self.wordLabel.text = word.wORD
            
            for item in partOfSpeech {
                
                self.PartOfSpeechArray.append((partOfSpeechText: item , words: []))
            }
            
            for word in matchedArabicWords{
                
                if let tempPartOfSpeech = Int(word.pARTOFSPEECH) , partOfSpeech.count > Int(word.pARTOFSPEECH)!{
                    
                    self.PartOfSpeechArray[tempPartOfSpeech + 1].words.append(word)
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
    
    //MARK: translation func was used in the online version
//    func wordTranslation(){
//
//        if let id =  wordId {
//            //2CF6360E-B325-CB47-98D5-C61AFE408AB1
//            let url = URL(string: "http://spokenarabicdictionary.azurewebsites.net/api/English/translate?Id=" + id.uuidString )
//            activityIndicator.startAnimating()
//            activityIndicator.alpha = 1
//            let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
//
//                if error != nil {
//                    self.activityIndicator.stopAnimating()
//                    self.activityIndicator.alpha = 0
//                    print(error ?? "error at translation")
//
//                } else {
//
//                    if  let urlContent = data {
//
//                        do{
//
//                            let JSONResult = try JSONSerialization.jsonObject(with: urlContent, options: .mutableContainers) as! [[String : AnyObject]]
//
//                            for item in partOfSpeech {
//
//                                self.PartOfSpeechArray.append((partOfSpeechText: item , record: (Ids: [], Meanings: [])))
//                            }
//
//                            for item in JSONResult {
//
//                                if let partOfSpeechValue = item["PART_OF_SPEECH"]  {
//
//                                    var tempWord : String?
//                                    var tempId : NSUUID?
//
//                                    if let wordText = item["WORD"]{
//
//                                        tempWord = (wordText as! String)
//                                    }
//                                    if let idValue = item["ID"]{
//
//                                        tempId = (NSUUID(uuidString: (idValue as! String))!)
//                                    }
//
//                                    if tempId != nil && tempWord != nil && partOfSpeechValue as? Int != nil{
//
//                                        self.PartOfSpeechArray[(partOfSpeechValue as! Int) + 1].record.Ids.append(tempId!)
//                                        self.PartOfSpeechArray[(partOfSpeechValue as! Int) + 1].record.Meanings.append(tempWord!)
//                                    }
//
//                                }
//                            }
//                            self.PartOfSpeechArray[1].partOfSpeechText = ""
//                            var i = 0
//                            for speechPart in self.PartOfSpeechArray {
//
//                                if !(speechPart.record.Meanings.count > 0) {
//
//                                    self.PartOfSpeechArray.remove(at: i)
//                                }else{
//                                    i += 1
//                                }
//
//                            }
//                        }
//                        catch {
//
//                            print("json serialization fialed")
//
//                        }
//
//                        DispatchQueue.main.sync(execute: {
//
//                            self.activityIndicator.stopAnimating()
//                            self.activityIndicator.alpha = 0
//                            self.tableView.reloadData()
//
//                        })
//
//                    }
//                }
//            })
//
//            task.resume()
//        }
//
//    }
    
}

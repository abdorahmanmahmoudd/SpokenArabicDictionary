//
//  ViewController.swift
//  Dictionary
//
//  Created by abdelrahman.youssef on 6/23/17.
//  Copyright © 2017 abdelrahman.youssef. All rights reserved.
//

import UIKit

class SearchingViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var englishWords = [EnglishWord]()
    var arabicWords = [ArabicWord]()
    var conjugations = [Conjugation]()
    var searchResults = [EnglishWord]()
    var selectedWord : EnglishWord?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()
        fetchDataFromFiles()
    }
    
    func configuration(){
    
        self.searchBar.delegate = self
        tableView.tableFooterView = UIView()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain,
                                                                target: nil, action: nil)
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    
    }

    @objc func dismissKeyboard(){
        
        self.view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if  let _ = tableView.indexPathForSelectedRow{
            
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
        
    }
    
    func fetchDataFromFiles(){
        
        activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            do {
                if let englishFilePath = Bundle.main.url(forResource: EnglishWordsFile, withExtension: ".json"){
                    
                    if let fileData = try? Data.init(contentsOf: englishFilePath, options: .mappedIfSafe){
                        
                        let json = try JSONSerialization.jsonObject(with: fileData, options: .mutableContainers)
                        
                        for item in json as! [Any]{
                            
                            if let i = item as? [String: Any]{
                                self.englishWords.append(EnglishWord.init(fromDictionary: i))
                            }
                        }
                    }
                }
                if let arabicFilePath = Bundle.main.url(forResource: ArabicWordsFile, withExtension: ".json"){
                    
                    if let fileData = try? Data.init(contentsOf: arabicFilePath, options: .mappedIfSafe){
                        
                        let json = try JSONSerialization.jsonObject(with: fileData, options: .mutableContainers)
                        
                        for item in json as! [Any]{
                            
                            if let i = item as? [String: Any]{
                                self.arabicWords.append(ArabicWord.init(fromDictionary: i))
                            }
                        }
                    }
                }
                if let conjugationsFilePath = Bundle.main.url(forResource: ConjugationsFile, withExtension: ".json"){
                    
                    if let fileData = try? Data.init(contentsOf: conjugationsFilePath, options: .mappedIfSafe){
                        
                        let json = try JSONSerialization.jsonObject(with: fileData, options: .mutableContainers)
                        
                        for item in json as! [Any]{
                            
                            if let i = item as? [String: Any]{
                                self.conjugations.append(Conjugation.init(fromDictionary: i))
                            }
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
                
            }catch let err {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    showAlert(title: "", message: err.localizedDescription, vc: self, closure: nil)
                }
            }
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (self.searchResults.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
        cell.textLabel?.text = self.searchResults[indexPath.row].wORD
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedWord = searchResults[indexPath.row]
        self.performSegue(withIdentifier: "wordSegue", sender: self)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "wordSegue" {
            if let destinationController = segue.destination as? WordViewController{
                destinationController.selectedWord = self.selectedWord
                destinationController.matchedArabicWords = arabicWords.filter({ (word) -> Bool in
                    return word.eNGLISHWORDID == self.selectedWord?.iD
                })
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
        if searchBar.text != nil && searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines).count > 0{
            
            activityIndicator.startAnimating()
            self.searchResults.removeAll()
            
            self.searchResults = englishWords.filter({ (enWord) -> Bool in
                return enWord.wORD.lowercased().contains(searchBar.text!.lowercased())
            })
            //order results descending
            self.searchResults.sort(by: { (word1, word2) -> Bool in
                return word1.wORD.localizedCaseInsensitiveCompare(word2.wORD) == ComparisonResult.orderedAscending
            })
            
            tableView.reloadData()
            activityIndicator.stopAnimating()
            
            if searchResults.count == 0{
                
                let NoResultAlert = UIAlertController(title: nil, message: "No results",preferredStyle: .alert)
                NoResultAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            }
            
        }
    }
    
    
}


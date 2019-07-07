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
    
    var jsonFilesController: JsonFilesController?
    var filesIsUptoDate = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        configuration()
        jsonFilesController = JsonFilesController()
        jsonFilesController?.updateJsonFiles(withCompletion: { [weak self] in
            self?.fetchDataFromFiles()
            self?.activityIndicator.stopAnimating()
            self?.filesIsUptoDate = true
        })
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
        
        let jsonDecoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ" //2019-07-01T01:44:24.3381583+02:00
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                
        DispatchQueue.global(qos: .userInitiated).async {
            
            do {
                if let englishFilePath = Bundle.main.url(forResource: EnglishWordsFile, withExtension: ".json"){
                    
                    if let fileData = try? Data.init(contentsOf: englishFilePath, options: .mappedIfSafe){
                        
                        if let englishSheet = try? jsonDecoder.decode(EnglishSheet.self, from: fileData) {
                            self.englishWords = englishSheet.words
                        }
                    }
                }
                if let arabicFilePath = Bundle.main.url(forResource: ArabicWordsFile, withExtension: ".json"){
                    
                    if let fileData = try? Data.init(contentsOf: arabicFilePath, options: .mappedIfSafe){
                        
                        if let arabicSheet = try? jsonDecoder.decode(ArabicSheet.self, from: fileData) {
                            self.arabicWords = arabicSheet.words
                        }
                    }
                }
                if let conjugationsFilePath = Bundle.main.url(forResource: ConjugationsFile, withExtension: ".json"){
                    
                    if let fileData = try? Data.init(contentsOf: conjugationsFilePath, options: .mappedIfSafe){
                        
                        if let conjugationSheet = try? jsonDecoder.decode(ConjugationSheet.self, from: fileData) {
                            self.conjugations = conjugationSheet.words
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
        cell.textLabel?.text = self.searchResults[indexPath.row].WORD
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
                    return word.ENGLISHWORDID == self.selectedWord?.ID
                })
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
        if searchBar.text != nil && searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 && filesIsUptoDate{
            
            activityIndicator.startAnimating()
            self.searchResults.removeAll()
            
            self.searchResults = englishWords.filter({ (enWord) -> Bool in
                return (enWord.WORD?.lowercased() ?? "").contains(searchBar.text!.lowercased())
            })
            //order results descending
            self.searchResults.sort(by: { (word1, word2) -> Bool in
                return word1.WORD?.localizedCaseInsensitiveCompare(word2.WORD ?? "") == ComparisonResult.orderedAscending
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


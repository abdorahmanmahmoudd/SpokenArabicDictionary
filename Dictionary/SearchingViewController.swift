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
            self?.searchBar.isUserInteractionEnabled = true
            self?.searchBar.text = ""
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
                
                // to check the downloaded file first
                if let filePath = self.checkFileExists(withLink: EnglishWordsFile) {
                    let fileData = try Data.init(contentsOf: filePath, options: .mappedIfSafe)
                    let englishSheet = try jsonDecoder.decode(EnglishSheet.self, from: fileData)
                    self.englishWords = englishSheet.words
                    
                } else {
                    // to check the offline file
                    if let englishFilePath = Bundle.main.url(forResource: EnglishWordsFile, withExtension: ".json"){
                        let fileData = try Data.init(contentsOf: englishFilePath, options: .mappedIfSafe)
                        let englishSheet = try jsonDecoder.decode(EnglishSheet.self, from: fileData)
                        self.englishWords = englishSheet.words
                    }
                }
            }catch let error {
                print(error)
            }
            
            do {
                
                
                // to check the downloaded file first
                if let filePath = self.checkFileExists(withLink: ArabicWordsFile) {
                    let fileData = try Data.init(contentsOf: filePath, options: .mappedIfSafe)
                    let arabicSheet = try jsonDecoder.decode(ArabicSheet.self, from: fileData)
                    self.arabicWords = arabicSheet.words
                    
                } else {
                    // to check the offline file
                    if let arabicFilePath = Bundle.main.url(forResource: ArabicWordsFile, withExtension: ".json"){
                        let fileData = try Data.init(contentsOf: arabicFilePath, options: .mappedIfSafe)
                        let arabicSheet = try jsonDecoder.decode(ArabicSheet.self, from: fileData)
                        self.arabicWords = arabicSheet.words
                    }
                }
            }catch let error {
                print(error)
            }
            
            do {
                
                // to check the downloaded file first
                if let filePath = self.checkFileExists(withLink: ConjugationsFile) {
                    let fileData = try Data.init(contentsOf: filePath, options: .mappedIfSafe)
                    let conjugationSheet = try jsonDecoder.decode(ConjugationSheet.self, from: fileData)
                    self.conjugations = conjugationSheet.words
                    
                } else {
                    // to check the offline file
                    if let conjugationsFilePath = Bundle.main.url(forResource: ConjugationsFile, withExtension: ".json"){
                        let fileData = try Data.init(contentsOf: conjugationsFilePath, options: .mappedIfSafe)
                        let conjugationSheet = try jsonDecoder.decode(ConjugationSheet.self, from: fileData)
                        self.conjugations = conjugationSheet.words
                    }
                }
                
            }catch let error {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func checkFileExists(withLink link: String) -> URL? {
        let urlString = link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        if let url  = URL.init(string: urlString ?? ""){
            let fileManager = FileManager.default
            if let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create: false){
                let filePath = documentDirectory.appendingPathComponent(url.lastPathComponent, isDirectory: false)
                if let fileExists = try? filePath.checkResourceIsReachable(), fileExists {
                    print("file exist")
                    if let fileData = try? Data.init(contentsOf: filePath, options: .mappedIfSafe){
                        if fileData.count > 0 {
                            return filePath
                        }
                    }
                }
            }
        }
        print("file doesnt exist")
        return nil
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
                    return word.ENGLISH_WORD_ID == self.selectedWord?.ID
                })
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
        if searchBar.text != nil && searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 && filesIsUptoDate{
            
            activityIndicator.startAnimating()
            self.searchResults.removeAll()
            
            self.searchResults = englishWords.filter({ (enWord) -> Bool in
                //                print((enWord.WORD ?? "") + ", ")
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
        }else if searchBar.text != nil && searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 && !filesIsUptoDate {
            searchBar.text = "Updating data..."
            searchBar.isUserInteractionEnabled = false
        }
    }
    
    
}


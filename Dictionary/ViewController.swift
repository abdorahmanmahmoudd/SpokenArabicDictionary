//
//  ViewController.swift
//  Dictionary
//
//  Created by abdelrahman.youssef on 6/23/17.
//  Copyright © 2017 abdelrahman.youssef. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var EnglishWords = [EnglishWord]()
    var ArabicWords = [ArabicWord]()
    var Conjugations = [Conjugation]()
    var SearchResults = [EnglishWord]()
    var selectedWord : EnglishWord?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()
        fetchDataFromFiles()
    }
    
    func configuration(){
    
        self.searchBar.delegate = self
        tableView.tableFooterView = UIView(frame:CGRect.zero)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain,
                                                                target: nil, action: nil)
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    
    }

    func dismissKeyboard(){
        
        self.view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if  let _ = tableView.indexPathForSelectedRow{
            
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                                self.EnglishWords.append(EnglishWord.init(fromDictionary: i))
                            }
                        }
                    }
                }
                if let arabicFilePath = Bundle.main.url(forResource: ArabicWordsFile, withExtension: ".json"){
                    
                    if let fileData = try? Data.init(contentsOf: arabicFilePath, options: .mappedIfSafe){
                        
                        let json = try JSONSerialization.jsonObject(with: fileData, options: .mutableContainers)
                        
                        for item in json as! [Any]{
                            
                            if let i = item as? [String: Any]{
                                self.ArabicWords.append(ArabicWord.init(fromDictionary: i))
                            }
                        }
                    }
                }
                if let conjugationsFilePath = Bundle.main.url(forResource: ConjugationsFile, withExtension: ".json"){
                    
                    if let fileData = try? Data.init(contentsOf: conjugationsFilePath, options: .mappedIfSafe){
                        
                        let json = try JSONSerialization.jsonObject(with: fileData, options: .mutableContainers)
                        
                        for item in json as! [Any]{
                            
                            if let i = item as? [String: Any]{
                                self.Conjugations.append(Conjugation.init(fromDictionary: i))
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
        return (self.SearchResults.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
        cell.textLabel?.text = self.SearchResults[indexPath.row].wORD
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedWord = SearchResults[indexPath.row]
        self.performSegue(withIdentifier: "wordSegue", sender: self)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "wordSegue" {
            if let destinationController = segue.destination as? WordViewController{
                destinationController.selectedWord = self.selectedWord
                destinationController.matchedArabicWords = ArabicWords.filter({ (word) -> Bool in
                    return word.eNGLISHWORDID == self.selectedWord?.iD
                })
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
        if searchBar.text != nil && searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines).count > 0{
            
            activityIndicator.startAnimating()
            self.SearchResults.removeAll()
            
            self.SearchResults = EnglishWords.filter({ (enWord) -> Bool in
                return enWord.wORD.lowercased().contains(searchBar.text!.lowercased())
            })
            //order results descending
//            self.SearchResults.sort(by: { (word1, word2) -> Bool in
//                return word1.wORD.
//            })
            
            tableView.reloadData()
            activityIndicator.stopAnimating()
            
            if SearchResults.count == 0{
                
                let NoResultAlert = UIAlertController(title: nil, message: "No results",preferredStyle: .alert)
                NoResultAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            }
            
        }
    }
    
    //MARK: searching function was used in the online version
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//
//        if  searchBar.text != nil && ConnectionCheck.isConnectedToNetwork() {
//
//            var text = searchBar.text
//
//            if  searching == false {
//                activityIndicator.startAnimating()
//                searching = true
//                self.SearchResults.removeAll()
//                self.SearchResultsIds.removeAll()
//                self.tableView.reloadData()
//                text = text?.replacingOccurrences(of: " ", with: "%20")
//                let data = text?.data(using: String.Encoding.ascii, allowLossyConversion: true)
//                let nonemojiString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String
//                text = nonemojiString
//
//                if let url = URL(string: "http://spokenarabicdictionary.azurewebsites.net/api/english?word=" +  text! ){
//
//                    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
//
//                        if error != nil {
//                            print(error ?? "error")
//
//                        } else {
//                            if  let urlContent = data {
//                                do{
//                                    let matchedWordsJson = try JSONSerialization.jsonObject(with: urlContent, options: .mutableContainers) as! [[String : AnyObject]]
//
//                                    for item in matchedWordsJson {
//
//                                        if let word = item["WORD"]{
//
//                                            self.SearchResults.append(word as! String)
//
//                                        }
//                                        if let Id = item["ID"] {
//
//                                            self.SearchResultsIds.append(NSUUID(uuidString: (Id as! String))!)
//                                        }
//                                    }
//                                    DispatchQueue.main.sync(execute: {
//
//                                        self.activityIndicator.alpha = 0
//                                        self.activityIndicator.stopAnimating()
//                                        self.tableView.reloadData()
//                                        self.searching = false
//                                    })
//                                }
//                                catch {
//
//                                    //print("json serialization fialed")
//                                    let NoResultAlert = UIAlertController(title: nil, message: "No Results",preferredStyle: .alert)
//
//                                    NoResultAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//
//                                    DispatchQueue.main.sync(execute: {
//                                        self.activityIndicator.alpha = 0
//                                        self.activityIndicator.stopAnimating()
//                                        self.present(NoResultAlert, animated: true, completion: nil)
//                                        self.searching = false
//
//                                    })
//                                }
//                            }
//                        }
//                    })
//                    task.resume()
//                }
//            }
//        } else {
//
//            let internetConnectionAlert = UIAlertController(title: "Warning", message: "There is no Internet connection",preferredStyle: .alert)
//
//            internetConnectionAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
//
//            present(internetConnectionAlert, animated: true, completion: nil)
//
//        }
//    }
    
    
    
    
    
}


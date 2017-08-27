//
//  ViewController.swift
//  Dictionary
//
//  Created by abdelrahman.youssef on 6/23/17.
//  Copyright © 2017 abdelrahman.youssef. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    var SearchResults : [String] = []
    var SearchResultsIds : [NSUUID] = []
    var searching = false
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        tableView.tableFooterView = UIView(frame:CGRect.zero)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain,
                                                                target: nil, action: nil)
        
        //self.navigationController?.interactivePopGestureRecognizer?.delegate = self.navigationController as? UIGestureRecognizerDelegate
       // self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        
    }
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if  let _ = tableView.indexPathForSelectedRow{
            
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (self.SearchResults.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
        cell.textLabel?.text = self.SearchResults[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        let numOfSections: Int = 1
//        if self.SearchResults.count > 0 {
//            tableView.separatorStyle = .singleLine
//            numOfSections = 1
//            tableView.backgroundView = nil
//        } else {
//            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
//            noDataLabel.text = "No Results"
//            noDataLabel.textColor = UIColor.gray
//            noDataLabel.textAlignment = .center
//            tableView.backgroundView = noDataLabel
//            tableView.separatorStyle = .none
        
            
      //  }
        return numOfSections
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "wordSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! WordViewController
                destinationController.wordText = self.SearchResults[indexPath.row]
                destinationController.wordId = self.SearchResultsIds[indexPath.row]
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        if  searchBar.text != nil && ConnectionCheck.isConnectedToNetwork() {
            
            var text = searchBar.text
            
            if  searching == false {
                activityIndicator.alpha = 1
                activityIndicator.startAnimating()
                searching = true
                self.SearchResults.removeAll()
                self.SearchResultsIds.removeAll()
                self.tableView.reloadData()
                text = text?.replacingOccurrences(of: " ", with: "%20")
                let data = text?.data(using: String.Encoding.ascii, allowLossyConversion: true)
                let nonemojiString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String
                text = nonemojiString
                
                if let url = URL(string: "http://spokenarabicdictionary.azurewebsites.net/api/english?word=" +  text! ){
                    
                    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                        
                        if error != nil {
                            print(error ?? "error")
                            
                        } else {
                            if  let urlContent = data {
                                do{
                                    let matchedWordsJson = try JSONSerialization.jsonObject(with: urlContent, options: .mutableContainers) as! [[String : AnyObject]]
                                    
                                    for item in matchedWordsJson {
                                        
                                        if let word = item["WORD"]{
                                            
                                            self.SearchResults.append(word as! String)
                                            
                                        }
                                        if let Id = item["ID"] {
                                            
                                            self.SearchResultsIds.append(NSUUID(uuidString: (Id as! String))!)
                                        }
                                    }
                                    DispatchQueue.main.sync(execute: {
                                        
                                        self.activityIndicator.alpha = 0
                                        self.activityIndicator.stopAnimating()
                                        self.tableView.reloadData()
                                        self.searching = false
                                    })
                                }
                                catch {
                                    
                                    //print("json serialization fialed")
                                    let NoResultAlert = UIAlertController(title: nil, message: "No Results",preferredStyle: .alert)
                                    
                                    NoResultAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                                    
                                    DispatchQueue.main.sync(execute: {
                                        self.activityIndicator.alpha = 0
                                        self.activityIndicator.stopAnimating()
                                        self.present(NoResultAlert, animated: true, completion: nil)
                                        self.searching = false

                                    })
                                }
                            }
                        }
                    })
                    task.resume()
                }
            }
        } else {
            
            let internetConnectionAlert = UIAlertController(title: "Warning", message: "There is no Internet connection",preferredStyle: .alert)
            
            internetConnectionAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            
            present(internetConnectionAlert, animated: true, completion: nil)
            
        }
    }
    
    
    
    
    
}


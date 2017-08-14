//
//  ListViewController.swift
//  SwiftProteins
//
//  Created by Igor Chemencedji on 8/11/17.
//  Copyright © 2017 Igor Chemencedji. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    var proteinList: [String]  = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchProtein: UISearchBar!
    var filteredData: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Proteins"
        if let path = Bundle.main.path(forResource: "resurces", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                proteinList.append(contentsOf: data.components(separatedBy: .newlines))
            } catch {
                print(error)
            }
        }
        tableView.dataSource = self
        searchProtein.delegate = self
        filteredData = proteinList
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ProteinViewController.proteinName = filteredData[indexPath.row]
        if let loggedInVC = storyboard?.instantiateViewController(withIdentifier: "ProteinViewController") {
            DispatchQueue.main.async() { () -> Void in
                self.navigationController?.pushViewController(loggedInVC, animated: true)
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ProteinTableViewCell
        cell?.proteinName.text = filteredData[indexPath.row]
        return cell!
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? proteinList : proteinList.filter({(dataString: String) -> Bool in
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
        tableView.reloadData()
    }
}

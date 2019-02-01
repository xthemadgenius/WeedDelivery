//
//  DispensaryViewController.swift
//  WeedConnectMobile
//
//  Created by Javier J Calderon Jr on 1/16/19.
//  Copyright © 2019 Weed Connect. All rights reserved.
//

import UIKit

class DispensaryViewController: UIViewController {

    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    @IBOutlet weak var searchDispensary: UISearchBar!
    @IBOutlet weak var tbvDispensary: UITableView!
    
    var dispensarys = [Dispensary]()
    var filteredDispensarys = [Dispensary]()
    
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       if self.revealViewController() != nil {
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        loadDispensarys()
    }
    
    func loadDispensarys() {
        
        Helpers.showActivityIndicator(activityIndicator, view)
        
        APIManager.shared.getDispensarys { (json) in
            
            if json != nil {
                
                self.dispensarys = []
                
                if let listDis = json["dispensarys"].array {
                    for item in listDis {
                        let dispensary = Dispensary(json: item)
                        self.dispensarys.append(dispensary)
                    }
                    
                    self.tbvDispensary.reloadData()
                    Helpers.hideActivityIndicator(self.activityIndicator)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ProductList" {
            
            let controller = segue.destination as! ProductListTableViewController
            controller.dispensary = dispensarys[(tbvDispensary.indexPathForSelectedRow?.row)!]
        }
    }
}

extension DispensaryViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredDispensarys = self.dispensarys.filter({ (dis: Dispensary) -> Bool in
            
            return dis.name?.lowercased().range(of: searchText.lowercased()) != nil
        })
        
        self.tbvDispensary.reloadData()
    }
}

extension DispensaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchDispensary.text != "" {
            return self.filteredDispensarys.count
        }
        
        return self.dispensarys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DispensaryCell", for: indexPath) as! DispensaryViewCell
        
        let dispensary: Dispensary
        
        if searchDispensary.text != "" {
            dispensary = filteredDispensarys[indexPath.row]
        } else {
            dispensary = dispensarys[indexPath.row]
        }
        
        cell.lbDispensaryName.text = dispensary.name!
        cell.lbDispensaryAddress.text = dispensary.address!
        
        if let logoName = dispensary.logo {
            Helpers.loadImage(cell.imgDispensaryLogo, "\(logoName)")
        }
        
        return cell
        
    }
}

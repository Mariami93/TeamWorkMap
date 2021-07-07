//
//  ViewController.swift
//  MyTask2
//
//  Created by Luka Bukuri on 07.07.21.
//

import UIKit

struct SelectedCountry
{
    var name: String
    var lat: Double
    var long: Double
}

class SelectedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
   var countries = [
    SelectedCountry(name: "France", lat: 46.7111, long: 1.7191),
    SelectedCountry(name: "Italy", lat: 41.8719, long: 12.5674)
   
   ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Selected Countries"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(class: SelectedTableViewCell.self)
    }


}


extension SelectedViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.deque(SelectedTableViewCell.self, for: indexPath)
       
        cell.configure(with: countries[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "SelectedMapViewController", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SelectedMapViewController") as! SelectedMapViewController
        
        vc.selectedCountry = countries[indexPath.row].name
        vc.lat = countries[indexPath.row].lat
        vc.long = countries[indexPath.row].long
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}


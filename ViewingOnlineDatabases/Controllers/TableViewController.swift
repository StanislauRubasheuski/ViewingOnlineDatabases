//
//  TableViewController.swift
//  ViewingOnlineDatabases
//
//  Created by Stanislau on 29.05.2018.
//  Copyright © 2018 Stanislau. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let model = TableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.fetchData {
            self.tableView.reloadData()
        }
        model.downloadIMG {
            self.tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfRowsInSection()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.dataSource[indexPath.row].name
        cell.imageView?.image = model.image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = #colorLiteral(red: 0, green: 0.7176470588, blue: 0.8, alpha: 1)
        let label = UILabel()
        vw.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: vw.leadingAnchor, constant: 5).isActive = true
        label.trailingAnchor.constraint(equalTo: vw.trailingAnchor, constant: -5).isActive = true
        label.topAnchor.constraint(equalTo: vw.topAnchor, constant: 5).isActive = true
        label.bottomAnchor.constraint(equalTo: vw.bottomAnchor, constant: -5).isActive = true
        label.text = "Interesting Places"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return vw
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == model.dataSource.count - 5 {
            model.fetchData {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            let vc = segue.destination as! DescriptionViewController
            let cell = sender as! UITableViewCell
            guard let indexPath = self.tableView.indexPath(for: cell) else { return }
            vc.model.country = model.dataSource[indexPath.row].country
            vc.model.id = model.dataSource[indexPath.row].id
            vc.model.lat = model.dataSource[indexPath.row].lat
            vc.model.lon = model.dataSource[indexPath.row].lon
            vc.model.name = model.dataSource[indexPath.row].name
            
        }
    }
}

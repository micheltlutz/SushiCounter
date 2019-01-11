//
//  SushisTableViewController.swift
//  SushiCouter
//
//  Created by Michel Anderson Lutz Teixeira on 24/10/18.
//  Copyright © 2018 Michel Anderson Lutz Teixeira. All rights reserved.
//

import UIKit

class SushisTableViewController: UITableViewController {
    let sushiDayViewModel = SushiDayViewModel.shared
    var sushis: [SushiDay] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSushis()
        sushiDayViewModel.didUpdateSushis = {
            self.loadSushis()
        }
    }
    
    private func loadSushis() {
        if let allSushis = sushiDayViewModel.allSushis() {
            sushis = allSushis
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sushis.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSushi", for: indexPath)
        cell.textLabel?.text = String(sushis[indexPath.row].count)+" peças de sushis"
        cell.detailTextLabel?.text = "em \(sushis[indexPath.row].date)"
        return cell
    }
}

//
//  RaceListDataSource.swift
//  horse-racer
//

import UIKit


class RaceListDataSource: NSObject, UITableViewDataSource {
    
    // MARK: Properties
    
    var model = [Race]()
    
    
    // MARK: UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RaceCell.reuseIdentifier, for: indexPath) as? RaceCell else {
            fatalError("Unable to dequeue cell, something has went wrong 💥")
        }
        
        let race = getRace(at: indexPath.item)
        
        cell.nameLabel.text = "\(race.name) 🐎"
        cell.courseLabel.text = race.courseName
        
        return cell
        
    }
    
    
    // MARK: Helper
    
    func getRace(at index: Int) -> Race {
        return model[index]
    }
    
}

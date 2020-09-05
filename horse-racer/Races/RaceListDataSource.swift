//
//  RaceListDataSource.swift
//  horse-racer
//

import UIKit


class RaceListDataSource: NSObject, UITableViewDataSource {
    
    var model = [Race]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RaceCell", for: indexPath) as? RaceCell else {
            fatalError("Unable to dequeue cell, something has went seriously wrong 💥")
        }
        
        let race = model[indexPath.item]
        
        cell.nameLabel.text = "\(race.name) 🐎"
        cell.courseLabel.text = race.course_name
        
        return cell
        
    }
    
    
    // MARK: Helper
    
    func getRace(at index: Int) -> Race {
        return model[index]
    }
    
}

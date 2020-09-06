//
//  Race.swift
//  horse-racer
//

import Foundation

struct Race: Decodable, Equatable {
    let name: String
    let courseName: String
    let age: String
    let distance: String = ""
    let time: String // TODO: Change this
    let rideCount: Int = 0
    let raceStage: String = ""
    let going: String = ""
    let hasHandicap: Bool = false
    let hidden: Bool = false
    let rides: [Ride] = [
        
        Ride(clothNumber: 1, formSummary: "412-12", currentOdds: "5/2", horse: Horse(name: "Nobu", days_since_last_run: 300, foaled: "4Y", sex: "F")),
        Ride(clothNumber: 2, formSummary: "28-40", currentOdds: "33/1", horse: Horse(name: "Kage", days_since_last_run: 300, foaled: "2Y", sex: "F")),
        Ride(clothNumber: 3, formSummary: "412-12", currentOdds: "28/1", horse: Horse(name: "Sora", days_since_last_run: 300, foaled: "3Y", sex: "F")),
        Ride(clothNumber: 4, formSummary: "412-12", currentOdds: "14/2", horse: Horse(name: "Jin", days_since_last_run: 300, foaled: "1Y", sex: "F")),
    ]
}


struct Ride: Decodable, Equatable {
    let clothNumber: Int
    let formSummary: String
    let currentOdds: String
    let horse: Horse
}


struct Horse: Decodable, Hashable {
    let name: String
    let days_since_last_run: Int
    let foaled: String // could be date type
    let sex: String
}

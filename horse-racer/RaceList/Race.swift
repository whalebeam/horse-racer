//
//  Race.swift
//  horse-racer
//

import Foundation

struct Race: Decodable, Equatable {
    let name: String
    let courseName: String
    let age: String = ""
    let distance: String = ""
    let time: String = "" // TODO: Change this
    let rideCount: Int = 0
    let raceStage: String = ""
    let going: String = ""
    let hasHandicap: Bool = false
    let hidden: Bool = false
    let rides: [Ride]
}


struct Ride: Decodable, Hashable {
    let clothNumber: Int
    let formSummary: String
    let currentOdds: String
    let horse: Horse
    let url: String
}


struct Horse: Decodable, Hashable {
    let name: String
    let daysSinceLastRun: Int
    let foaled: String // could be date type
    let sex: String
}

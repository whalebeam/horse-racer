//
//  Race.swift
//  horse-racer
//

import Foundation

struct Race: Decodable, Equatable {
    let name: String
    let courseName: String
    let age: String?
    let distance: String?
    let time: String?
    let rideCount: Int?
    let raceStage: String?
    let going: String?
    let hasHandicap: Bool = false
    let hidden: Bool = false
    let rides: [Ride]
}


struct Ride: Decodable, Hashable {
    let clothNumber: Int
    let formSummary: String
    let currentOdds: Odds
    let horse: Horse
    let url: String
}


struct Horse: Decodable, Hashable {
    let name: String
    let daysSinceLastRun: Int
    let foaled: String
    let sex: String
}

struct Odds: Decodable, Hashable {
    let numerator: Int
    let denominator: Int
    var value: Double { return Double(numerator) / Double(denominator) }
    var text: String { return "\(numerator)/\(denominator)" }
}

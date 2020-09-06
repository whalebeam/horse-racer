//
//  Race.swift
//  horse-racer
//

import Foundation

struct Race: Decodable, Equatable {
    let name: String
    let course_name: String
    let age: String
    let distance: String = ""
    let time: String // TODO: Change this
    let ride_count: Int = 0
    let race_stage: String = ""
    let going: String = ""
    let has_handicap: Bool = false
    let hidden: Bool = false
    let rides: [Ride] = []
}


struct Ride: Decodable, Equatable {
    let cloth_number: Int
    let horse: Horse
}


struct Horse: Decodable, Equatable {
    let name: String
    let days_since_last_run: Int
    let foaled: String // could be date type
    let sex: String
}

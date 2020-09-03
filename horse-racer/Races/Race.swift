//
//  Race.swift
//  horse-racer
//

import Foundation

//struct Race: Decodable {
//    let name: String
//    let course_name: String
//    let age: String
//    let distance: String
//    let time: String // TODO: Change this
//    let ride_count: Int
//    let race_stage: String
//    let going: String
//    let has_handicap: Bool
//    let hidden: Bool
//}


// TODO: undo temp structure
struct Race: Decodable {
    let name: String?
    let page: Int
}

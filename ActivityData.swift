//
//  ActivityData.swift
//  TweekLabs
//
//  Created by Hitesh Suthar on 15/08/22.
//

import Foundation

struct Athlete: Codable, Hashable {
    let id: String
    let name: String
    let score: Int
    let runup: Int
    let jump: Int
    let bfc: Int
    let ffc: Int
    let release: Int
}

struct ActivityData: Codable {
    
    let organisation: String
    var athletes: [Athlete]
}

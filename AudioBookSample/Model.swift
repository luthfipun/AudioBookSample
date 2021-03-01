//
//  Model.swift
//  AudioBookSample
//
//  Created by Luthfi Abdul Azis on 27/02/21.
//

import Foundation

struct Item: Codable {
    let id: Int
    let title: String
    let cover: String
    let price: Double
    let author: String
    let rate: Double
}

struct Datas: Codable {
    let history: [Item]
    let top: [Item]
}

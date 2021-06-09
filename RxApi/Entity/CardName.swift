//
//  CardName.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/06/07.
//

import Foundation
import Moya

struct CardNameResponse: Codable {
//    let name: String?
    let cards: [Cards]
}

struct Cards: Codable {
    let name: String
    let manaCost: String
    let imageUrl: String?
    let text: String?
    let power: String?
    let toughness: String?
}

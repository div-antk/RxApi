//
//  Problem.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/05/26.
//

import Foundation

struct Problem: Codable {
    let id: String
    let contestId: String
    let title: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case contestId = "contest_id"
        case title
    }
}

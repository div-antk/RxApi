//
//  MtgAPI.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/05/19.
//

import Foundation
import Moya

enum MtgAPI {
    case cards
}

extension MtgAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.magicthegathering.io")!
    }
    
    var path: String {
        switch self {
        case .cards:
            return "/v1/cards"
        }
    }
    
    var method: Moya.Method {
        return Moya.Method.get
    }
    
    var sampleData: Data {
        return Data()
    }
    
//    public var task: Task {
//
//        switch self {
//        case .cards:
//            return .requestParameters(
//                parameters: [
//                    "name" : "dark",
////                    "text" : "whenever"
//                ], encoding: URLEncoding.default)
//        }
//    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}

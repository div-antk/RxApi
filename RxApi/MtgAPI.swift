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
        return URL(string: "https://api.magicthegathering.io/v1/cards/386616")!
    }
    
    var path: String {
        switch self {
        case .cards:
            return ""
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
        ["Total-Count": "10"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}

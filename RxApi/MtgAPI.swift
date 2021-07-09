//
//  MtgAPI.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/05/19.
//

import Foundation
import Moya

enum MtgAPI {
    case card(String)
}

extension MtgAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.magicthegathering.io/v1")!
    }
    
    var path: String {
        switch self {
        case .card:
            return "/cards"
        }
    }
    
    var method: Moya.Method {
        return Moya.Method.get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .card(let cardName):
            return .requestParameters(parameters: [
                "name" : cardName,
                "type" : "land"
            ], encoding: URLEncoding.queryString)
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}

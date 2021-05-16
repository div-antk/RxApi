//
//  ApiRepository.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/05/16.
//

import Foundation
import RxSwift

protocol ApiRepository {
    // 検索用のプロトコルを定義（Mockにも準拠させることによって実際の通信をしないテストを行う）
    func search(from word: String) -> Observable<[ApiModel]>
}

class DefaultAPI: ApiRepository {
    
    private let base = URL(string: "https://ja.wikipedia.org")!
    private let path = "w/api.php"
    
    // URLSessionを外部から与えるようにする
    private let URLSession: Foundation.URLSession
    
    init(URLSession: Foundation.URLSession) {
        self.URLSession = URLSession
    }
    
    func search(from word: String) -> Observable<[ApiModel]> {
        
        var components = URLComponents(url: base, resolvingAgainstBaseURL: false)!
        components.path = path
        
        let items = [
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "action", value: "query"),
            URLQueryItem(name: "list", value: "search"),
            URLQueryItem(name: "srsearch", value: "word")
        ]
        
        components.queryItems = items
        
        let request = URLRequest(url: components.url!)
        
        return URLSession.rx.response(request: request)
            .map { pair in
                do {
                    let response = try JSONDecoder().decode(
                        SearchResponce.self,
                        from: pair.data
                    )
                    return response.query.search
                } catch {
                    // mapオペレータのクロージャ内でthrowすることで、それがエラーとして伝達される
                    // JSONデコードの失敗時にエラーを投げるようにする
                    throw error
                }
            }
    }
}

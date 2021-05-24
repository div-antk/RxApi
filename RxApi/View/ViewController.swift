//
//  ViewController.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/04/30.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import Instantiate
import InstantiateStandard

class ViewController: UIViewController, StoryboardInstantiatable {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
        
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let provider = MoyaProvider<MtgAPI>()
        
        provider.request(.cards) { result in
            
            switch result {
            case .success(let response):
                do {
                    let data = response.data
                    let cards = try? JSONDecoder().decode(Cards.self, from: data)

                    print(cards?.name)
                } catch {
                    print("失敗")
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
}



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

//        state = .error
//        state = .loading
        
        provider.request(.cards) { (result) in
//            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                let data = response.data
//                let cards = try? JSONDecoder()
//
//                for card in cards! {
//                    print(card.name, card.text)
//                }
                print(data)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}



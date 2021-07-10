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
import Kingfisher

class ViewController: UIViewController, StoryboardInstantiatable {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var reloadButton: UIButton!
    
    var cards: [Card?]?
    var cardImg: String?
    var cardName: String?
    
    private var searchViewModel: SearchViewModel!
    private let disposeBag = DisposeBag()

    let provider = MoyaProvider<MtgAPI>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        searchViewModel = SearchViewModel()
        
        // VMに送る
        searchTextField.rx.text.orEmpty
            .filter{$0.count >= 1}
            // bindはsubscribeとほぼ同じではあるが、簡潔に書けてデータバインディングしている
            .bind(to: searchViewModel.inputs.searchText)
            .disposed(by: disposeBag)
        
        // VMから受け取る
        searchViewModel.outputs.cardList
            .asObservable().subscribe { [weak self] in
                self?.cards = $0.element
                self?.cardImage()
            }.disposed(by: disposeBag)
            
        // VMから受け取ってカード名に代入
//        viewModel.searchText.asObservable().subscribe { [weak self] in
//            self?.cardName = $0.element
//            self?.getCards(cardName: self?.cardName ?? "")
//        }.disposed(by: disposeBag)
    }
    
    func cardImage() {
        if let cardImage = cards?.randomElement()??.imageUrl {
            cardImageView.kf.setImage(with: URL(string: cardImage))
        }
    }
}

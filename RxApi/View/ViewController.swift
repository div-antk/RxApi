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
    
    var cards: CardListResponse?
    var cardName: String?
    
    private let disposeBag = DisposeBag()


    let viewModel: SearchViewModelType = SearchViewModel(
        cardRepository: CardRepository()
    )
    //    private let cardRepository = CardRepository()
    
//    let viewModel: SerchViewModelType = SearchViewModel(
    
//    )
    
    let provider = MoyaProvider<MtgAPI>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        searchTextField.rx.text.orEmpty
            .filter{$0.count >= 1}
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .asObservable().subscribe { [weak self] in
                guard let text = $0.element else { return }
                self?.viewModel.set(text: text)
            }
            .disposed(by: disposeBag)
        
        // VMから受け取ってカード名に代入
        viewModel.searchText.asObservable().subscribe { [weak self] in
            self?.cardName = $0.element
            self?.getCards(cardName: self?.cardName ?? "")
        }.disposed(by: disposeBag)
    }
    
    func cardImage() {
        if let cardImage = cards?.cards.randomElement()?.imageUrl {
            cardImageView.kf.setImage(with: URL(string: cardImage))
        }
    }
    
    func getCards(cardName: String) {
        provider.request(.card(cardName)) { (result) in
            switch result {
            
            case .success(let response):
                let data = response.data
                
                do {
                    let cards = try JSONDecoder().decode(CardListResponse.self, from: data)
                    self.cards = cards
                    self.cardImage()
                } catch(let error) {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

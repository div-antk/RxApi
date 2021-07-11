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
    @IBOutlet weak var collectionView: UICollectionView!
    
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
                self?.collectionView.reloadData()
            }.disposed(by: disposeBag)
            
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: CardCollectionViewCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: CardCollectionViewCell.reusableIdentifier)
    }
    
//    func cardImage() {
//        if let cardImage = cards?.randomElement()??.imageUrl {
//            cardImageView.kf.setImage(with: URL(string: cardImage))
//        }
//    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let cards = cards {
            return cards.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reusableIdentifier, for: indexPath) as! CardCollectionViewCell
        
        if let cardImage = cards?[indexPath.item]?.imageUrl {
            cell.cardImageView.kf.setImage(with: URL(string: cardImage))
        }
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.bounds.width / 3, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 12
    }
}

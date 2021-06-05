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
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var cards: CardListResponse?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let provider = MoyaProvider<MtgAPI>()
        
        provider.request(.cards) { (result) in
            
            switch result {
            case .success(let response):
                let data = response.data
                do {
                    let cards = try JSONDecoder().decode(CardListResponse.self, from: data)
                    self.cards = cards
                    self.collectionView.reloadData()
                } catch(let error) {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: CardCollectionViewCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: CardCollectionViewCell.reusableIdentifier)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return (cards?.cards.count)!
//        print(cards?.cards)
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let count = cards?.cards.count {
//            return count
//        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reusableIdentifier, for: indexPath) as! CardCollectionViewCell
        
        if let cardImage = cards?.cards.randomElement()?.imageUrl {
            cell.cardImageView.kf.setImage(with: URL(string: cardImage))
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    // カスタムセルのサイズ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: view.frame.width - 40, height: view.frame.height - 60)
    }

//    // 各カスタムセル外枠の余白
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        return UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
//    }
}

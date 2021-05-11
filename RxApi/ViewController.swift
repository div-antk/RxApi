//
//  ViewController.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/04/30.
//

import UIKit
import RxSwift
import RxCocoa
import Instantiate
import InstantiateStandard

class ViewController: UIViewController, StoryboardInstantiatable {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    private let viewModel: ViewModel = ViewModel()
    private var articlesDataSource: [Article]?
    private let disposeBag = DisposeBag()
    
    private let cellReuseId = "sampleCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let cell = UINib(nibName: TableViewCell.reusableIdentifier, bundle: nil)
//        tableView.register(UINib(nibName: TableViewCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier.)
        
        self.tableView.register(UINib(nibName: TableViewCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: TableViewCell.reusableIdentifier)

        // テキストフィールドに入力された文字をvmにbind
        textField.rx.text.orEmpty
            .filter{$0.count >= 1}
            .debounce(.microseconds(5), scheduler: MainScheduler.instance)
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(viewModel.searchWord)
            .disposed(by: disposeBag)
        
        // イベントの検索結果のストリームを購読する
        
        
    }


}



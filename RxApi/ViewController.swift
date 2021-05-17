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
    
    // VM初期化時、動作に依存するAPI実行のオブジェクトを注入
    // テスト実行時にモック用のオブジェクトと置き換えて、ニセの通信によってテスト時間を短縮するため
    private let viewModel = SearchViewModel(
        wikipediaAPI: DefaultAPI(URLSession: .shared)
    )
        
    private let disposeBag = DisposeBag()
    
    private let cellReuseId = "sampleCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let input = SearchViewModel.Input(
            searchWord: textField.rx.text.orEmpty.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.searchDescription.bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.wikipage.bind(to: tableView.rx.items(cellIdentifier: TableViewCell.reusableIdentifier)) {
            index, result, cell in
            cell.textLabel?.text = result.title
        }.disposed(by: disposeBag)
        
//        let cell = UINib(nibName: TableViewCell.reusableIdentifier, bundle: nil)
//        tableView.register(UINib(nibName: TableViewCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier.)
        
        self.tableView.register(UINib(nibName: TableViewCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: TableViewCell.reusableIdentifier)

        // テキストフィールドに入力された文字をvmにbind
//        textField.rx.text.orEmpty
//            .filter{$0.count >= 1}
//            .debounce(.microseconds(5), scheduler: MainScheduler.instance)
//            .asDriver(onErrorDriveWith: Driver.empty())
//            .drive(viewModel.self)
//            .disposed(by: disposeBag)
        
        // イベントの検索結果のストリームを購読する
        
        
    }


}



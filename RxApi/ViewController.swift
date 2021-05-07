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
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let cell = UINib(nibName: TableViewCell.reusableIdentifier, bundle: nil)
//        tableView.register(UINib(nibName: TableViewCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier.)
        
        self.tableView.register(UINib(nibName: TableViewCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: TableViewCell.reusableIdentifier)

        textField.rx.text.orEmpty
            .filter{$0.count >= 1}
            .debounce(0.5, scheduler: MainScheduler.instance)
            
    }


}



//
//  ViewModel.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/05/08.
//

import Foundation
import RxSwift
import RxCocoa

final class ViewModel {
    
    private let disposeBag = DisposeBag()
    
    private let searchWordStream = PublishSubject<String>()
    private let eventStream = PublishSubject<Events?>()
    
    private let startedAtStream = PublishSubject<String>()
}

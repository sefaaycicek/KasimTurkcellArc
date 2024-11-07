//
//  MovieViewModel.swift
//  KasimTurkcellArc
//
//  Created by Sefa Aycicek on 7.11.2024.
//

import UIKit
import RxSwift
import RxRelay

class MovieViewModel {
    let disposeBag = DisposeBag()

    var originalData : [MovieUIModel] = []
    var data = BehaviorRelay<[MovieUIModel]>(value : [])
    var isLoading = BehaviorSubject<Bool>(value: false)
    
    private let apiService : AlamofireApiServiceProtocol
    init(apiService : AlamofireApiServiceProtocol = AlamofireApiService()) {
        self.apiService = apiService
    }
    
    func getData(searchText : String) {
        self.apiService.searchMovies(searchText: searchText)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onSuccess: { [weak self] response in
                
                if response?.success == true {
                    let models = response?.result.map({ MovieUIModel(from: $0) })
                    self?.originalData = models ?? []
                    self?.data.accept(models ?? [])
                } else {
                    self?.originalData =  []
                    self?.data.accept([])
                }
               
            }, onFailure: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
                       
    }
}

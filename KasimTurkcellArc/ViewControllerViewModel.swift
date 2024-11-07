//
//  ViewControllerViewModel.swift
//  KasimTurkcellArc
//
//  Created by Sefa Aycicek on 6.11.2024.
//

import UIKit
import RxSwift
import RxRelay

class ViewControllerViewModel {
    let disposeBag = DisposeBag()

    var userEmail = BehaviorRelay<String>(value : "")

    var originalData : [PostEntity] = []
    var data = BehaviorRelay<[PostEntity]>(value : [])
    var isLoading = BehaviorSubject<Bool>(value: false)
    
    let apiService : AlamofireApiServiceProtocol
    init(apiService : AlamofireApiServiceProtocol = AlamofireApiService()) {
        self.apiService = apiService
    }
    
    func getData() {
        self.apiService.fetchPosts()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onSuccess: { [weak self] posts in
                self?.originalData = posts ?? []
                self?.data.accept(posts ?? [])
            }, onFailure: { error in
                
            }).disposed(by: disposeBag)
                       
    }
    
    func filter(prm : String) {
        let filteredData = self.originalData.filter { prm.isEmpty || $0.title.lowercased().contains(prm.lowercased()) }
        self.data.accept(filteredData)
    }
    
    func validate()->Bool {
        return !userEmail.value.isEmpty
    }
    
    func save() {
        
    }
}

//
//  ProfilsListViewModel.swift
//  DemoApp
//
//  Created by Marcin Srech on 12.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import Foundation
import RxSwift

class ProfilesListViewModel {
    
    //MARK: - Properties
    let title = String.localized("ProfilesVC_title")
    private var profiles = Variable<[CDProfile]>([])
    private var errorAppears = Variable<Bool>(false)
    private var pofilesDataProvider: CDProfileDataProvider
    private var disposeBag = DisposeBag()
    
    //MARK: - Methods
    init(dataProvider: DataProvider) {
        self.pofilesDataProvider = dataProvider as! CDProfileDataProvider
        fetchProductsAndUpdateObservableProducts()
    }
    
    private func fetchProductsAndUpdateObservableProducts() {
        pofilesDataProvider.fetchObservableData()
            .map({ $0})
            .subscribe({ (profiles) in
                self.profiles.value = profiles.element as? [CDProfile] ?? []
            })
            .addDisposableTo(disposeBag)
    }
    
    public func getProfiles() -> Variable<[CDProfile]> {
        return profiles
    }
    
    public func getErrorAppears() -> Variable<Bool> {
        return errorAppears
    }

    public func findProfiles(by keywords: String?) {
        if keywords == nil || keywords?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
           pofilesDataProvider.findObjects(by: "keyword", value: keywords ?? "")
        } else {
            APIClient.shared.findProducts(by: keywords!).then { [weak self] in
                self?.pofilesDataProvider.findObjects(by: "keyword", value: keywords!)
                }.catch({ [weak self] (error) in
                    self?.pofilesDataProvider.findObjects(by: "keyword", value: "")
                    self?.errorAppears.value = true
                })
        }
    }
}

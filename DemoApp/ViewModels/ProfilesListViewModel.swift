//
//  ProfilsListViewModel.swift
//  DemoApp
//
//  Created by Marcin Srech on 12.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

class ProfilesListViewModel {
    
    //MARK: - Properties
    let title = String.localized("ProfilesVC_title")
    private var profiles = Variable<[ProfileCellViewModel]>([])
    private var errorAppears = Variable<Bool>(false)
    private var pofilesDataProvider: DataProvider
    private var disposeBag = DisposeBag()
    
    //MARK: - Methods
    init(dataProvider: DataProvider) {
        self.pofilesDataProvider = dataProvider
        fetchProductsAndUpdateObservableProducts()
    }
    
    private func fetchProductsAndUpdateObservableProducts() {
        pofilesDataProvider.fetchObservableData()
            .map({ [weak self] profiles in
                return self?.viewModels(for: profiles)
            })
            .subscribe({ [weak self] (profiles) in
                self?.profiles.value = profiles.element as? [ProfileCellViewModel] ?? []
            })
            .addDisposableTo(disposeBag)
    }
    
    public func getProfiles() -> Variable<[ProfileCellViewModel]> {
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
    
    public func selectProfile(at index: Int) {
        let profileCellViewModel = profiles.value[index]

        if let url = getURL(for: profileCellViewModel) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    //MARK: - Helpers
    private func viewModels(for profiles: [NSManagedObject]) -> [ProfileCellViewModel] {
        var viewModels = [ProfileCellViewModel]()
        profiles.forEach({ viewModels.append(ProfileCellViewModel(profile: $0 as! CDProfile )) })
        
        return viewModels
    }
    
    private func getURL(for viewModel: ProfileCellViewModel) -> URL? {
        let appSettings = AppSettings.init()
        var link = viewModel.getLink()
        link.remove(at: link.startIndex)
        let urlString = appSettings.baseUrl + link
        
        return URL(string: urlString)
    }
}

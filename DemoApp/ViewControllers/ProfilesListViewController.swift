//
//  ProfilsListViewController.swift
//  DemoApp
//
//  Created by Marcin Srech on 12.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProfilesListViewController: UIViewController {
    
    //MARK: - Properties
    let cellIdentifier = "productCellIdentifier"
    
    var searchController: UISearchController!
    
    var profilesListViewModel: ProfilesListViewModel?
    let disposeBag = DisposeBag()
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilesListViewModel = ProfilesListViewModel(dataProvider: CDProfileDataProvider())

        prepareNavigation()
        prepareTableView()
        prepareSearchController()
        
        configureTableDataSource()
        configureTableViewCellWhenTapped()
        configureSearchResults()
        configureAlertViewWhenErrorAppears()
    }
    
    //MARK: - Prepare UI
    private func prepareNavigation() {
        title = profilesListViewModel?.title
    }
    
    private func prepareTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func prepareSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
        
        searchController.dimsBackgroundDuringPresentation = false
        
        definesPresentationContext = true
    }

    //MARK: - Configure Rx
    private func configureTableDataSource() {
        let observableProfiles = profilesListViewModel!.getProfiles().asObservable()
        observableProfiles.bind(to: tableView.rx.items) { (tableView, row, profileViewModel) in
                let cell = ProfileTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: self.cellIdentifier)
                cell.setup(viewModel: profileViewModel)
                return cell
            }
            .addDisposableTo(disposeBag)
    }
    
    private func configureTableViewCellWhenTapped() {
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
                self?.profilesListViewModel?.selectProfile(at: indexPath.row)
            })
            .addDisposableTo(disposeBag)
    }
    
    private func configureSearchResults() {
        _ = searchController.searchBar.rx.text.orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .subscribe({ [weak self] (event) in
                self?.profilesListViewModel?.findProfiles(by: event.element)
            })
        
        _ = searchController.searchBar.rx.cancelButtonClicked
            .observeOn(MainScheduler.instance)
            .subscribe({ [weak self] (event) in
                self?.profilesListViewModel?.findProfiles(by: nil)
            })
        
    }
    
    private func configureAlertViewWhenErrorAppears() {
        let observableErrorApears = profilesListViewModel!.getErrorAppears().asObservable()
        observableErrorApears
            .subscribe { [weak self] (event) in
                if event.element ?? false {
                    self?.showAlertController()
                }
            }
            .addDisposableTo(disposeBag)
    }
    
    private func showAlertController() {
        let alertController = UIAlertController(title: String.localized("Global_DefaultAlertTitle"), message: String.localized("Global_DefaultAlertBody"), preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: String.localized("Global_AlertOk"), style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    
}

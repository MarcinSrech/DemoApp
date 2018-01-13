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
        configureSearchResults()
    }
    
    //MARK: - Prepare UI
    private func prepareNavigation() {
        title = profilesListViewModel?.getTitle()
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
        observableProfiles.bind(to: tableView.rx.items) { (tableView, row, profile) in
                let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: self.cellIdentifier)
                cell.textLabel?.text = profile.teacherNick!
                cell.detailTextLabel?.text = profile.title!
                cell.detailTextLabel?.numberOfLines = 0
                cell.accessoryType = .disclosureIndicator
                return cell
            }
            .addDisposableTo(disposeBag)
    }
    
    private func configureSearchResults() {
        _ = searchController.searchBar.rx.text.orEmpty
            .debounce(1, scheduler: MainScheduler.instance)
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
}

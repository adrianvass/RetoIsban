//
//  FeedTableViewController.swift
//  RetoIsban
//
//  Created by VASS on 29/06/2017.
//  Copyright © 2017 Adrián Rubio. All rights reserved.
//

import Foundation
import UIKit

protocol FeedTableViewDelegate: class {
    func setFeedItems(_ feedItems: [FeedItemViewModel])
}

class FeedTableViewController: UIViewController, FeedTableViewDelegate, UITableViewDelegate, UITableViewDataSource {
    fileprivate let presenter: FeedTableViewPresenter
    fileprivate let cellIdentifier = "FeedItemCellViewIdentifier"
    private var feedItems: [FeedItemViewModel] = [FeedItemViewModel]()
    
    @IBOutlet weak var tableView: UITableView!
    
    init(presenter: FeedTableViewPresenter) {
        self.presenter = presenter
        
        super.init(nibName: "FeedTableView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "El Pais Ciencia"
        configTableView()
        presenter.attachView(self)
    }
    
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FeedItemCellView", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    // MARK: FeedTableViewDelegate 
    
    func setFeedItems(_ feedItems: [FeedItemViewModel]) {
        self.feedItems = feedItems
        self.tableView.reloadData()
    }
    
    // MARK: UITableView Delegate and Datasource
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = FeedDetailViewController(feedItems[indexPath.row])
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? FeedItemCellView else { return FeedItemCellView() }
        
        let viewModel = feedItems[indexPath.row]
        cell.configCell(viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }
}

//
//  PasswordListView.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/13.
//

import MJRefresh
import UIKit

protocol PasswordListViewDelegate: UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    func refreshData(_ senderView: PasswordListView)
}

class PasswordListView: UIView {
    weak var delegate: PasswordListViewDelegate? {
        didSet {
            searchBar.delegate = delegate
            tableView.dataSource = delegate
            tableView.delegate = delegate
            tableView.mj_header?.beginRefreshing()
        }
    }

    var tableView: UITableView!
    var searchBar: UISearchBar!

    override init(frame: CGRect) {
        super.init(frame: frame)

        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 0, height: 60))
        searchBar.searchBarStyle = .minimal
        tableView = UITableView(frame: frame, style: .insetGrouped)
        tableView.tableHeaderView = searchBar
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        let header = MJRefreshNormalHeader { [weak self] in
            guard let self = self else { return }
            self.delegate?.refreshData(self)
        }
        header.lastUpdatedTimeLabel?.isHidden = true
        header.stateLabel?.isHidden = true
        tableView.mj_header = header
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

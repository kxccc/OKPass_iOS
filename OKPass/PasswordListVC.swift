//
//  PasswordListVC.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/7.
//

import MJRefresh
import PKHUD
import UIKit

class PasswordListVC: UIViewController {
    private var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        let header = MJRefreshNormalHeader {
            self.refreshData()
        }
        header.lastUpdatedTimeLabel?.isHidden = true
        header.stateLabel?.isHidden = true
        tableView.mj_header = header
        tableView.mj_header?.beginRefreshing()
    }

    func refreshData() {
        let token = UserInfoManager.shared.userInfo.token
        NetworkAPI.getPassword(token: token, completion: { [weak self] Result in
            guard let self = self else { return }
            self.tableView.mj_header?.endRefreshing()
            switch Result {
            case let .success(res):
                if res.status {
                    PasswordManager.shared.decrypt(data: res.data!)
                    self.tableView.reloadData()
                } else {
                    HUD.flash(.label(res.msg), delay: 0.5)
                }
            case let .failure(error):
                HUD.flash(.label(error.localizedDescription), delay: 0.5)
            }

        })
    }
}

extension PasswordListVC: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        PasswordManager.shared.password.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = PasswordManager.shared.categoryList[section]
        return PasswordManager.shared.password[category]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
        let category = PasswordManager.shared.categoryList[indexPath.section]
        let title = PasswordManager.shared.password[category]?[indexPath.row].title ?? ""
        cell.textLabel?.text = title
        return cell
    }
}

extension PasswordListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

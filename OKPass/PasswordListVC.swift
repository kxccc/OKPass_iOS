//
//  PasswordListVC.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/7.
//

import PKHUD
import UIKit

class PasswordListVC: UIViewController {
    private var isSearching: Bool = false
    private var v: PasswordListView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(clickAddButton))
        v = PasswordListView()
        v.delegate = self
        view.addSubview(v)
    }

    override func viewWillAppear(_: Bool) {
        tabBarController?.tabBar.isHidden = false
    }

    override func viewWillLayoutSubviews() {
        v.frame = CGRect(x: view.safeAreaInsets.left,
                         y: view.safeAreaInsets.top,
                         width: view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right,
                         height: view.bounds.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top)
    }

    @objc func clickAddButton() {
        gotoEditVC(password: nil, indexPath: nil)
    }

    func gotoEditVC(password: Password?, indexPath: IndexPath?) {
        let vc = EditVC()
        vc.delegate = self
        if let password = password, let indexPath = indexPath {
            vc.setText(title: password.title, url: password.url, username: password.username, password: password.password, remark: password.remark, category: password.category, indexPath: indexPath)
        }
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }

    func delPassword(indexPath: IndexPath) {
        let category = PasswordManager.shared.categoryList[indexPath.section]
        let index = indexPath.row
        PasswordManager.shared.delPassword(category: category, index: index, completion: { [weak self] in
            guard let self = self else { return }
            self.v.tableView.deleteRows(at: [indexPath], with: .automatic)
        })
    }
}

extension PasswordListVC: EditVCDelegate {
    func savePassword(title: String, url: String, username: String, password: String, remark: String, category: String, indexPath: IndexPath?) {
        if let indexPath = indexPath {
            delPassword(indexPath: indexPath)
        }
        PasswordManager.shared.addPassword(title: title, url: url, username: username, password: password, remark: remark, category: category, completion: { [weak self] in
            guard let self = self else { return }
            self.v.tableView.reloadData()
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
        if isSearching, let searchContent = v.searchBar.text, !title.contains(searchContent) {
            cell.isHidden = true
        }
        return cell
    }
}

extension PasswordListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let category = PasswordManager.shared.categoryList[indexPath.section]
        let index = indexPath.row
        let password = PasswordManager.shared.password[category]?[index]
        gotoEditVC(password: password, indexPath: indexPath)
    }

    func tableView(_: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        UISwipeActionsConfiguration(actions: [
            UIContextualAction(style: .destructive, title: "删除", handler: { [weak self] _, _, _ in
                guard let self = self else { return }
                self.delPassword(indexPath: indexPath)
            }),
        ])
    }

    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UILabel()
        v.text = "    " + PasswordManager.shared.categoryList[section]
        v.font = .boldSystemFont(ofSize: 19)
        if isSearching {
            v.isHidden = true
        }
        return v
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        if isSearching {
            return 0
        }
        return 40
    }

    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let category = PasswordManager.shared.categoryList[indexPath.section]
        let title = PasswordManager.shared.password[category]?[indexPath.row].title ?? ""
        if isSearching, let searchContent = v.searchBar.text, !title.contains(searchContent) {
            return 0
        }
        return 45
    }

    func tableView(_: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point _: CGPoint) -> UIContextMenuConfiguration? {
        UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { _ in
            UIMenu(children: [
                UIAction(title: "复制网址") { _ in
                    let category = PasswordManager.shared.categoryList[indexPath.section]
                    let index = indexPath.row
                    let data = PasswordManager.shared.password[category]?[index].url
                    UIPasteboard.general.string = data
                },
                UIAction(title: "复制用户名") { _ in
                    let category = PasswordManager.shared.categoryList[indexPath.section]
                    let index = indexPath.row
                    let data = PasswordManager.shared.password[category]?[index].username
                    UIPasteboard.general.string = data
                },
                UIAction(title: "复制密码") { _ in
                    let category = PasswordManager.shared.categoryList[indexPath.section]
                    let index = indexPath.row
                    let data = PasswordManager.shared.password[category]?[index].password
                    UIPasteboard.general.string = data
                },
            ])
        })
    }
}

extension PasswordListVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setValue("取消", forKey: "cancelButtonText")
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarSearchButtonClicked(_: UISearchBar) {
        isSearching = true
        v.tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        view.endEditing(true)
        v.tableView.reloadData()
    }
}

extension PasswordListVC: PasswordListViewDelegate {
    func refreshData(_ senderView: PasswordListView) {
        let token = UserInfoManager.shared.userInfo.token
        NetworkAPI.getPassword(token: token, completion: { Result in
            senderView.tableView.mj_header?.endRefreshing()
            switch Result {
            case let .success(res):
                if res.status {
                    PasswordManager.shared.decrypt(data: res.data!)
                    senderView.tableView.reloadData()
                } else {
                    HUD.flash(.label(res.msg), delay: 0.5)
                }
            case let .failure(error):
                HUD.flash(.label(error.localizedDescription), delay: 0.5)
            }
        })
    }
}

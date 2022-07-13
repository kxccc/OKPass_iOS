//
//  EditVC.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/11.
//

import UIKit

protocol EditVCDelegate: AnyObject {
    func savePassword(title: String, url: String, username: String, password: String, remark: String, category: String, indexPath: IndexPath?)
}

class EditVC: UIViewController {
    weak var delegate: EditVCDelegate?

    private var v: EditView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground

        title = "编辑"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(clickSaveButton))
        v.delegate = self
        view.addSubview(v)
    }

    func setText(title: String, url: String, username: String, password: String, remark: String, category: String, indexPath: IndexPath) {
        v.setTitle(title)
        v.setUrl(url)
        v.setUsername(username)
        v.setPassword(password)
        v.setRemark(remark)
        v.setCategory(category)
        v.setIndexPath(indexPath)
    }

    override func viewWillLayoutSubviews() {
        v.frame = CGRect(x: view.safeAreaInsets.left,
                         y: view.safeAreaInsets.top,
                         width: view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right,
                         height: view.bounds.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top)
    }

    @objc func clickSaveButton() {
        let title = v.titleTextField.text!
        let url = v.urlTextField.text!
        let username = v.usernameTextField.text!
        let password = v.passwordTextField.text!
        let remark = v.remarkTextField.text!
        let category = v.categoryTextField.text!
        let indexPath = v.indexPath
        navigationController?.popViewController(animated: true)
        delegate?.savePassword(title: title, url: url, username: username, password: password, remark: remark, category: category, indexPath: indexPath)
    }
}

extension EditVC: EditViewDelegate {
    func clickGeneratePasswordButton(_: EditView) {
        navigationController?.pushViewController(GeneratePasswordVC(), animated: true)
    }
}

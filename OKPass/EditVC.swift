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
    private var indexPath: IndexPath?
    weak var delegate: EditVCDelegate?

    private var titleLabel = UILabel()
    private var titleTextField = UITextField()
    private var urlLabel = UILabel()
    private var urlTextField = UITextField()
    private var usernameLabel = UILabel()
    private var usernameTextField = UITextField()
    private var passwordLabel = UILabel()
    private var passwordTextField = UITextField()
    private var generatePasswordButton = UIButton()
    private var remarkLabel = UILabel()
    private var remarkTextField = UITextField()
    private var categoryLabel = UILabel()
    private var categoryTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "编辑"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(clickSaveButton))

        titleLabel.text = "标题"
        urlLabel.text = "网址"
        usernameLabel.text = "用户名"
        passwordLabel.text = "密码"
        remarkLabel.text = "备注"
        categoryLabel.text = "分类"
        titleTextField.borderStyle = .roundedRect
        urlTextField.borderStyle = .roundedRect
        usernameTextField.borderStyle = .roundedRect
        passwordTextField.borderStyle = .roundedRect
        remarkTextField.borderStyle = .roundedRect
        categoryTextField.borderStyle = .roundedRect
        generatePasswordButton.configuration = UIButton.Configuration.gray()
        generatePasswordButton.setTitle("随机生成", for: .normal)
        generatePasswordButton.addTarget(self, action: #selector(clickGeneratePasswordButton), for: .touchUpInside)

        let passwordStack = UIStackView()
        passwordStack.spacing = 12
        passwordStack.addArrangedSubview(passwordTextField)
        passwordStack.addArrangedSubview(generatePasswordButton)
        NSLayoutConstraint.activate([
            passwordTextField.widthAnchor.constraint(equalTo: passwordStack.widthAnchor, multiplier: 0.65),
        ])

        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.spacing = 12
        vStack.axis = .vertical

        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(titleTextField)
        vStack.addArrangedSubview(urlLabel)
        vStack.addArrangedSubview(urlTextField)
        vStack.addArrangedSubview(usernameLabel)
        vStack.addArrangedSubview(usernameTextField)
        vStack.addArrangedSubview(passwordLabel)
        vStack.addArrangedSubview(passwordStack)
        vStack.addArrangedSubview(remarkLabel)
        vStack.addArrangedSubview(remarkTextField)
        vStack.addArrangedSubview(categoryLabel)
        vStack.addArrangedSubview(categoryTextField)
        view.addSubview(vStack)

        NSLayoutConstraint.activate([
            vStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            vStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }

    @objc func clickSaveButton() {
        let title = titleTextField.text!
        let url = urlTextField.text!
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        let remark = remarkTextField.text!
        let category = categoryTextField.text!
        navigationController?.popViewController(animated: true)
        delegate?.savePassword(title: title, url: url, username: username, password: password, remark: remark, category: category, indexPath: indexPath)
    }

    @objc func clickGeneratePasswordButton() {
        navigationController?.pushViewController(GeneratePasswordVC(), animated: true)
    }

    func setTitle(_ title: String) {
        titleTextField.text = title
    }

    func setUrl(_ url: String) {
        urlTextField.text = url
    }

    func setUsername(_ username: String) {
        usernameTextField.text = username
    }

    func setPassword(_ password: String) {
        passwordTextField.text = password
    }

    func setRemark(_ remark: String) {
        remarkTextField.text = remark
    }

    func setCategory(_ category: String) {
        categoryTextField.text = category
    }

    func setIndexPath(_ indexPath: IndexPath) {
        self.indexPath = indexPath
    }
}

//
//  EditView.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/13.
//

import UIKit

protocol EditViewDelegate: AnyObject {
    func clickGeneratePasswordButton(_ senderView: EditView)
}

class EditView: UIView {
    weak var delegate: EditViewDelegate?

    var indexPath: IndexPath?

    var titleLabel = UILabel()
    var titleTextField = UITextField()
    var urlLabel = UILabel()
    var urlTextField = UITextField()
    var usernameLabel = UILabel()
    var usernameTextField = UITextField()
    var passwordLabel = UILabel()
    var passwordTextField = UITextField()
    var generatePasswordButton = UIButton()
    var remarkLabel = UILabel()
    var remarkTextField = UITextField()
    var categoryLabel = UILabel()
    var categoryTextField = UITextField()

    override init(frame: CGRect) {
        super.init(frame: frame)

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
        generatePasswordButton.configuration = .gray()
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
        addSubview(vStack)

        NSLayoutConstraint.activate([
            vStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            vStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            vStack.topAnchor.constraint(equalTo: topAnchor),
        ])
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func clickGeneratePasswordButton() {
        delegate?.clickGeneratePasswordButton(self)
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

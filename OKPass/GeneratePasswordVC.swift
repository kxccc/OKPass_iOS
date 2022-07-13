//
//  GeneratePasswordVC.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/12.
//

import UIKit

protocol GeneratePasswordVCDelegate: AnyObject {
    func newPassword(newPassword: String)
}

class GeneratePasswordVC: UIViewController {
    weak var delegate: GeneratePasswordVCDelegate?
    private var v: GeneratePasswordView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground

        v = GeneratePasswordView()
        v.delegate = self
        view.addSubview(v)
    }

    override func viewWillLayoutSubviews() {
        v.frame = CGRect(x: view.safeAreaInsets.left,
                         y: view.safeAreaInsets.top,
                         width: view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right,
                         height: view.bounds.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top)
    }

    func getRandomStringOfLength(length: Int, characters: String) -> String {
        var ranStr = ""
        for _ in 0 ..< length {
            let index = Int(arc4random_uniform(UInt32(characters.count)))
            let index1 = characters.index(characters.startIndex, offsetBy: index)
            let index2 = characters.index(characters.startIndex, offsetBy: index)
            let sub = characters[index1 ... index2]
            ranStr += sub
        }
        return ranStr
    }
}

extension GeneratePasswordVC: GeneratePasswordViewDelegate {
    func lenSliderValueChanged(_ senderView: GeneratePasswordView, newValue: Float) {
        let minLen = 8
        let maxLen = 24
        senderView.len = Int(newValue * Float(maxLen - minLen)) + minLen
    }

    func clickGenerateButton(_ senderView: GeneratePasswordView) {
        let uppercase = "QWERTYUIOPASDFGHJKLZXCVBNM"
        let lowercase = "qwertyuiopasdfghjklzxcvbnm"
        let numbers = "1234567890"
        let symbols = "!@#$%^&*()-=_+[]{}<>?"
        var option = ""
        let length = senderView.len
        if senderView.uppercaseSwitch.isOn {
            option += uppercase
        }
        if senderView.lowercaseSwitch.isOn {
            option += lowercase
        }
        if senderView.numbersSwitch.isOn {
            option += numbers
        }
        if senderView.symbolsSwitch.isOn {
            option += symbols
        }
        if option.isEmpty {
            return
        }
        senderView.passwordTextField.text = getRandomStringOfLength(length: length, characters: option)
    }

    func clickConfirmButton(_: GeneratePasswordView, newPassword: String) {
        navigationController?.popViewController(animated: true)
        delegate?.newPassword(newPassword: newPassword)
    }
}

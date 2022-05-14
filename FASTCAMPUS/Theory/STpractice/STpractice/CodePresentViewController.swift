//
//  CodePresentViewController.swift
//  STpractice
//
//  Created by 이주송 on 2022/05/14.
//

import UIKit

protocol sendDataDelegate: AnyObject {
    func sendData(goToVC: String)
}

class CodePresentViewController: UIViewController {

    var valueInPresentController: String?
    weak var delegate: sendDataDelegate?
    
    @IBOutlet weak var presentedLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func tapBackButton(_ sender: Any) {
        self.delegate?.sendData(goToVC: self.textField.text ?? "")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let codePresent = valueInPresentController {
            self.presentedLabel.text = codePresent
        }
    }
}

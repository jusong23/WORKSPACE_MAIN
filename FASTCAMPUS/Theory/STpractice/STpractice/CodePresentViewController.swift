//
//  CodePresentViewController.swift
//  STpractice
//
//  Created by 이주송 on 2022/05/14.
//

import UIKit

protocol sendDataDelegateByPresent: AnyObject {
    func sendDataByPresent(goToVC: String)
}

class CodePresentViewController: UIViewController {

    var valueInPresentController: String?
    weak var delegate: sendDataDelegateByPresent?
    
    @IBOutlet weak var presentedLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func tapBackButton(_ sender: Any) {
        self.delegate?.sendDataByPresent(goToVC: self.textField.text ?? "")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let codePresent = valueInPresentController {
            self.presentedLabel.text = codePresent
        }
    }
}

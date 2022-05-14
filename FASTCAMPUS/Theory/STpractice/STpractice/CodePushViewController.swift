//
//  CodePushViewController.swift
//  STpractice
//
//  Created by 이주송 on 2022/05/14.
//

import UIKit

protocol sendDataDelegateByPush: AnyObject {
    func sendDataByPush(goToVC: String)
}

class CodePushViewController: UIViewController {

    var valueInPushController: String?
    weak var delegate: sendDataDelegateByPush?

    
    @IBOutlet weak var pushedLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func tapBackButton(_ sender: Any) {
        self.delegate?.sendDataByPush(goToVC: self.textField.text ?? "")
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let codePushed = valueInPushController {
            self.pushedLabel.text = codePushed
        }
    }
}

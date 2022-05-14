//
//  CodePushViewController.swift
//  STpractice
//
//  Created by 이주송 on 2022/05/14.
//

import UIKit

class CodePushViewController: UIViewController {

    var pushed: String?
    
    @IBOutlet weak var pushedLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func tapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let codePushed = pushed {
            self.pushedLabel.text = codePushed
        }
    }
}

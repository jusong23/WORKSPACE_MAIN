//
//  CodePresentViewController.swift
//  STpractice
//
//  Created by 이주송 on 2022/05/14.
//

import UIKit

class CodePresentViewController: UIViewController {

    @IBOutlet weak var presentedLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBAction func tapBackButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

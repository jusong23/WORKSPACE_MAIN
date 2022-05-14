//
//  ViewController.swift
//  STpractice
//
//  Created by 이주송 on 2022/05/14.
//

import UIKit

class ViewController: UIViewController {

    var ExampleText: String?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var willBeChangingLabel: UILabel!
    
    @IBAction func tapPushButton(_ sender: Any) {
        guard let codePushViewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePushViewController") as? CodePushViewController else { return }
        self.navigationController?.pushViewController(codePushViewController, animated: true)
        codePushViewController.valueInPushController = self.textField.text
    }
    
    @IBAction func tapPresentButton(_ sender: Any) {
        guard let codePresentViewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePresentViewController") as? CodePresentViewController else { return }
        codePresentViewController.modalPresentationStyle = .fullScreen
        self.present(codePresentViewController, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}


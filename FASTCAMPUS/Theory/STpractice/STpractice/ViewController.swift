//
//  ViewController.swift
//  STpractice
//
//  Created by 이주송 on 2022/05/14.
//

import UIKit

class ViewController: UIViewController {
    
   
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var willBeChangingLabel: UILabel!
    
    @IBAction func tapPushButton(_ sender: Any) {
        guard let codePushViewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePushViewController") as? CodePushViewController else { return }
        self.navigationController?.pushViewController(codePushViewController, animated: true)
        codePushViewController.delegate = self
        codePushViewController.valueInPushController = self.textField.text
    }
    
    @IBAction func tapPresentButton(_ sender: Any) {
        guard let codePresentViewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePresentViewController") as? CodePresentViewController else { return }
        codePresentViewController.modalPresentationStyle = .fullScreen
        codePresentViewController.valueInPresentController = self.textField.text
        codePresentViewController.delegate = self
        self.present(codePresentViewController, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

extension ViewController: sendDataDelegateByPresent {
    func sendDataByPresent(goToVC: String) {
        self.willBeChangingLabel.text = goToVC
    }
}


extension ViewController: sendDataDelegateByPush {
    func sendDataByPush(goToVC: String) {
        self.willBeChangingLabel.text = goToVC
    }
}

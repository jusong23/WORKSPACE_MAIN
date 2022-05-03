//
//  ViewController.swift
//  ClosureExample
// //
//  Created by 이주송 on 2022/05/03.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapNextButton(_ sender: UIBarButtonItem) {
        guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NextViewController" ) as? NextViewController else { return }
        nextViewController.modalPresentationStyle = .fullScreen
        
        nextViewController.dataSendClosure =
        { (data) -> () in // Closure Head
            self.dataLabel.text = data // 실행구문
        // VC -> nextVC 에서 Closure 정의만! 실행은 X
        }
        
        self.present(nextViewController, animated: true, completion: nil)

        }
    }
   
// dataSendClosure는 '다음'버튼을 누를때 정의 되고, nextVC에서 yes button이 눌리면 실행된다.

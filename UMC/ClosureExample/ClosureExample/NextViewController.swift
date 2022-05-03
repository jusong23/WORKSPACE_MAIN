//
//  NextViewController.swift
//  ClosureExample
//
//  Created by 이주송 on 2022/05/03.
//

import UIKit

class NextViewController: UIViewController {

    var dataSendClosure: ((_ data: String) -> ())?
    // Parameter type : String , return type: Void인 Closure만 따로 정의
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapNoButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)

    }
  
    @IBAction func tapYesDataButton(_ sender: UIButton) {
        self.dataSendClosure?("이전화면에서 전달")
        // Closure 실행
        // Closure는 VC -> nextVC 이동시 정의된다
        self.dismiss(animated: true, completion: nil)
    }
  
  
}

//
//  RoundButton.swift
//  Lecture_Calculator
//
//  Created by 이주송 on 2022/05/03.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    
        @IBInspectable var isRound: Bool = false {
            didSet{
            if isRound {
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }
}

//
//  CovidDetailViewController.swift
//  COVID19
//
//  Created by 이주송 on 2022/05/10.
//

import UIKit

class CovidDetailViewController: UITableViewController {


    @IBOutlet weak var newCaseCell: UILabel!
    @IBOutlet weak var totalCaseCell: UILabel!
    @IBOutlet weak var recoveredCell: UILabel!
    @IBOutlet weak var deathCell: UILabel!
    @IBOutlet weak var percentageCell: UILabel!
    @IBOutlet weak var overseasInflowCell: UILabel!
    @IBOutlet weak var regionalOunbreakCell: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

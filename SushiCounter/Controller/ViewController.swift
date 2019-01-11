//
//  ViewController.swift
//  SushiCounter
//
//  Created by Michel Anderson Lutz Teixeira on 10/01/19.
//  Copyright © 2019 Michel Anderson Lutz Teixeira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lbCounter: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    let sushiDayViewModel = SushiDayViewModel.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sushisToday = sushiDayViewModel.getToday() {
            lbCounter.text = "\(sushisToday.count)"
            stepper.value = Double(sushisToday.count)
        }
    }
    
    @IBAction func stepperCounter(_ sender: UIStepper) {
        lbCounter.text = "\(Int(sender.value))"
        let sushiDay = SushiDay()
        sushiDay.date = DateUtils.dateNow()
        sushiDay.count = Int(sender.value)
        sushiDayViewModel.persistsushiDay(sushiDay: sushiDay)
    }
}




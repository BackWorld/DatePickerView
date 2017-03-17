//
//  ViewController.swift
//  DatePickerDemo
//
//  Created by zhuxuhong on 2017/3/17.
//  Copyright © 2017年 zhuxuhong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var dateBtn: UIButton!

    private var selectedDate = Date(){
        didSet{
            let df = DateFormatter()
            df.timeStyle = .short
            df.dateStyle = .full
//            df.dateFormat = "yyyy年M月dd日 HH:mm"
            let date = df.string(from: selectedDate)
            dateBtn.titleLabel?.text = date
            dateBtn.setTitle(date, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func actionOfButtonClick(_ sender: UIButton) {
        
        DatePickerView.show(selected: selectedDate) {
            [unowned self] (date) in
            
            self.selectedDate = date
        }
    }


}


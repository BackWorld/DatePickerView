//
//  DatePickerView.swift
//  DatePickerDemo
//
//  Created by zhuxuhong on 2017/3/17.
//  Copyright © 2017年 zhuxuhong. All rights reserved.
//

import UIKit


private let containerHeight: CGFloat = 260

class DatePickerView: UIView {
// MARK: - IBOutlet
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerBottomCons: NSLayoutConstraint!

// MARK: - properties
    
    // 点击确定按钮回调
    private var callbackForCompletion: ((_ date: Date) -> Void)?
    
    // 上次选中的日期
    private var selectedDate: Date!{
        didSet{
            datePicker.minimumDate = selectedDate
            datePicker.date = selectedDate
        }
    }
    
// MARK: - initial method
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initialSettings(){
        
    }
    
    // 初始化
    private static func pickerFromXib() -> DatePickerView{
        let picker = Bundle.main.loadNibNamed("DatePickerView", owner: nil, options: nil)?.first as! DatePickerView
        
        return picker
    }
    
// MARK: - lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

// MARK: - action & IBOutletAction
    @IBAction func actionOfButtonClick(_ sender: UIButton) {
        guard let callback = callbackForCompletion else {
            return
        }
        
        if sender == cancelBtn {
            cancel()
        }
        else{
            callback(datePicker.date) //回调
            cancel()
        }
    }
    
    @IBAction func actionOfPickerValueDidChange(_ sender: UIButton) {
        
    }
    
// MARK: - private method
    private func cancel(){
        animate(isShow: false)
    }
    
    private func animate(isShow: Bool){
        containerBottomCons.constant = isShow ? 0 : -containerHeight
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn, animations: {
            self.layoutIfNeeded()
        })
        { (finished) in
            if !isShow {
                self.removeFromSuperview()
            }
        }
    }
    
// MARK: - getters
 
// MARK: - setters
    
// MARK: - delegate method
    
// MARK: - public method
    public static func show(selected: Date,
                     _ completion: ((_ date: Date)->Void)?)
    {
        let picker = DatePickerView.pickerFromXib()
        picker.callbackForCompletion = completion
        
        let window = UIApplication.shared.keyWindow!
        window.addSubview(picker)
        picker.frame = window.bounds
        picker.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        picker.animate(isShow: true)
        
        // 已选择的时间
        picker.selectedDate = selected
    }
}

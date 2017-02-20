//
//  SettingViewController.swift
//  Swift2048
//
//  Created by Sunhy on 16/12/21.
//  Copyright © 2016年 Sunhy. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate {

    var mainView = MainViewController()
    var segDimension:UISegmentedControl!
    var txtNum:UITextField!
    
    init(mainView:MainViewController) {
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupControls()
        // Do any additional setup after loading the view.
    }
    
    func setupControls() {
        let labelNum = ControlView.createLabel("阈值")
        labelNum.frame = CGRect(x: 30, y: 100, width: 60, height: 30)
        self.view.addSubview(labelNum)
        
        txtNum = ControlView.createTextField(value: "\(mainView.maxNumber)", sender: self)
        txtNum.frame = CGRect(x: 90, y: 100, width: 255, height: 30)
        txtNum.returnKeyType = UIReturnKeyType.done
        self.view.addSubview(txtNum)
        
        let labelDm = ControlView.createLabel("维度")
        labelDm.frame = CGRect(x: 30, y: 150, width: 60, height: 30)
        self.view.addSubview(labelDm)
        
        segDimension = ControlView.createSegment(items: ["3x3", "4x4", "5x5"], action: #selector(SettingViewController.dimentionChanged(sender:)), sender: self)
        segDimension.frame = CGRect(x: 90, y: 150, width: 255, height: 30)
        segDimension.tintColor = UIColor.orange
        segDimension.selectedSegmentIndex = 1
        self.view.addSubview(segDimension)
    }
    
    func dimentionChanged(sender:SettingViewController) {
        var segVals = [3, 4, 5]
        mainView.dimention = segVals[segDimension.selectedSegmentIndex]
        mainView.restart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //textField 放弃成为第一响应者
        textField.resignFirstResponder()
        print("num changed")
        if textField.text != "\(mainView.maxNumber)" {
            let num = Int(textField.text!)
            mainView.maxNumber = num!
        }
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

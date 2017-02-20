//
//  ControlView.swift
//  Swift2048
//
//  Created by Sunhy on 16/12/21.
//  Copyright © 2016年 Sunhy. All rights reserved.
//

import UIKit

class ControlView {
    /// 创建retry按钮
    ///
    /// - Parameters:
    ///   - action: action for target
    ///   - sender: sender
    /// - Returns: 重试按钮实例
    static func createButton(_ action: Selector, sender: UIViewController)-> UIButton {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named:"retry"), for: UIControlState.normal)
        button.setBackgroundImage(UIImage(named:"retryHighlighted"), for: UIControlState.highlighted)
        button.addTarget(sender, action: action, for: UIControlEvents.touchUpInside)
        button.layer.cornerRadius = 16;
        return button
    }
    
    /// 创建Textfield
    ///
    /// - Parameters:
    ///   - value: 要显示的值
    ///   - sender: sender
    /// - Returns: UITextField实例
    static func createTextField(value: String, sender: UITextFieldDelegate)-> UITextField {
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 15
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor(red: 254/255.0, green: 204/255.0, blue: 57/255.0, alpha: 1.0).cgColor
        textField.textColor = UIColor.black
        textField.text = value
        textField.adjustsFontSizeToFitWidth = true
        textField.delegate = sender
        return textField
    }
    
    /// 创建Segment
    ///
    /// - Parameters:
    ///   - items: 初始化用的items
    ///   - action: action for target
    ///   - sender: sender
    /// - Returns: UISegmentedControl实例
    static func createSegment(items: [String], action: Selector, sender: UIViewController)-> UISegmentedControl {
        let segment = UISegmentedControl(items: items)
        segment.isMomentary = false;
        segment.addTarget(sender, action: action, for: UIControlEvents.valueChanged)
        return segment
    }
    
    /// 创建label
    ///
    /// - Parameter title: 要显示的内容
    /// - Returns: UILabel实例
    static func createLabel(_ title: String)-> UILabel {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = title;
        label.font = UIFont(name: "HelveticalNeue-Bold", size: 16)
        return label
    }
}

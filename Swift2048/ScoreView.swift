//
//  ScoreView.swift
//  Swift2048
//
//  Created by Sunhy on 17/1/4.
//  Copyright © 2017年 Sunhy. All rights reserved.
//

import Foundation

import UIKit

protocol ScoreViewProtocol {
    func changeScore(value s:Int)
}

class ScoreView: UIView, ScoreViewProtocol {
    var label:UILabel
    let defaultFrame = CGRect(x: 0, y: 0, width: 162, height: 30)
    var score:Int = 0 {
        didSet {
            label.text = "  分数:    \(score)"
        }
    }
    init() {
        label = UILabel(frame: defaultFrame)
        label.textAlignment = NSTextAlignment.left
        label.layer.borderColor = UIColor(red: 254/255.0, green: 204/255.0, blue: 57/255.0, alpha: 1.0).cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.black
        super.init(frame: defaultFrame)
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeScore(value s: Int) {
        score = s
    }
}

class BestScoreView:ScoreView {
    var bestScore:Int = 0 {
        didSet {
            label.text = "  最高:    \(bestScore)"
        }
    }
    
    override func changeScore(value s: Int) {
        bestScore = s
    }
}

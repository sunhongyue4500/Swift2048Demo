//
//  TileView.swift
//  Swift2048
//
//  Created by Sunhy on 16/12/23.
//  Copyright © 2016年 Sunhy. All rights reserved.
//

import UIKit

class TileView : UIView {
    let colorMap = [
        2:UIColor(red: 235/255.0, green: 235/255.0, blue: 75/255.0, alpha: 1.0),
        4:UIColor(red: 190/255.0, green: 235/255.0, blue: 50/255.0, alpha: 1.0),
        8:UIColor(red: 95/255.0, green: 235/255.0, blue: 100/255.0, alpha: 1.0),
        16:UIColor(red: 0/255.0, green: 235/255.0, blue: 200/255.0, alpha: 1.0),
        32:UIColor(red: 70/255.0, green: 200/255.0, blue: 250/255.0, alpha: 1.0),
        64:UIColor(red: 70/255.0, green: 165/255.0, blue: 250/255.0, alpha: 1.0),
        128:UIColor(red: 180/255.0, green: 110/255.0, blue: 255/255.0, alpha: 1.0),
        256:UIColor(red: 235/255.0, green: 95/255.0, blue: 250/255.0, alpha: 1.0),
        512:UIColor(red: 240/255.0, green: 90/255.0, blue: 155/255.0, alpha: 1.0),
        1024:UIColor(red: 235/255.0, green: 70/255.0, blue: 75/255.0, alpha: 1.0),
        2048:UIColor(red: 255/255.0, green: 135/255.0, blue: 50/255.0, alpha: 1.0),
    ]
    
    var numberLabel : UILabel
    // 监测颜色和文字的变化
    var value : Int = 0 {
        didSet {
            backgroundColor = colorMap[value]
            numberLabel.text = "\(value)"
        }
    }
    
    init(pos:CGPoint, width:CGFloat, value:Int) {
        numberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: width))
        numberLabel.textAlignment = NSTextAlignment.center
        // 最小收缩比例
        numberLabel.minimumScaleFactor = 0.5
        numberLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        numberLabel.text = "\(value)"
        super.init(frame:CGRect(x: pos.x, y: pos.y, width: width, height: width))
        addSubview(numberLabel)
        self.value = value
        backgroundColor = colorMap[value]
        switch value {
        case 2, 4:
            numberLabel.textColor = UIColor(red: 119.0/255.0, green: 110/255.0, blue: 101/255.0, alpha: 1.0)
            break
        default:
            numberLabel.textColor = UIColor.white
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

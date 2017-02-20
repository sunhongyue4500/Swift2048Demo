//
//  GuideViewController.swift
//  Swift2048
//
//  Created by Sunhy on 16/12/21.
//  Copyright © 2016年 Sunhy. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController, UIScrollViewDelegate {

    var numPages = 4
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = self.view.bounds
        let scrollView = UIScrollView()
        scrollView.frame = self.view.bounds
        // 设置scrollView的滚动区域
        scrollView.contentSize = CGSize(width: CGFloat(numPages) * frame.size.width, height: frame.size.height)
        // 设置允许分页
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        var imageFile:String
        var image:UIImage?
        var imageView:UIImageView
        for i in 0..<numPages {
            imageFile = "welcome\(i+1)"
            image = UIImage(named: imageFile)
            imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: frame.size.width * CGFloat(i), y: CGFloat(0), width: frame.size.width, height: frame.size.height)
            scrollView.addSubview(imageView)
        }
        scrollView.contentOffset = CGPoint.zero
        self.view.addSubview(scrollView)
        scrollView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 滚动触发
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

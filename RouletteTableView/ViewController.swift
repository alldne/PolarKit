//
//  ViewController.swift
//  RouletteTableView
//
//  Created by Yonguk Jeong on 2016. 4. 15..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let outer = UIView()
        outer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        outer.backgroundColor = UIColor.lightGrayColor()
        let polar = PolarView(contentView: outer, radius: 0, angle: 0)
        self.view.addSubview(polar)

        let n = 12
        let ang = 2 * M_PI / Double(n)
        for i in 0..<n {
            let inner = UIView()
            inner.frame = CGRectMake(0, 0, 40, 10)
            inner.backgroundColor = UIColor.grayColor()
            let innerPolar = PolarView(contentView: inner, radius: 100, angle: Double(i) * ang)
            polar.addSubview(innerPolar)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


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

        let polar = PolarView(radius: 0, angle: 0)
        polar.backgroundColor = UIColor.lightGrayColor()
        polar.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        self.view.addSubview(polar)

        let wrapper = PolarView(radius: 0, angle: 0)
        wrapper.frame = CGRectMake(0, 0, 320, 320)
        polar.addSubview(wrapper)

        let n = 12
        let ang = 2 * M_PI / Double(n)
        for i in 0..<n {
            let inner = PolarView(radius: 100, angle: Double(i) * ang)
            inner.frame = CGRectMake(0, 0, 40, 10)
            inner.backgroundColor = UIColor.grayColor()
            wrapper.addSubview(inner)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


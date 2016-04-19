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

        let polar = DebugPolarView()
        polar.backgroundColor = UIColor.lightGrayColor()
        polar.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        self.view.addSubview(polar)

        let wrapper = DebugPolarView()
        wrapper.frame = CGRectMake(0, 0, 320, 320)
        polar.addSubview(wrapper)

        let n = 12
        let ang = 2 * M_PI / Double(n)
        for i in 0..<n {
            let inner = DebugPolarView(radius: 100, angle: Double(i) * ang, frame: CGRectMake(0, 0, 40, 10))
            if i == 0 {
                inner.backgroundColor = UIColor.redColor()
            } else {
                inner.backgroundColor = UIColor.grayColor()
            }
            wrapper.addSubview(inner)
        }

        polar.layoutIfNeeded()

        UIView.animateWithDuration(2, animations: { () -> Void in
            wrapper.angle = M_PI
            polar.layoutIfNeeded()
        }, completion: {(finished) in
            print(finished)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


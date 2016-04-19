//
//  AnimationTestViewController.swift
//  RouletteTableView
//
//  Created by Yonguk Jeong on 2016. 4. 15..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

class AnimationTestViewController: UIViewController {
    @IBOutlet weak var container: UIView?

    var offset: Double = 0
    @IBAction func animate(sender: UIButton) {
        UIView.animateWithDuration(2, delay: 0, options: [.BeginFromCurrentState], animations: { () -> Void in
            print("<", NSDate(), self.offset)
            self.offset += M_PI_2
            self.offset %= M_PI*2
            self.wrapper?.angle = self.offset
            self.polar?.layoutIfNeeded()
        }, completion: {(finished) in
            print(finished)
            print(">", NSDate())
        })
    }

    var wrapper: PolarView?
    var polar: PolarView?

    override func viewDidLoad() {
        super.viewDidLoad()

        let polar = PolarView()
        polar.backgroundColor = UIColor.lightGrayColor()
        polar.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        self.container?.addSubview(polar)

        let wrapper = PolarView()
        wrapper.frame = CGRectMake(0, 0, 320, 320)
        polar.addSubview(wrapper)

        let n = 12
        let ang = 2 * M_PI / Double(n)
        for i in 0..<n {
            let inner = PolarView(radius: 100, angle: Double(i) * ang, frame: CGRectMake(0, 0, 40, 10))
            if i == 0 {
                inner.backgroundColor = UIColor.redColor()
            } else {
                inner.backgroundColor = UIColor.grayColor()
            }
            wrapper.addSubview(inner)
        }

        polar.layoutIfNeeded()

        self.polar = polar
        self.wrapper = wrapper
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


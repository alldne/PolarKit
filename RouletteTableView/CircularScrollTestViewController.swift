//
//  CircularScrollTestViewController.swift
//  RouletteTableView
//
//  Created by Yonguk Jeong on 2016. 4. 19..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

class CircularScrollTestViewController: UIViewController {
    @IBOutlet weak var container: UIView!

    @IBAction func valueChanged(sender: UISlider) {
        self.circularScrollView.contentOffset = 4 * M_PI * Double(sender.value)
    }

    var circularScrollView: CircularScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.circularScrollView = CircularScrollView(frame: CGRectZero)

        let n = 24
        let ang = 4 * M_PI / Double(n)
        for i in 0..<n {
            let p = PolarCoordinated(radius: 100, angle: ang * Double(i), frame: CGRectMake(0, 0, 40, 20))
            let ratio = CGFloat(Double(i) / Double(n))
            p.backgroundColor = UIColor(red: ratio, green: ratio, blue: 1 - ratio, alpha: 1)
            let label = UILabel()
            label.text = "\(i)"
            label.sizeToFit()
            label.textColor = UIColor(red: 1 - ratio, green: 1 - ratio, blue: ratio, alpha: 1)
            label.center = p.center
            p.addSubview(label)
            self.circularScrollView.addSubview(polarCoordinated: p)
        }
        self.container.addSubview(self.circularScrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.circularScrollView.frame = self.container.frame
    }
}

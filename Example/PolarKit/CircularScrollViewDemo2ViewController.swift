//
//  CircularScrollViewDemo2ViewController.swift
//  PolarKit
//
//  Created by Yonguk Jeong on 2016. 4. 30..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit
import PolarKit

class CircularScrollViewDemo2ViewController: UIViewController {
    @IBOutlet weak var container: UIView!

    @IBAction func valueChanged(_ sender: UISlider) {
        self.circularScrollView.offset = self.circularScrollView.contentLength * Double(sender.value)
    }

    var circularScrollView: CircularScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let makeView = { (radius: Double, angle: Double, color: UIColor) -> PolarCoordinatedView in
            let p = PolarCoordinatedView(radius: radius, angle: angle, frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            p.backgroundColor = color
            p.layer.opacity = 0.5
            return p
        }

        self.circularScrollView = CircularScrollView(frame: CGRect.zero)

        let n = 24
        let contentLength = 4 * Double.pi
        let ang = contentLength / Double(n)
        let r = 200 / Double(n)
        for i in 0...n {
            let ratio = CGFloat(Double(i) / Double(n))
            let color = UIColor(red: ratio, green: ratio, blue: 1 - ratio, alpha: 1)
            let p = makeView(r * Double(i), ang * Double(i), color)
            self.circularScrollView.addSubview(p)
        }

        self.container.addSubview(self.circularScrollView)
        self.circularScrollView.contentLength = contentLength
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

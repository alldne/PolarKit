//
//  RotatableViewDemoViewController.swift
//  PolarKit
//
//  Created by Yonguk Jeong on 2016. 4. 19..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit
import PolarKit

class RotatableViewDemoViewController: UIViewController {
    @IBOutlet weak var container: UIView!

    let animationKey = "myrotation"
    @IBAction func valueChanged(sender: UISlider) {
        self.rotatable.layer.removeAnimationForKey(animationKey)
        self.rotatable.offset = 4 * M_PI * Double(sender.value)
    }

    var direction: Bool = true
    @IBAction func tapped(sender: AnyObject) {
        var goal: Double
        if direction {
            goal = M_PI * 2
            self.direction = false
        } else {
            goal = 0.0
            self.direction = true
        }
        // FIXME: Worse performance than animating "transform.rotation.z" directly
        let anim = CABasicAnimation(keyPath: "offset")
        anim.toValue = goal
        // FIXME: The actual animation duration on screen is shorter than intended.
        anim.duration = 2.0
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.rotatable.layer.addAnimation(anim, forKey: animationKey)
    }

    var content: UIImageView!

    var rotatable: RotatableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rotatable = RotatableView(frame: CGRectMake(0, 0, self.container.frame.size.width, self.container.frame.size.height))

        self.content = UIImageView(image: UIImage(named: "uatt"))
        self.content.frame.size = CGSizeMake(270, 182)
        self.rotatable.addSubview(self.content)
        self.container.addSubview(self.rotatable)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.rotatable.frame.size = self.container.frame.size
        self.content.center = self.rotatable.center
    }
}

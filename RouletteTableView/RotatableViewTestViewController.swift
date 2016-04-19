//
//  RotatableViewTestViewController.swift
//  RouletteTableView
//
//  Created by Yonguk Jeong on 2016. 4. 19..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

class RotatableViewTestViewController: UIViewController {
    @IBOutlet weak var container: UIView!

    @IBAction func valueChanged(sender: UISlider) {
        self.rotatable.offset = 2 * M_PI * Double(sender.value)
    }

    var label: UILabel!
    var bar: UIView!

    var rotatable: RotatableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rotatable = RotatableView(frame: CGRectMake(0, 0, self.container.frame.size.width, self.container.frame.size.height))

        self.bar = UIView(frame: CGRectMake(0, 0, 40, 10))
        self.bar.backgroundColor = UIColor.lightGrayColor()
        self.rotatable.addSubview(self.bar)
        self.container.addSubview(self.rotatable)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.rotatable.frame = CGRectMake(0, 0, self.container.frame.size.width, self.container.frame.size.height)
        self.bar.center = CGPointMake(self.rotatable.frame.size.width/2, self.rotatable.frame.size.height/2)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

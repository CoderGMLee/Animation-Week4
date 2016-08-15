//
//  PresentVC.swift
//  Animation-Week4
//
//  Created by GM on 16/8/15.
//  Copyright © 2016年 LGM. All rights reserved.
//

import UIKit

class PresentVC: UIViewController {

    var button : UIButton?

    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.whiteColor();

        button = UIButton(type : .Custom);
        button?.width = 100;
        button?.height = 100;
        button?.center = CGPointMake(100, 100);
        button?.setTitle("click", forState: .Normal);
        button?.backgroundColor = UIColor.redColor();
        button?.layer.cornerRadius = 50;
        button?.layer.masksToBounds = true;
        button?.addTarget(self, action: #selector(ViewController.btnClicked(_:)), forControlEvents: .TouchUpInside);
        self.view.addSubview(button!);
    }
    func btnClicked(btn:UIButton){
        print("PresentVC btnClicked");
        self.dismissViewControllerAnimated(true, completion: nil);
    }
}

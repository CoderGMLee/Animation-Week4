//
//  ViewController.swift
//  Animation-Week4
//
//  Created by GM on 16/8/15.
//  Copyright © 2016年 LGM. All rights reserved.
//

import UIKit
/**
 *  自定义转场VC要遵循UIViewControllerTransitioningDelegate协议，并且要实现对应的方法，例如
 *  animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
 */
class ViewController: UIViewController,UIViewControllerTransitioningDelegate {

    var button : UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor();
        button = UIButton(type : .Custom);
        button?.width = 100;
        button?.height = 100;
        button?.center = self.view.center;
        button?.setTitle("click", forState: .Normal);
        button?.backgroundColor = UIColor.redColor();
        button?.layer.cornerRadius = 50;
        button?.layer.masksToBounds = true;
        button?.addTarget(self, action: #selector(ViewController.btnClicked(_:)), forControlEvents: .TouchUpInside);
        self.view.addSubview(button!);

    }
    func btnClicked(btn : UIButton){
        print("btnClicked");
        let presentVC = PresentVC()
        /**
         *  自定义转场动画一定要设置transitioningDelegate代理，否则不会执行自定义的转场动画
         */
        presentVC.transitioningDelegate = self;
        self.presentViewController(presentVC, animated: true, completion: nil);
    }
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = Animator(style: .present,location: (button?.center)!);
        return animator;
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = Animator(style: .dismiss,location: (button?.center)!);
        return animator;
    }
}


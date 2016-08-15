//
//  Animator.swift
//  Animation-Week4
//
//  Created by GM on 16/8/15.
//  Copyright © 2016年 LGM. All rights reserved.
//

import Foundation
import UIKit
/**
 *  自定义转场动画依赖于UIViewControllerAnimatedTransitioning这个协议，并且必须实现协议中的2个方法，分别是
 *  1、transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval
 *  2、animateTransition(transitionContext: UIViewControllerContextTransitioning)
 */

enum TransitionStyle : Int{
    case present = 0
    case dismiss
}
class Animator: NSObject,UIViewControllerAnimatedTransitioning {

    var location : CGPoint?
    var style : TransitionStyle = .present

    init(style: TransitionStyle, location:CGPoint){
        super.init();
        self.location = location;
        self.style = style;
    }

    /**
     *  返回动画执行的时间
     */
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.55
    }

    /**
     *  具体的动画要在这个方法中实现
     */
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {

        if style == .present {
            self.maskPresentAniamtion(transitionContext);
        }else{
            self.maskDismissAniamtion(transitionContext);
        }
    }

    /**
     *  transitionContext.containerView()  相当于一个容器，添加进去的View会有上下层级之分，一般会吧fromView 和 toView添加进去
     *  prame:transitionContext   转场的上下文，可以通过他拿到转场的两个VC以及对应的View
     */
    func maskPresentAniamtion(transitionContext:UIViewControllerContextTransitioning){
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey);
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey);
        transitionContext.containerView()?.addSubview(toView!);

        let maskView = self.getMaskView();
        toView?.maskView = maskView;

        UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: {
            maskView.transform = CGAffineTransformScale((maskView.transform), 20, 20);
        }) { (finish) in
            toView?.maskView = nil;
            transitionContext.completeTransition(true);
        };
    }

    func maskDismissAniamtion(transitionContext : UIViewControllerContextTransitioning){
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey);
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey);

        transitionContext.containerView()?.addSubview(toView!);
        transitionContext.containerView()?.addSubview(fromView!);

        let maskView = self.getMaskView()
        maskView.transform = CGAffineTransformScale(maskView.transform, 20, 20);

        fromView?.maskView = maskView;
        UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: {
            maskView.transform = CGAffineTransformIdentity;
            }) { (finish) in
                fromView?.maskView = nil;
                transitionContext.completeTransition(true);
        };
    }

    func getMaskView() -> UIView!{
        let maskView = UIView();
        maskView.width = 50;
        maskView.height = 50;
        maskView.center = location!;
        maskView.layer.cornerRadius = maskView.height / 2;
        maskView.layer.masksToBounds = true;
        maskView.backgroundColor = UIColor.redColor();  //maskview必须设置一个颜色  否则默认透明  看不到动画效果
        return maskView;
    }
}


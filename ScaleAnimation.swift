//
//  ScaleAnimation.swift
//  Animation-Week4
//
//  Created by GM on 16/8/16.
//  Copyright © 2016年 LGM. All rights reserved.
//

import UIKit
class ScaleAnimation: UIView {


    var circleArr : [UIView]?
    let duration : NSTimeInterval = 1
    let delayTime : CFTimeInterval = 0.25;


    init(frame : CGRect, circleCount count : Int){
        super.init(frame:frame)
        circleArr = []
        self.setupUI(count);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(count : Int){
        let space : CGFloat = 5
        let circleWid = (self.width - CGFloat(count + 1) * 4) / 3

        for(var i = 0; i < count; i = i+1){
            let circleView = UIView()
            circleView.frame = CGRectMake(space * CGFloat(1 + i) + circleWid * CGFloat(i), 0, circleWid, circleWid)
            circleView.centerY = self.height / 2
            circleView.backgroundColor = UIColor.redColor()
            circleView.layer.cornerRadius = circleWid / 2
            circleView.layer.masksToBounds = true
            self.addSubview(circleView)

            circleArr?.append(circleView)
        }
    }

    func circleViewAnimation(index : Int) -> CAAnimation{
        let animationGroup = CAAnimationGroup()

        let scaleAniamtion = CAKeyframeAnimation(keyPath : "transform.scale")
        scaleAniamtion.repeatCount = Float.infinity
        scaleAniamtion.duration = duration
        scaleAniamtion.values = [0,1,0]
        scaleAniamtion.keyTimes = [0 ,0.5 ,1]           //keyTimes 里面值的范围是[0,1]  也就是说是一个比例值
        scaleAniamtion.removedOnCompletion = false
        scaleAniamtion.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        scaleAniamtion.fillMode = kCAFillModeForwards

        let alphaAniamtion = CAKeyframeAnimation(keyPath : "opacity")
        alphaAniamtion.repeatCount = Float.infinity
        alphaAniamtion.duration = duration
        alphaAniamtion.values   = [0,1,0]
        alphaAniamtion.keyTimes = [0,0.5,1];
        alphaAniamtion.removedOnCompletion = false
        alphaAniamtion.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        alphaAniamtion.fillMode = kCAFillModeForwards

        animationGroup.animations = [scaleAniamtion,alphaAniamtion];
        animationGroup.duration = duration;
        animationGroup.removedOnCompletion = false
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        animationGroup.beginTime = delayTime * CFTimeInterval(index)
        animationGroup.repeatCount = Float.infinity
        return animationGroup;
    }

    func startAniamtion(){

        for(var index = 0; index < self.circleArr?.count; index = index + 1){
            let view = self.circleArr![index]
            let animation = self.circleViewAnimation(index)
            view.layer.addAnimation(animation, forKey: "animation")
        }
    }

    func stopAniamtion(){
        for view in circleArr!{
            view.layer.removeAllAnimations()
        }
    }
}

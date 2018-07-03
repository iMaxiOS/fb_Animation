//
//  ViewController.swift
//  LikeAnimation_Facebook
//
//  Created by iMaxiOS on 7/3/18.
//  Copyright © 2018 Maxim Granchenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let bgImageView: UIImageView = {
       let bg = UIImageView(image: #imageLiteral(resourceName: "paris"))
        return bg
    }()
    
    let viewConteiners: UIView = {
       let containers = UIView()
        containers.backgroundColor = .red
        containers.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        return containers
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bgImageView)
        bgImageView.frame = view.frame
        view.clipsToBounds = true
        
        setupGestureRecognizer()
        
    }
    
    fileprivate func setupGestureRecognizer() {
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(gestureRecognizer)))
        
    }
    
    @objc func gestureRecognizer(gesture: UILongPressGestureRecognizer) {
//        print("Long pressed:", Date())
        
        if gesture.state == .began {
            gestureBegan(gesture: gesture)
        } else if gesture.state == .ended {
            viewConteiners.removeFromSuperview()
        }
    }
    
    fileprivate func gestureBegan(gesture: UILongPressGestureRecognizer) {
        view.addSubview(viewConteiners)
        
        let pressLocation = gesture.location(in: self.view)
        print(pressLocation)
        
        //transformation of the red box
        let centerX = (view.frame.width - viewConteiners.frame.width) / 2
        viewConteiners.transform = CGAffineTransform(translationX: centerX, y: pressLocation.y)
        
        //alpha
        viewConteiners.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.viewConteiners.transform = CGAffineTransform(translationX: centerX, y: pressLocation.y - self.viewConteiners.frame.height)
            self.viewConteiners.alpha = 1
            
        })
    }
    
}


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
    
    let iconContainerView: UIView = {
       let containers = UIView()
        containers.backgroundColor = .white
        
        let redView = UIView()
        redView.backgroundColor = .red
        let blueView = UIView()
        blueView.backgroundColor = .blue
        let yellowView = UIView()
        yellowView.backgroundColor = .yellow
                
        let arrangedSubviews = [redView, blueView]
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.distribution = .fillEqually
        
        //configuration options
        let iconHeight: CGFloat = 50
        let padding: CGFloat = 8
        
        stackView.spacing = padding
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        containers.addSubview(stackView)
        
        containers.frame = CGRect(x: 0, y: 0, width: 200, height: iconHeight + 2 * padding)
        stackView.frame = containers.frame
        
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
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(HandleLongPress)))
        
    }
    
    @objc func HandleLongPress(gesture: UILongPressGestureRecognizer) {
//        print("Long pressed:", Date())

        if gesture.state == .began {
            HandleGestureBegan(gesture: gesture)
        } else if gesture.state == .ended {
            iconContainerView.removeFromSuperview()
        }
    }
    
    fileprivate func HandleGestureBegan(gesture: UILongPressGestureRecognizer) {
        view.addSubview(iconContainerView)
        
        let pressLocation = gesture.location(in: self.view)
        print(pressLocation)
        
        //transformation of the red box
        let centerX = (view.frame.width - iconContainerView.frame.width) / 2
        
        //alpha
        iconContainerView.alpha = 0
        self.iconContainerView.transform = CGAffineTransform(translationX: centerX, y: pressLocation.y)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.iconContainerView.transform = CGAffineTransform(translationX: centerX, y: pressLocation.y - self.iconContainerView.frame.height)
            self.iconContainerView.alpha = 1
            
        })
    }
    
}


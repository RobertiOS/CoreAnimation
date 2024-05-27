//
//  SpringAnimationViewController.swift
//  CoreAnimation
//
//  Created by Roberto Corrales on 3/12/24.
//

import UIKit

class SpringAnimationViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton(
            frame: .init(
                origin: .init(
                    x: view.center.x,
                    y: view.center.y
                ),
                size: .init(
                    width: 100,
                    height: 30
                )
            )
        )
        let action =  UIAction { [weak self] _ in self?.startSpringAnimation() }
        button.backgroundColor = .red
        button.setTitle("Tap me", for: .normal)
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    //2
    
    private func startSpringAnimation() {
        let springAnimation = CASpringAnimation(keyPath: "position.y")
        springAnimation.fromValue = view.center.y - 10
        springAnimation.toValue = view.center.y
        springAnimation.duration = 2
        springAnimation.damping = 11
        springAnimation.mass = 1
        springAnimation.initialVelocity = 100
        springAnimation.stiffness = 2500
        button.layer.add(springAnimation, forKey: "basic")
        button.layer.position = .init(x: view.center.x, y: view.center.y)
    }
   
    
    //3
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spring animations"
        view.backgroundColor = .white
        view.addSubview(button)
    }

}

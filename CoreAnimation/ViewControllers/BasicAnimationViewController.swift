//
//  ViewController.swift
//  CoreAnimation
//
//  Created by Roberto Corrales on 2/29/24.
//

import UIKit

class BasicAnimationViewController: UIViewController {
    
    // 1
    private lazy var imageView: UIImageView = {
        var imageView = UIImageView(image: UIImage(systemName: "car.side.fill"))
        imageView.frame = .init(x: view.frame.width, y: view.center.y, width: 100, height: 100)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //2
    private func startBasicAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "position.x")
        basicAnimation.fromValue = view.frame.width
        basicAnimation.toValue = 50
        basicAnimation.duration = 1
        //1
        basicAnimation.repeatCount = Float.infinity
        //2
        basicAnimation.autoreverses = true
        imageView.layer.add(basicAnimation, forKey: "basic")
    }
    
    //3
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Basic Animation"
        view.backgroundColor = .white
        view.addSubview(imageView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startBasicAnimation()
    }
    
}


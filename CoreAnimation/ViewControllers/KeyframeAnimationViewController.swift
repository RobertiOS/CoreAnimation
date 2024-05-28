//
//  KeyframeAnimationViewController.swift
//  CoreAnimation
//
//  Created by Roberto Corrales on 3/13/24.
//

import UIKit

class KeyframeAnimationViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        let action =  UIAction { [weak self] _ in self?.startKeyframeAnimation() }
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.setTitle("Login", for: .normal)
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .gray.withAlphaComponent(0.5)
        textField.text = "12345678"
        textField.textAlignment = .center
        return textField
    }()
    
    //1
    
    private func startKeyframeAnimation() {
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "position.x")
        keyframeAnimation.duration = 0.25
        keyframeAnimation.keyPath = CABasicAnimation.AnimationKeyPath.positionX.rawValue
        keyframeAnimation.values = [0, 10, -10, 10, 0]
        keyframeAnimation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        keyframeAnimation.isAdditive = true
        textField.layer.add(keyframeAnimation, forKey: "basic")
        textField.layer.position = .init(x: view.center.x, y: view.center.y)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Keyframe animation"
        view.backgroundColor = .white
        
        constructSubviewHierarchy()
        constructSubviewConstraints()
        
        view.layoutIfNeeded()
    }
    
    private func constructSubviewHierarchy() {
        view.addSubview(textField)
        view.addSubview(button)
    }
    
    private func constructSubviewConstraints() {
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 40),
            textField.widthAnchor.constraint(equalToConstant: 200),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.centerXAnchor.constraint(equalTo: textField.centerXAnchor),
            
        ])
    }
}

#Preview {
    KeyframeAnimationViewController()
}

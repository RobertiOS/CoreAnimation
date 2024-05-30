//
//  LoginViewController.swift
//  CoreAnimation
//
//  Created by Roberto Corrales on 3/15/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Constants
    
    struct Constants {
        static let primaryColor = UIColor.orange
        static let expandedHeight: CGFloat = 350
        static let colapsedHeight: CGFloat = 280
    }
    
    // MARK: - Views
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 233/255, green: 226/255, blue: 241/255, alpha: 1)
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .init(width: 5, height: 5)
        view.isHidden = true
        return view
    }()
    
    private let userTextField: UITextField = {
        let textField = UITextField()
        textField.withImage(direction: .Left, image: UIImage(systemName: "person.circle.fill")!, colorSeparator: .clear, colorBorder: .clear)
        textField.layer.cornerRadius = 25
        textField.backgroundColor = UIColor(red: 221/255, green: 213/255, blue: 233/255, alpha: 1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "your user name"
        textField.layer.opacity = 0
        return textField
    }()
    
    private let passwordTextfield: UITextField = {
        let textField = UITextField()
        textField.withImage(direction: .Left, image: UIImage(systemName: "lock.circle.fill")!, colorSeparator: .clear, colorBorder: .clear)
        textField.layer.cornerRadius = 25
        textField.backgroundColor = UIColor(red: 221/255, green: 213/255, blue: 233/255, alpha: 1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "your password"
        textField.isSecureTextEntry = true
        textField.layer.opacity = 0
        return textField
    }()
    
    private let confirmPasswordTextfield: UITextField = {
        let textField = UITextField()
        textField.withImage(direction: .Left, image: UIImage(systemName: "lock.circle.fill")!, colorSeparator: .clear, colorBorder: .clear)
        textField.layer.cornerRadius = 25
        textField.backgroundColor = UIColor(red: 221/255, green: 213/255, blue: 233/255, alpha: 1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "confirm your password"
        textField.isSecureTextEntry = true
        textField.layer.opacity = 1
        return textField
    }()
    
    private let loginButton: UIButton = {
        var configuration =  UIButton.Configuration.filled()
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        configuration.baseBackgroundColor = Constants.primaryColor
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20)
        configuration.cornerStyle = .capsule
        configuration.title = "Log in"
        button.configuration = configuration
        button.transform = CGAffineTransform(scaleX: 0, y: 0)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        var configuration =  UIButton.Configuration.filled()
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = Constants.primaryColor
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20)
        configuration.cornerStyle = .capsule
        configuration.title = "Sign up"
        button.configuration = configuration
        button.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.expandContainerAnimation()
            self?.animateConfirmPassword()
        }), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - constraints
    
    private lazy var containerHeightConstraint = containerView.heightAnchor.constraint(
        equalToConstant: Constants.colapsedHeight
    )
    private lazy var confirmPasswordTrailingConstraint = self.confirmPasswordTextfield.trailingAnchor.constraint(
        equalTo: self.containerView.trailingAnchor,
        constant: -500
    )
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.primaryColor
        constructViewHierarchy()
        constructSubviewHierarchy()
        constructSubviewConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateContainerView()
    }
    
    // MARK: - view construction
    
    private func constructViewHierarchy() {
        view.addSubview(containerView)
    }
    
    private func constructSubviewHierarchy() {
        containerView.addSubview(userTextField)
        containerView.addSubview(passwordTextfield)
        containerView.addSubview(loginButton)
        containerView.addSubview(signUpButton)
    }
    
    private func constructSubviewConstraints() {
        NSLayoutConstraint.activate([
            containerHeightConstraint,
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            
            userTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            userTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            userTextField.widthAnchor.constraint(lessThanOrEqualToConstant: 50),
            userTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextfield.topAnchor.constraint(equalTo: userTextField.bottomAnchor, constant: 20),
            passwordTextfield.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            passwordTextfield.widthAnchor.constraint(lessThanOrEqualToConstant: 50),
            passwordTextfield.heightAnchor.constraint(equalToConstant: 50),
            
            signUpButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            signUpButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            loginButton.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -10),
            loginButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
    
    // MARK: - animations
    
    private func animateContainerView() {
        let transition = CATransition()
        transition.type = .init(rawValue: "oglFlip")
        transition.subtype = .fromBottom
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.delegate = self
        containerView.isHidden = false
        containerView.layer.add(transition, forKey: "container-transition")
    }
    
    private func animateTextFieldLayer(layer: CALayer?) {
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2.0
        
        userTextField.frame.size = .init(width: 50, height: 50)
        passwordTextfield.frame.size = .init(width: 50, height: 50)
        
        let animation = CABasicAnimation(keyPath: .boundsSizeWidth)
        animation.fromValue = 50
        animation.toValue = 200
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let opacityAnimation = CABasicAnimation(keyPath: .opacity)
        opacityAnimation.duration = 2
        opacityAnimation.fromValue = 0.0
        opacityAnimation.toValue = 1.0
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        opacityAnimation.fillMode = .forwards
        opacityAnimation.isRemovedOnCompletion = false

        animationGroup.animations = [opacityAnimation]
        animationGroup.fillMode = .forwards
        animationGroup.isRemovedOnCompletion = false
        userTextField.layer.add(opacityAnimation, forKey: "widthAnimation")
        passwordTextfield.layer.add(animationGroup, forKey: "widthAnimation")
    
    }
    
    private func animateTrailingConstraintsOnTextFields() {
        [userTextField, passwordTextfield].forEach {
            $0.trailingAnchor.constraint(
                equalTo: self.containerView.trailingAnchor,
                constant: -20
            ).isActive = true
        }
        
        UIView.animate(withDuration: 1.0, delay: 1) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    private func animateButton() {
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = 0
        scaleAnim.toValue = 1
        scaleAnim.duration = 0.5
        scaleAnim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        let opacityAnim = CABasicAnimation(keyPath: "opacity")
        opacityAnim.fromValue = 0
        opacityAnim.toValue = 1
        opacityAnim.duration = 0.5
        opacityAnim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        loginButton.layer.add(scaleAnim, forKey: "scale")
        loginButton.layer.add(opacityAnim, forKey: "opacity")
        loginButton.transform = .identity
        loginButton.alpha = 1
        
        signUpButton.layer.add(scaleAnim, forKey: "scale")
        signUpButton.layer.add(opacityAnim, forKey: "opacity")
        signUpButton.transform = .identity
        signUpButton.alpha = 1
    }
    
    private func expandContainerAnimation() {
        let value = self.containerHeightConstraint.constant == Constants.colapsedHeight ? Constants.expandedHeight : Constants.colapsedHeight
        
        let collapsed = value == Constants.colapsedHeight
        let delay: TimeInterval = collapsed ? 1 : 0
        self.containerHeightConstraint.constant = value
        UIView.animate(
            withDuration: 1,
            delay: delay,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 10,
            options: .curveEaseInOut
        ) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        
    }
    
    
    private func animateConfirmPassword() {
        if confirmPasswordTextfield.superview == nil {
            containerView.addSubview(confirmPasswordTextfield)
            NSLayoutConstraint.activate([
                confirmPasswordTextfield.heightAnchor.constraint(equalToConstant: 50),
                confirmPasswordTextfield.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 20),
                confirmPasswordTrailingConstraint
                
            ])
            
            self.view.layoutIfNeeded()
            self.confirmPasswordTextfield.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 20).isActive = true
            confirmPasswordTrailingConstraint.constant = -20
            confirmPasswordTrailingConstraint.isActive = true
            
            UIView.animate(
                withDuration: 1,
                delay: 0.4,
                usingSpringWithDamping: 0.5,
                initialSpringVelocity: 10
            ) {
                self.view.layoutIfNeeded()
            }
        } else {
            self.confirmPasswordTrailingConstraint.constant = -500
            UIView.animate(
                withDuration: 1,
                delay: 0,
                usingSpringWithDamping: 0.5,
                initialSpringVelocity: 10
            ) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.confirmPasswordTextfield.removeFromSuperview()
            }
            
        }
    }

}

extension LoginViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        animateTextFieldLayer(layer: nil)
        animateTrailingConstraintsOnTextFields()
        animateButton()
    }
}

#Preview {
    LoginViewController()
}


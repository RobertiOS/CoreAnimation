//
//  AnimationsTableViewController.swift
//  CoreAnimation
//
//  Created by Roberto Corrales on 3/12/24.
//

import UIKit

final class AnimationsTableViewController: UITableViewController {
    
    enum Animations: String, CaseIterable {
        case basicAnimation
        case springAnimation
        case particles
        case keyframeAnimations
        case loginAnimationExample
        
        var viewController: UIViewController {
            switch self {
            case .basicAnimation:
                return BasicAnimationViewController()
            case .springAnimation:
                return SpringAnimationViewController()
            case .particles:
                return UIViewController()
            case .keyframeAnimations:
                return KeyframeAnimationViewController()
            case .loginAnimationExample:
                return LoginViewController()
            }
        }
        
        var title: String {
            switch self {
            case .basicAnimation:
                "Basic Animation"
            case .springAnimation:
                "Spring Animation"
            case .particles:
                "Particles Animation"
            case .keyframeAnimations:
                "Keyframe Animation"
            case .loginAnimationExample:
                "Login Animation Example"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animations"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reusableCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Animations.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath)
        var contentConfiguration = UIListContentConfiguration.cell()
        contentConfiguration.text = Animations.allCases[indexPath.row].title
        cell.accessoryView = UIImageView(image: UIImage(systemName: "chevron.forward"))
        cell.contentConfiguration = contentConfiguration
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = Animations.allCases[indexPath.row].viewController
        navigationController?.pushViewController(viewController, animated: true)
    }

}

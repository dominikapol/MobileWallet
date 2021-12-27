//
//  RootViewController.swift
//  MobileWallet
//
//  Created by Dominika Poleshyck on 11.11.21.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        DatabaseService.shared.entitiesFor(
            type: Intelligence.self,
            context: DatabaseService.shared.persistentContainer.mainContext) { intelligences in
                DispatchQueue.main.async {
                    if intelligences.isEmpty {
                        let registrationVC = StoryboardScene.Registration.registrationViewController.instantiate()
                        self.navigationController?.pushViewController(registrationVC, animated: false)
                    } else {
                        let tabBarController = TabBarController()
                        self.navigationController?.pushViewController(tabBarController, animated: false)
                    }
                }
            }
    }
}

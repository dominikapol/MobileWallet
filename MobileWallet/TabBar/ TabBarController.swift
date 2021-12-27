//
//  TabBarController.swift
//  MobileWallet
//
//  Created by Dominika Poleshyck on 6.12.21.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        let storyboard = UIStoryboard(name: "MoneyDay", bundle: Bundle.main)
        guard let moneyDay = storyboard.instantiateViewController(identifier: "MoneyDayViewController") as? MoneyDayViewController else {
            return
        }
        
        tabBar.barTintColor = UIColor(named: "customCreamTabBar")
        tabBar.tintColor = UIColor(named: "customBlue")
        tabBar.unselectedItemTintColor = UIColor(named: "customPeach")
        
        viewControllers = [
            createNavController(
                for:  StoryboardScene.PiggyBank.piggyBankViewController.instantiate(),
                   title: "PiggyBank",
                   image: Asset.piggyBankTabBar.image,
                   selectedImage:  Asset.piggyBankTabBar.image
            ),
            createNavController(
                for: StoryboardScene.MajorScreen.majorScreenViewController.instantiate(),
                   title: "Major",
                   image: Asset.tab.image,
                   selectedImage: Asset.tab.image),
            createNavController(
                for: moneyDay,
                   title: "MoneyDay",
                   image: Asset.moneyDayTabBar.image,
                   selectedImage: Asset.moneyDayTabBar.image)
        ]
    }
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage,
                                     selectedImage: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = selectedImage
        navController.navigationBar.prefersLargeTitles = false
        rootViewController.navigationItem.title = title
        return navController
    }
}

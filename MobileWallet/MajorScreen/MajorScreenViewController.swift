//
//  MajorScreenViewController.swift
//  MobileWallet
//
//  Created Dominika Poleshyck on 9.11.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import Alamofire


// MARK: View -
protocol MajorScreenViewProtocol: AnyObject {
    func updateButtonsProgress(firstRingProgress: Double, secondRingProgress: Double, thirdRingProgress: Double)
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool
    func reloadData()
}

class MajorScreenViewController: UIViewController {
    @IBOutlet var groupContainerView: UIView!
    @IBOutlet var progressGroup: RingProgressGroupView!
    @IBOutlet var iconsHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: MajorScreenPresenterProtocol = MajorScreenPresenter()
    var registrationView: RegistrationViewController?
    var selectedIndex = 0
    let tabbarVC = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        presenter.view = self
        presenter.viewDidLoad()
        tabbarVC.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CellOfExchangeRate", bundle: Bundle.main), forCellReuseIdentifier: "CellOfExchangeRate")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        iconsHeightConstraint.constant = progressGroup.ringWidth * 3 + progressGroup.ringSpacing * 2
    }
}

extension MajorScreenViewController: MajorScreenViewProtocol {
    func updateButtonsProgress(firstRingProgress: Double, secondRingProgress: Double, thirdRingProgress: Double) {
        self.progressGroup.ring1.progress = firstRingProgress
        self.progressGroup.ring2.progress = secondRingProgress
        self.progressGroup.ring3.progress = thirdRingProgress
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

extension MajorScreenViewController: UITabBarControllerDelegate {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}

extension MajorScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCurrency()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellOfExchangeRate", for: indexPath) as? CellOfExchangeRate else { return UITableViewCell() }
        cell.updateCell(with: presenter.currency(for: indexPath) ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}



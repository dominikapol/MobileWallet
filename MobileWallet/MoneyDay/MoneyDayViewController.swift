//
//  MoneyDayViewController.swift
//  MobileWallet
//
//  Created Dominika Poleshyck on 4.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import FSCalendar

// MARK: View -
protocol MoneyDayViewProtocol: AnyObject {
    func setConstraints()
    func reloadTableView()
    func addElementToTableView(to indexPath: IndexPath)
    func removeElementFromTableView(to indexPath: IndexPath)
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool
}

class MoneyDayViewController: UIViewController {
    
    var presenter: MoneyDayPresenterProtocol = MoneyDayPresenter()
    var calendarHightConstraint: NSLayoutConstraint!
    let tabbarVC = UITabBarController()
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    let showHideButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open calendar", for: .normal)
        button.setTitleColor(UIColor(named: "customBlue"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Limelight", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "customCream")
        button.layer.cornerRadius = CGFloat(5)
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let idForTableView = "idForTableView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "customWhiteCream")
        presenter.view = self
        presenter.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellForTableView.self, forCellReuseIdentifier: idForTableView)
        tableView.backgroundColor = UIColor(named: "customWhiteCream")
        tabbarVC.delegate = self
        calendar.scope = .week
        setConstraints()
        swipeAction()
        showHideButton.addTarget(self, action: #selector(showHideButtonTaped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }
    
    @objc func showHideButtonTaped() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHideButton.setTitle("Close calendar", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHideButton.setTitle("Open calendar", for: .normal)
        }
    }
    
    @objc func addButtonPressed() {
        let optionScreen = Options()
        navigationController?.pushViewController(optionScreen, animated: true)
        
    }
    
    func swipeAction() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipedown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipedown.direction = .down
        calendar.addGestureRecognizer(swipedown)
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up:
            showHideButtonTaped()
        case .down:
            showHideButtonTaped()
        default:
            break
        }
    }
}

extension MoneyDayViewController: MoneyDayViewProtocol {
    func setConstraints() {
        view.addSubview(calendar)
        calendarHightConstraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(calendarHightConstraint)
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        view.addSubview(showHideButton)
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            showHideButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            showHideButton.widthAnchor.constraint(equalToConstant: 200),
            showHideButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: showHideButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    func addElementToTableView(to indexPath: IndexPath) {
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func removeElementFromTableView(to indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

extension MoneyDayViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
}

extension MoneyDayViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfElementsInTextArray()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idForTableView, for: indexPath) as? CellForTableView else { return UITableViewCell() }
        cell.typeOfAmountLabel.text = presenter.elementInTextArray(for: indexPath).type
        cell.recipientsAccount.text = presenter.elementInTextArray(for: indexPath).recipientsAccount
        cell.dateLabel.text = presenter.elementInTextArray(for: indexPath).date
        cell.amountLabel.text = presenter.elementInTextArray(for: indexPath).amountOfSpent
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let configuation = UISwipeActionsConfiguration(actions: [UIContextualAction(
            style: .destructive,
            title: "Delete",
            handler: { _, _, _ in
                
            }
        )
    ]
)
        return configuation
    }
    
}

extension MoneyDayViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}



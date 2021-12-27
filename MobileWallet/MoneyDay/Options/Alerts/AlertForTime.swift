//
//  AlertDate.swift
//  MobileWallet
//
//  Created by Dominika Poleshyck on 12.12.21.
//

import UIKit

extension UIViewController {
    func alertTime(label: UILabel, completionHandler: @escaping (NSDate) -> Void) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        alert.view.addSubview(datePicker)
        let okAlertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "HH:mm"
            let timeString = dateFormater.string(from: datePicker.date)
            let timeSchedule = datePicker.date as NSDate
            completionHandler(timeSchedule)
            label.text = timeString
        }
        let cancelAlert = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(cancelAlert)
        alert.addAction(okAlertAction)
        
        alert.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.widthAnchor.constraint(equalTo: alert.view.widthAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 160).isActive = true
        datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20).isActive = true
        
        present(alert, animated: true, completion: nil)
    }
}

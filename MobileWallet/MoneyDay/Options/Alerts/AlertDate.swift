//
//  AlertDate.swift
//  MobileWallet
//
//  Created by Dominika Poleshyck on 12.12.21.
//

import UIKit

extension UIViewController {
    func alertDate(label: UILabel, completionHandler: @escaping (Int, NSDate) -> Void) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = NSLocale(localeIdentifier: "Ru_ru") as Locale
        alert.view.addSubview(datePicker)
        
        let okAlertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd.MM.yyyy"
            let dateString = dateFormater.string(from: datePicker.date)
            let calendar = Calendar.current
            let component = calendar.dateComponents([.month], from: datePicker.date)
            guard let monthDay = component.month else { return }
            let numberWeekDay = monthDay
            let date = datePicker.date as NSDate
            completionHandler(numberWeekDay, date)
            
            label.text = dateString
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

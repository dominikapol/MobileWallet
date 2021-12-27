//
//  AlertForType.swift
//  MobileWallet
//
//  Created by Dominika Poleshyck on 13.12.21.
//

import UIKit

extension UIViewController {
    func alertForType(label: UILabel, name: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            let alertTF = alert.textFields?.first
            guard let text = alertTF?.text else { return }
            label.text = text
            completionHandler(text)
        }
        alert.addTextField { (alertTF) in
            alertTF.placeholder = placeholder
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}


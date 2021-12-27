//
//  RegistrationViewController.swift
//  MobileWallet
//
//  Created Dominika Poleshyck on 9.11.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
// MARK: View -
protocol RegistrationViewProtocol: AnyObject {
    func downloadPickedView(photo: Data)
    func showNextScreen()
    func showAlert()
}

class RegistrationViewController: UIViewController {
    
    
    private let pickerView = UIPickerView()
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var earningsTextField: UITextField!
    @IBOutlet private weak var nameOfDreamTextField: UITextField!
    @IBOutlet private weak var priceOfDreamTextField: UITextField!
    @IBOutlet private weak var countOfMonthsTextField: UITextField!
    @IBOutlet private weak var pickedImageView: UIImageView!
    
    
    var presenter: RegistrationPresenterProtocol = RegistrationPresenter()
    let weeksArray: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.view = self
        presenter.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        countOfMonthsTextField.inputView = pickerView
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func pickThePhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction private func nameTextFieldDidChange() {
        let name = nameTextField.text ?? ""
        presenter.changeName(name: name)
    }
    
    @IBAction private func earningsTextFieldDidChanged() {
        let earning = earningsTextField.text ?? ""
        guard let earningInt = Int(earning) else { return }
        presenter.insertSalary(salary: earningInt)
    }
    
    @IBAction private func nameOfDreamTextFieldDidChanged() {
        let nameOfTheDream = nameOfDreamTextField.text ?? ""
        presenter.insertNameOfTheDream(nameOfTheDream: nameOfTheDream)
    }
    
    @IBAction private func priceOfDreamTextFieldDidChanged() {
        let priceOfTheDream = priceOfDreamTextField.text ?? ""
        guard let priceOfTheDreamInt = Int(priceOfTheDream)  else { return }
        presenter.insertCostOfTheDream(cost: priceOfTheDreamInt)
    }
    
    @IBAction private func countOfMonthsTextFieldDidChanged() {
        
    }
    
    @IBAction func saveButtonPressed() {
        presenter.save()
    }
}

extension RegistrationViewController: RegistrationViewProtocol {
    func showNextScreen() {
        let tabBarController = TabBarController()
        navigationController?.pushViewController(tabBarController, animated: true)
    }

    func showAlert() {
        let alert = UIAlertController(title: "Please!", message: "Fill in the missing cells", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func downloadPickedView(photo: Data) {
        guard let choosenPhoto = UIImage(data: photo) else { return }
        pickedImageView.image = choosenPhoto
    }
}

extension RegistrationViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        guard let pickedImage = image.pngData() else { return }
        presenter.addPhoto(new: pickedImage)
    }
}

extension RegistrationViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weeksArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countOfMonthsTextField.text = weeksArray[row]
        countOfMonthsTextField.resignFirstResponder()
        let countOfMonths = countOfMonthsTextField.text ?? ""
        guard let countOfMonthsInt = Int(countOfMonths) else { return }
        presenter.insertCountOfMounth(months: countOfMonthsInt)
    }
}

extension RegistrationViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weeksArray.count
    }
}


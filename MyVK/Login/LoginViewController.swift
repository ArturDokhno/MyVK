//
//  ViewController.swift
//  2l_ArturDokhno
//
//  Created by Артур Дохно on 15.08.2021.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    
    let transitionManager = CustomTransition ()
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    @IBAction func someButton(_ sender: Any) {
        loadFromCoreData()
    }
    
    @IBAction func loginScrean(unwindSegue: UIStoryboardSegue) {
        loginTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        saveToCoreData()
        
        if isValid() {
            print("Login")
            performSegue(
                withIdentifier: "loginSegue",
                sender: nil)
        } else {
            showAlert()
        }
    }
    
    // MARK: CoreData
    
    private func  saveToCoreData() {
        guard let currentContex = appDelegate?.persistenContainer.viewContext else { return }
        let user = UserCoreData(context: currentContex)
        user.id = UUID()
        user.name = loginTextField.text
        user.password = passwordTextField.text
        try? currentContex.save()
    }
    
    private func loadFromCoreData() {
        guard let currentContex = appDelegate?.persistenContainer.viewContext else { return }
        do {
            let users = try currentContex.fetch(UserCoreData.fetchRequest())
            print(users)
        } catch {
            let nsError = error as NSError
            print("Error with \(nsError.userInfo)")
        }
    }
    
    private func showAlert() {
        let alertController = UIAlertController(
            title: "Error",
            message: "Incorrect login or password",
            preferredStyle: .alert)
        let alertItem = UIAlertAction(
            title: "Close",
            style: .cancel)
        { _ in
            self.loginTextField.text = ""
            self.passwordTextField.text = ""
        }
        alertController.addAction(alertItem)
        present(alertController,
                animated: true,
                completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentContex = appDelegate?.persistenContainer.viewContext { currentContex.reset() }
        
        scrollView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard)))
        
        let radius = 15
        loginTextField.layer.cornerRadius = CGFloat(radius)
        passwordTextField.layer.cornerRadius = CGFloat(radius)
        loginButton.layer.cornerRadius = CGFloat(radius)
        
        animateFieldsAppearing()
        animateTitlesAppearing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.transitioningDelegate = transitionManager
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWasShown),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillBeHidden(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (
            info.value(
                forKey: UIResponder.keyboardFrameEndUserInfoKey)
            as! NSValue)
            .cgRectValue
            .size
        let contentInserts = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: kbSize.height,
            right: 0.0)
        
        scrollView.contentInset = contentInserts
        scrollView.scrollIndicatorInsets = contentInserts
        UIView.animate(withDuration: 1) {
            self.scrollView.constraints
                .first(where: { $0.identifier == "keyboardShown" })?
                .priority = .required
            self.scrollView.constraints
                .first(where: { $0.identifier == "keyboardHide" })?
                .priority = .defaultHigh
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        UIView.animate(withDuration: 1) {
            self.scrollView.constraints
                .first(where: { $0.identifier == "keyboardShown" })?
                .priority = .defaultHigh
            self.scrollView.constraints
                .first(where: { $0.identifier == "keyboardHide" })?
                .priority = .required
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    func isValid() -> Bool {
        loginTextField.text == "" && passwordTextField.text == ""
    }
    
    func animateFieldsAppearing() {
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        fadeInAnimation.duration = 0.3
        fadeInAnimation.beginTime = CACurrentMediaTime() + 1
        fadeInAnimation.timingFunction = CAMediaTimingFunction(
            name: CAMediaTimingFunctionName.easeOut)
        fadeInAnimation.fillMode = CAMediaTimingFillMode.backwards
        
        self.loginButton.layer.add(fadeInAnimation, forKey: nil)
    }
    
    func animateTitlesAppearing() {
        let offset = view.bounds.width
        loginTextField.transform = CGAffineTransform(
            translationX: -offset, y: 0)
        passwordTextField.transform = CGAffineTransform(
            translationX: offset, y: 0)
        
        UIView.animate(withDuration: 0.3,
                       delay: 1,
                       options: .curveEaseOut,
                       animations: {
            self.loginTextField.transform = .identity
            self.passwordTextField.transform = .identity
        },
                       completion: nil)
    }
}


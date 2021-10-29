//
//  ViewController.swift
//  2l_ArturDokhno
//
//  Created by Артур Дохно on 15.08.2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    
    private var handler: AuthStateDidChangeListenerHandle?
    private let transitionManager = CustomTransition ()
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    @IBAction func loginScrean(unwindSegue: UIStoryboardSegue) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
        
        loginTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func loginAnonymously(_ sender: Any) {
        Auth.auth().signInAnonymously { authResult, error in
            guard (authResult?.user) != nil else { return }
        }
    }
    
    @IBAction func singUp(_ sender: Any) {
        registerUser()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        isValid()
    }
    
    func isValid() {
        guard
            let userName = loginTextField.text,
            let password = passwordTextField.text,
            !userName.isEmpty,
            !password.isEmpty
        else {
            showAlert(
                title: "Неверные данные",
                message: "Проверьте Email или пароль")
            return
        }
        
        Auth.auth().signIn(withEmail: userName,
                           password: password) { [ weak self ] authResult, authError in
            if let error = authError {
                self?.showAlert(title: "Ошибка", message: error.localizedDescription)
            }
        }
    }
    
    private func registerUser() {
        let alertController = UIAlertController(
            title: "Регистрация",
            message: nil,
            preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Email"
        }
        alertController.addTextField { textField in
            textField.isSecureTextEntry = true
            textField.placeholder = "Пароль"
        }
        
        let cancel = UIAlertAction(
            title: "Выход",
            style: .cancel)
        
        let registration = UIAlertAction(
            title: "Регистрация",
            style: .default) { _ in
                guard
                    let emailField = alertController.textFields?[0],
                    let passwordField = alertController.textFields?[1],
                    let email = emailField.text,
                    let password = passwordField.text,
                    !email.isEmpty,
                    !password.isEmpty
                else {
                    self.showAlert(
                        title: "Некоретные данные",
                        message: "Исправте их")
                    return
                }
                
                Auth.auth().createUser(
                    withEmail: email,
                    password: password) { [weak self] authData, authError in
                        if let authError = authError {
                            self?.showAlert(
                                title: "Ошибка",
                                message: authError.localizedDescription)
                        } else {
                            Auth.auth().signIn(withEmail: email, password: password)
                        }
                    }
            }
        alertController.addAction(cancel)
        alertController.addAction(registration)
        
        self.present(alertController, animated: true)
    }
    
    private func showAlert(
        title: String,
        message: String) {
            
            let alertController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert)
            
            let alertItem = UIAlertAction(
                title: "Выйти",
                style: .cancel) { _ in
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
        
        handler = Auth.auth().addStateDidChangeListener { [ weak self ] auth, user in
            if user != nil {
                let navController = UIStoryboard(
                    name: "Main",
                    bundle: nil)
                    .instantiateViewController(withIdentifier: "MainNavController")
                self?.present(navController, animated: true)
            }
        }
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


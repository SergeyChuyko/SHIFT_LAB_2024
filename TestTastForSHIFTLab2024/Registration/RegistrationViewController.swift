//
//  RegistrationViewController.swift
//  TestTastForSHIFTLab2024
//
//  Created by Sergo on 12.02.2024.
//

import UIKit

class RegistrationViewController: UIViewController{

    let viewModel = RegistrationViewModel()

    let firstNameTextField = UITextField.makeTextField(withPlaceholder: "Имя")
    let lastNameTextField = UITextField.makeTextField(withPlaceholder: "Фамилия")
    let dateOfBirthTextField = UITextField.makeTextField(withPlaceholder: "Дата рождения")
    let passwordTextField = UITextField.makeTextField(withPlaceholder: "Пароль")
    let confirmPasswordTextField = UITextField.makeTextField(withPlaceholder: "Подтверждение пароля")

    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Привет!\nЗарегистрируйся чтобы начать"
        label.textAlignment = .center
        label.textColor = UIColor(named: "customDark-color")
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        picker.maximumDate = Date()
        picker.setValue(UIColor.white, forKey: "textColor")
        picker.backgroundColor = UIColor(named: "customDark-color")
        return picker
    }()

    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Регистрация", for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "customDark-color")
        button.tintColor = .white
        button.layer.cornerRadius = 8
        return button
    }()

    lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setDelegatesForTextFields()
        setConstraints()
        addTapGestureToDismissKeyboard()
        setupToolBar()
        configureTextFields()
    }

    private func configureTextFields() {
        firstNameTextField.autocorrectionType = .no
        lastNameTextField.autocorrectionType = .no
        dateOfBirthTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
        confirmPasswordTextField.autocorrectionType = .no
    }

    private func setupUI() {
        self.view.addSubview(firstNameTextField)
        self.view.addSubview(lastNameTextField)
        self.view.addSubview(dateOfBirthTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(confirmPasswordTextField)
        self.view.addSubview(registerButton)
        self.view.addSubview(welcomeLabel)
    }

    private func setDelegatesForTextFields() {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        dateOfBirthTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }

    private func setupToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.barTintColor = UIColor(named: "textFieldBackGround-color")
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonTapped))
        doneButton.tintColor = UIColor(named: "customDark-color")
        toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
        dateOfBirthTextField.inputView = datePicker
        dateOfBirthTextField.inputAccessoryView = toolbar
        dateOfBirthTextField.delegate = self
    }

    private func addTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    private func showAlertForEmptyFields() {
        AlertManager.showAlert(on: self, title: "Ошибка", message: "Все поля должны быть заполнены, включая дату рождения")
    }

    private func showAlertForInvalidData() {
        switch true {
        case firstNameTextField.text!.count < 2:
            AlertManager.showAlert(on: self, title: "Ошибка", message: "Имя должно содержать не менее двух символов")
        case lastNameTextField.text!.count < 2:
            AlertManager.showAlert(on: self, title: "Ошибка", message: "Фамилия должна содержать не менее двух символов")
        case passwordTextField.text != confirmPasswordTextField.text:
            AlertManager.showAlert(on: self, title: "Ошибка", message: "Пароли не совпадают")
        case !(passwordTextField.text!).isValidPassword:
            AlertManager.showAlert(on: self, title: "Ошибка", message: "Пароль должен содержать хотя бы одну большую букву и одну цифру")
        default:
            break
        }
    }

    private func proceedToMainScreen() {
        DispatchQueue.main.async {
            let mainScreenViewModel = MainScreenViewModel()
            let mainVC = MainScreenViewController(viewModel: mainScreenViewModel)
            mainVC.modalPresentationStyle = .fullScreen
            self.present(mainVC, animated: true)
            self.viewModel.saveRegistrationDataLocally()
        }
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),

            firstNameTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 32),
            firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 56),

            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 12),
            lastNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 56),

            dateOfBirthTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 12),
            dateOfBirthTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            dateOfBirthTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            dateOfBirthTextField.heightAnchor.constraint(equalToConstant: 56),

            passwordTextField.topAnchor.constraint(equalTo: dateOfBirthTextField.bottomAnchor, constant: 12),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),

            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 12),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 56),

            registerButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 30),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            registerButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func doneButtonTapped() {
        view.endEditing(true)
        passwordTextField.becomeFirstResponder()
    }

    @objc private func datePickerValueChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateOfBirthTextField.text = dateFormatter.string(from: datePicker.date)
    }

    @objc func registerButtonTapped() {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty,
              let lastName = lastNameTextField.text, !lastName.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty,
              let dob = dateOfBirthTextField.text, !dob.isEmpty else {
            showAlertForEmptyFields()
            return
        }
        viewModel.registrationData.firstName = firstName
        viewModel.registrationData.lastName = lastName
        viewModel.registrationData.password = password
        viewModel.registrationData.confirmPassword = confirmPassword

        guard viewModel.validateRegistrationData() else {
            showAlertForInvalidData()
            return
        }
        proceedToMainScreen()
    }
}

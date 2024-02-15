//
//  MainScreenViewController.swift
//  TestTastForSHIFTLab2024
//
//  Created by Sergo on 13.02.2024.
//

import UIKit

class MainScreenViewController: UIViewController {

    let viewModel: MainScreenViewModel

    init(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "textFieldBackGround-color")
        tableView.layer.borderColor = UIColor(named: "border-color")?.cgColor
        tableView.layer.borderWidth = 4
        tableView.layer.cornerRadius = 8
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = UIColor(named: "customGray-color")
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()

    lazy var greetingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Приветствие", for: .normal)
        button.addTarget(self, action: #selector(greetingButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "primary-color")
        button.tintColor = .white
        button.layer.cornerRadius = 8
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setConstraints()
        startLoadingData()
    }

    private func startLoadingData() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()

        viewModel.fetchProducts { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
            }
        }
    }

    func setupUI() {
        view.addSubview(tableView)
        view.addSubview(greetingButton)
        view.addSubview(activityIndicator)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 22),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -22),
            tableView.bottomAnchor.constraint(equalTo: greetingButton.topAnchor, constant: -20),

            greetingButton.heightAnchor.constraint(equalToConstant: 56),
            greetingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            greetingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            greetingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),

            activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),

        ])
    }

    @objc func greetingButtonTapped() {
        let defaults = UserDefaults.standard
        guard let firstName = defaults.string(forKey: "firstName") else {
            AlertManager.showAlert(on: self, title: "Ошибка", message: "Имя не найдено")
            return
        }
        AlertManager.showAlert(on: self, title: "Приветствую, \(firstName)", message: "")
    }
}

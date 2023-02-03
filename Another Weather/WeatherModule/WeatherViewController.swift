//
//  ViewController.swift
//  Another Weather
//
//  Created by Konstantin Grachev on 03.02.2023.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    private let weatherManager = WeatherManager()
    
    private let backgroundView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "background"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "10ºC"
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Moscow"
        return label
    }()
    
    private lazy var searchLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.addTarget(self, action: #selector(searchLocationButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var autoDefineLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "location.north.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(autoDefineLocationButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let searchLocationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.borderStyle = .roundedRect
        textField.alpha = 0.5
        textField.backgroundColor = .systemGray
        textField.textAlignment = .right
        textField.autocapitalizationType = .words
        textField.returnKeyType = .go
        return textField
    }()
    
    private lazy var topSearchLocationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [autoDefineLocationButton,
                                                       searchLocationTextField,
                                                       searchLocationButton])
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setupUI()
    }
    
    @objc private func searchLocationButtonPressed() {
        print(searchLocationTextField.text)
        hideKeyboard()
    }
    
    @objc private func autoDefineLocationButtonPressed() {
        print(#function)
    }

    private func setDelegates() {
        searchLocationTextField.delegate = self
    }
    
    private func setupUI() {
        let subviews = [backgroundView,
                        temperatureLabel,
                        cityLabel,
                        weatherImageView,
                        topSearchLocationStackView]
        
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            topSearchLocationStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topSearchLocationStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            topSearchLocationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

}

extension WeatherViewController: UITextFieldDelegate {
    
    private func hideKeyboard() {
        searchLocationTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text)
        hideKeyboard()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let city = textField.text else { return }
        weatherManager.fetchWeatherData(for: city)
        textField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        textField.placeholder = "Type smth"
            return false
    }
}


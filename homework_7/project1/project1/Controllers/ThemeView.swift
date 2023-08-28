//
//  ThemeView.swift
//  project1
//
//  Created by Алекс Фитнес on 25.08.2023.
//

import UIKit
protocol ThemeViewDelegate: AnyObject {
    func updateColor()
}

final class ThemeView: UIView {
    weak var delegate: ThemeViewDelegate?
    private var whiteButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = WhiteTheme().backgroundColor
        return button
    }()
    
    private var blueButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = BlueTheme().backgroundColor
        return button
    }()
    
    private var greenButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = GreenTheme().backgroundColor
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Theme.currentTheme.backgroundColor
        whiteButton.addTarget(self, action: #selector(tap1), for: .touchUpInside)
        blueButton.addTarget(self, action: #selector(tap2), for: .touchUpInside)
        greenButton.addTarget(self, action: #selector(tap3), for: .touchUpInside)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(whiteButton)
        addSubview(blueButton)
        addSubview(greenButton)
        setupConstraints()
    }
    private func setupConstraints() {
        whiteButton.translatesAutoresizingMaskIntoConstraints = false
        blueButton.translatesAutoresizingMaskIntoConstraints = false
        greenButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            whiteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            whiteButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            whiteButton.leftAnchor.constraint(equalTo: leftAnchor),
            whiteButton.rightAnchor.constraint(equalTo: rightAnchor),
            
            blueButton.bottomAnchor.constraint(equalTo: whiteButton.topAnchor, constant: -20),
            blueButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            blueButton.leftAnchor.constraint(equalTo: leftAnchor),
            blueButton.rightAnchor.constraint(equalTo: rightAnchor),
            
            greenButton.topAnchor.constraint(equalTo: whiteButton.bottomAnchor, constant: 20),
            greenButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            greenButton.leftAnchor.constraint(equalTo: leftAnchor),
            greenButton.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }}

private extension ThemeView {

    @objc func tap1() {
        Theme.currentTheme = WhiteTheme()
        backgroundColor = Theme.currentTheme.backgroundColor
        delegate?.updateColor()
    }

    @objc func tap2() {
        Theme.currentTheme = BlueTheme()
        backgroundColor = Theme.currentTheme.backgroundColor
        delegate?.updateColor()
    }
    
    @objc func tap3() {
        Theme.currentTheme = GreenTheme()
        backgroundColor = Theme.currentTheme.backgroundColor
        delegate?.updateColor()
    }
}

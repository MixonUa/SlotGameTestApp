//
//  GradientLabel.swift
//  SlotGameTestApp
//
//  Created by Михаил Фролов on 13.06.2022.
//

import Foundation
import UIKit

class GradietnLabel: UILabel {
    private let gradientLayer = CAGradientLayer()
    private let scoreLabel = UILabel()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.addSublayer(gradientLayer)
        translatesAutoresizingMaskIntoConstraints = false
        gradientLayer.cornerRadius = 3
        gradientLayer.colors = [UIColor(red: 0.953, green: 0.651, blue: 0.306, alpha: 1).cgColor,
                                UIColor(red: 0.929, green: 0.471, blue: 0.247, alpha: 1).cgColor]
        
        addSubview(scoreLabel)
        configureScoreLabel()
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: topAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            scoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func configureScoreLabel() {
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .center
        scoreLabel.textColor = UIColor(red: 0.169, green: 0.157, blue: 0.212, alpha: 1)
        scoreLabel.font = UIFont(name: "Roboto-Bold", size: 22)
    }
    
    public func updateScoreLabel(score: Int) {
        scoreLabel.text = "\(score)"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}

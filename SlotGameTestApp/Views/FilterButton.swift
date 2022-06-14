//
//  FilterButton.swift
//  SlotGameTestApp
//
//  Created by Михаил Фролов on 11.06.2022.
//

import Foundation
import UIKit

class FilterButton: UIButton {
    
    private let buttonLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(red: 0.918, green: 0.255, blue: 0.255, alpha: 1)
        lineView.layer.cornerRadius = 4
        return lineView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        addSubview(buttonLineView)
        buttonLineView.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        setActive()
        
        if let label = titleLabel {
            NSLayoutConstraint.activate([
                buttonLineView.heightAnchor.constraint(equalToConstant: 4),
                buttonLineView.leadingAnchor.constraint(equalTo: label.leadingAnchor),
                buttonLineView.trailingAnchor.constraint(equalTo: label.trailingAnchor),
                buttonLineView.topAnchor.constraint(equalTo: label.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                buttonLineView.heightAnchor.constraint(equalToConstant: 4),
                buttonLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
                buttonLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
                buttonLineView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }
    
    public func setInactive() {
        buttonLineView.isHidden = true
        titleLabel?.font = UIFont(name: "SFProDisplay", size: 20)
        titleLabel?.textColor = .lightGray
    }
    
    public func setActive() {
        buttonLineView.isHidden = false
        titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 20)
        titleLabel?.textColor = .white
    }
}

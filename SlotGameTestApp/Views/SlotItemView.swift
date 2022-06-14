//
//  SlotItemView.swift
//  SlotGameTestApp
//
//  Created by Михаил Фролов on 14.06.2022.
//

import Foundation
import UIKit

class SlotItemView: UIView {
    private let imageView = UIImageView()
    
    init(with imageName: String) {
        super.init(frame: .zero)
        configure()
        imageView.image = UIImage(named: imageName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

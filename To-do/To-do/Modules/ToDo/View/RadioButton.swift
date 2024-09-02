//
//  RadioButton.swift
//  To-do
//
//  Created by Кирилл Зезюков on 02.09.2024.
//

import UIKit

class RadioButton: UIButton {

    override var isSelected: Bool {
        didSet {
            image.alpha = isSelected ? 1 : 0
        }
    }
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setUpUI() {
        self.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.radioButtonImageTop),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.radioButtonImageTrailing),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.radioButtonImageLeading),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constants.radioButtonImageBottom)
        ])
    }
}

//
//  ViewController.swift
//  vorobei-challange-1
//
//  Created by Alexey Voronov on 03.07.2023.
//

import UIKit

class ViewController : UIViewController {
    let button1 = CustomButton(type: .custom)
    let button2 = CustomButton(type: .custom)
    let button3 = CustomButton(type: .custom)
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img1 = UIImage(systemName: "arrowshape.turn.up.right.circle.fill")
        
        self.button1.setTitle("First Button", for: .normal)
        self.button1.setImage(img1, for: .normal)
        
        self.button2.setTitle("Second Medium Button", for: .normal)
        self.button2.setImage(img1, for: .normal)
        
        self.button3.setTitle("Third", for: .normal)
        self.button3.setImage(img1, for: .normal)
        self.button3.addTarget(self, action: #selector(self.action), for: .touchUpInside)
        
        
        
        let stackView = UIStackView(arrangedSubviews: [button1, button2, button3])
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(stackView)
//
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func action() {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        self.present(vc, animated: true)
    }
}



class CustomButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted == oldValue { return }
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.beginFromCurrentState]) {
                self.transform = self.isHighlighted ? .init(scaleX: 0.9, y: 0.9) : .identity
            }
        }
    }
    
    
    let spacing: CGFloat = 8

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = tintColor
        self.tintAdjustmentMode = .normal
        self.layer.cornerRadius = 10
        self.imageView?.tintColor = self.titleColor(for: .normal)
        self.adjustsImageWhenHighlighted = false
        self.translatesAutoresizingMaskIntoConstraints = false
        tintAdjustmentMode = .automatic
        
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
        
        layoutIfNeeded()
    }

    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += 14 * 2 + spacing
        size.height += 10 * 2
        
        return size
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let imageView = imageView, let titleLabel = titleLabel {
            let titleWidth = titleLabel.frame.width
            let imageWidth = imageView.frame.width
            
            let totalWidth = titleWidth + spacing + imageWidth
            
            titleLabel.frame.origin.x = (bounds.width - totalWidth) / 2
            imageView.frame.origin.x = titleLabel.frame.maxX + spacing
        }
    }
    
    override func tintColorDidChange() {
        UIView.animate(withDuration: 0.2) {
            if self.tintColor == .systemBlue {
                self.backgroundColor = self.tintColor
                self.titleLabel?.textColor = .white
                self.imageView?.tintColor = .white
            } else {
                self.backgroundColor = .systemGray2
                self.titleLabel?.textColor = .systemGray3
                self.imageView?.tintColor = .systemGray3
            }
        }
    }
}

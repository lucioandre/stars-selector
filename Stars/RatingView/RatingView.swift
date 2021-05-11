//
//  RatingView.swift
//  Stars
//
//  Created by Lucio Fonseca on 11.05.21.
//

import UIKit

private enum Star {
    case empty
    case filled

    var uiImage: UIImage {
        switch self {
        case .empty:
            return .init(systemName: "star") ?? .init()
        case .filled:
            return .init(systemName: "star.fill") ?? .init()
        }
    }
}

protocol RatingViewDelegate: AnyObject {
    func didChange(rating: Int)
}

@IBDesignable
class RatingView: UIView {

    // MARK: - Properties
    @IBInspectable var numberOfStars: Int = 5
    @IBInspectable var rating: Int = .zero
    private lazy  var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        return stackView
    }()
    public weak var delegate: RatingViewDelegate?

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    init(numberOfStars: Int, currentRating: Int) {
        self.numberOfStars = numberOfStars
        self.rating = currentRating
        super.init(frame: .zero)
    }

    private func commonInit() {
        self.addSubview(self.stackView)

        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self.stackView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.stackView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.stackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.stackView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutStars()
    }

    // MARK: - Private Methods
    private func layoutStars() {
        self.stackView.removeAllArrangedSubviews()
        for value in 0 ..< numberOfStars {
            let star: Star = value < rating ? .filled : .empty
            let imageView = UIImageView(image: star.uiImage)
            imageView.addGestureRecognizer(RatingTapRecognizer(rating: value+1,
                                                               target: self,
                                                               action: #selector(didChangeRating(sender:))))
            imageView.tintColor = tintColor
            imageView.isUserInteractionEnabled = true
            self.stackView.addArrangedSubview(imageView)
        }
    }

    @objc func didChangeRating(sender: RatingTapRecognizer) {
        self.rating = sender.rating
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.delegate?.didChange(rating: sender.rating)
    }

    // MARK: - Public Methods
    public func set(numberOfStars: Int) {
        if numberOfStars != self.numberOfStars {
            self.numberOfStars = numberOfStars
            self.rating = 0
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }

    public func set(currentRating: Int) {
        if numberOfStars != self.numberOfStars {
            self.rating = currentRating
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
}

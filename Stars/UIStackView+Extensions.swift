//
//  UIStackView+Extensions.swift
//  Stars
//
//  Created by Lucio Fonseca on 11.05.21.
//

import UIKit

extension UIStackView {
    func removeAllArrangedSubviews() {
        self.arrangedSubviews.forEach {
            self.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
}

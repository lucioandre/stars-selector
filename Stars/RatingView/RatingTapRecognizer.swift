//
//  RatingTapRecognizer.swift
//  Stars
//
//  Created by Lucio Fonseca on 11.05.21.
//

import UIKit

class RatingTapRecognizer: UITapGestureRecognizer {
    let rating: Int

    init(rating: Int, target: Any?, action: Selector?) {
        self.rating = rating
        super.init(target: target, action: action)
    }
}

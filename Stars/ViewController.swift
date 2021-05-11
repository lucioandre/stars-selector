//
//  ViewController.swift
//  Stars
//
//  Created by Lucio Fonseca on 11.05.21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet private weak var ratingView: RatingView!
    @IBOutlet private weak var label: UILabel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ratingView.delegate = self
        set(rating: self.ratingView.rating)
    }

    // MARK: - Private Methods
    func set(rating: Int) {
        self.label.text = "Current Rating: \(rating)"
    }
}

extension ViewController: RatingViewDelegate {
    func didChange(rating: Int) {
        set(rating: rating)
    }
}


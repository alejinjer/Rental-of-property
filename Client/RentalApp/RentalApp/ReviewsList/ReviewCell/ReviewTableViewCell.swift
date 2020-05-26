//
//  ReviewTableViewCell.swift
//  RentalApp
//
//  Created by Nikolay Zhurba on 24.05.2020.
//  Copyright © 2020 alejinjer. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var reviewTextLabel: UILabel!

    func configure(with review: Review) {
        usernameLabel.text = review.username == user.username ? "(me)" : review.username
        usernameLabel.textColor = review.username == user.username ? .red : .black
        reviewTextLabel.text = review.text
    }
}

//
//  DetailMainTableViewCell.swift
//  TestMovieApp
//
//  Created by Иван on 31.08.2018.
//  Copyright © 2018 Иван. All rights reserved.
//

import UIKit

class DetailMainTableViewCell: UITableViewCell, Reusable {
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    func configureSelf(with model: UpcomingMovie) {
        self.rate.text = "\(model.voteAverage)"
        guard let date = model.releaseDate,
            let duration = model.originalTitle else { return }
        self.date.text = date
        self.duration.text = duration
    }
}

//
//  DetailHeaderTableViewCell.swift
//  TestMovieApp
//
//  Created by Иван on 31.08.2018.
//  Copyright © 2018 Иван. All rights reserved.
//

import UIKit

class DetailHeaderTableViewCell: UITableViewCell, Reusable {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func configureSelf(with imageURL: String, title: String) {
        movieImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(imageURL)"), completed: nil)
        self.title.text = title
    }
}

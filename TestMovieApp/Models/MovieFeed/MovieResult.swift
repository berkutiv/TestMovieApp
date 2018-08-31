//
//  MoviewResult.swift
//  TestMovieApp
//
//  Created by Иван on 31.08.2018.
//  Copyright © 2018 Иван. All rights reserved.
//

import Foundation

struct MovieResult: Decodable {
    let results: [UpcomingMovie]?
    let total_pages: Int
}


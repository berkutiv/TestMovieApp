//
//  Result.swift
//  TestMovieApp
//
//  Created by Иван on 31.08.2018.
//  Copyright © 2018 Иван. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}

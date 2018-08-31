//
//  MovieDetailsDataManager.swift
//  TestMovieApp
//
//  Created by Иван on 31.08.2018.
//  Copyright © 2018 Иван. All rights reserved.
//

import Foundation

protocol MovieDetailsDataManagerType {
    func getMovieDetails(withId: String)
}

class MovieDetailsDataManager: MovieDetailsDataManagerType {
    
    private let client = MovieClient()
    
    weak var presenter: MovieDetailsDataManagerPresenterType!
    
    init(presenter: MovieDetailsDataManagerPresenterType) {
        self.presenter = presenter
    }
    
    func getMovieDetails(withId id: String) {
        self.client.getDetails(id: id, completion: {[weak self] result in
            print(result)
            switch result {
            case .success(let movieResult):
                guard let movie = movieResult as? UpcomingMovie else { return }
                guard let weakSelf = self else { return }
                weakSelf.presenter.movieDetailsGetted(movie: movie)
            case .failure(let error):
                print("the error \(error)")
            }
        })
    }
}

//
//  MovieDetailsPresenter.swift
//  TestMovieApp
//
//  Created by Иван on 31.08.2018.
//  Copyright © 2018 Иван. All rights reserved.
//

import Foundation

protocol MovieDetailsDataManagerPresenterType: class {
    func movieDetailsGetted(movie: UpcomingMovie)
}

protocol MovieDetailsPresenterType {
    func getMovieFeed(withPage: String)
    func activityIndicatorStartAnimating()
    func activityIndicatorStopAnimating()
}

class MovieDetailsPresenter {
    
    weak var view: PresenterViewType?
    var dataManager: MovieDetailsDataManager?
    
    init(view: PresenterViewType) {
        self.view = view
        dataManager = MovieDetailsDataManager(presenter: self)
    }
    
    func getMovieDetails(withId id: String) {
        dataManager?.getMovieDetails(withId: id)
    }
}

extension MovieDetailsPresenter: MovieDetailsDataManagerPresenterType {
    func movieDetailsGetted(movie: UpcomingMovie) {
        DispatchQueue.main.async {
            self.view?.show(moviews: [movie], totalPages: 0)
        }
    }
    
    func activityIndicatorStartAnimating() {
        view?.activityIndicatorStartAnimating()
    }
    
    func activityIndicatorStopAnimating() {
        view?.acitivtyIndicatorStopAnimating()
    }
}

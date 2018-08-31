//
//  MovieDetailsViewController.swift
//  TestMovieApp
//
//  Created by Иван on 31.08.2018.
//  Copyright © 2018 Иван. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController  {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: MovieDetailsPresenter?
    
    var movieId = ""
    var movie: UpcomingMovie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MovieDetailsPresenter(view: self)
        presenter?.activityIndicatorStartAnimating()
        presenter?.getMovieDetails(withId: movieId)
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.topItem?.title = "Скоро в кино"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = tableViewBackgroundColor
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.setContentOffset(tableView.contentOffset, animated: false)
        tableView.register(DetailHeaderTableViewCell.self)
        tableView.register(DetailMainTableViewCell.self)
    }
}

extension MovieDetailsViewController: PresenterViewType {
    
    func show(moviews: [UpcomingMovie], totalPages: Int) {
        self.movie = moviews.first
        presenter?.activityIndicatorStopAnimating()
        tableView.reloadData()
    }
    
    func activityIndicatorStartAnimating() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func acitivtyIndicatorStopAnimating() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}

extension MovieDetailsViewController: UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = movie else { return 0 }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: DetailHeaderTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            guard let model = movie,
                let url = movie?.posterPath,
                let title = movie?.title
                else { return UITableViewCell()}
            cell.configureSelf(with: url, title: title)
            return cell
        case 1:
            let cell: DetailMainTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            guard let model = movie
                else { return UITableViewCell()}
            cell.configureSelf(with: model)
            return cell
        default:
            return UITableViewCell()
        }
        
    }
}

extension MovieDetailsViewController: UITableViewDelegate {
        
}



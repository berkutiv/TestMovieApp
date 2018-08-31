//
//  ViewController.swift
//  TestMovieApp
//
//  Created by Иван on 31.08.2018.
//  Copyright © 2018 Иван. All rights reserved.
//

import UIKit

protocol PresenterViewType: class {
    func show(moviews: [UpcomingMovie], totalPages: Int)
    func activityIndicatorStartAnimating()
    func acitivtyIndicatorStopAnimating()
}

class UpcomingMoviesVC: UIViewController  {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var presenter: UpcomingMoviesPresenter?
    var moviesData = [UpcomingMovie]()
    private var page = 1
    private var totalPages = 0
    private var cellHeights: [IndexPath : CGFloat] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = UpcomingMoviesPresenter(view: self)
        presenter?.activityIndicatorStartAnimating()
        presenter?.getMoviewFeed(withPage: String(page))
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
        tableView.setContentOffset(tableView.contentOffset, animated: false)
        tableView.register(UpcomingMoviesTableViewCell.self)
    }
}

extension UpcomingMoviesVC: PresenterViewType {
    
    func show(moviews: [UpcomingMovie], totalPages: Int) {
        moviesData += moviews
        self.totalPages = totalPages
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

extension UpcomingMoviesVC: UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UpcomingMoviesTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.selectionStyle = .none
        cell.configureSelf(withModel: moviesData[indexPath.row])
        return cell
    }
}

extension UpcomingMoviesVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let height = cellHeights[indexPath] else { return 150.0 }
        return height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
        if indexPath.row == moviesData.count - 1  && page < totalPages + 1  {
            page += 1
            presenter?.getMoviewFeed(withPage: String(page))
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = moviesData[indexPath.row]
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "movieDetVC") as? MovieDetailsViewController else { return }
        controller.movieId = "\(model.id)"
        self.navigationController?.pushViewController(controller, animated: true)
    }
}


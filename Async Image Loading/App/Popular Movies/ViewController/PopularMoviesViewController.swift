//
//  PopularMoviesViewController.swift
//  Async Image Loading
//
//  Created by Sachin Ambegave on 25/01/22.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    static let operationQueue = OperationQueue()
    
    weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var tableview: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.backgroundView = activityIndicator
        tableView.register(UINib(nibName: MovieCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MovieCell.reuseIdentifier)
        
        return tableView
    }()
    
    private var viewModel: PopularMoviesViewModel!
    
    typealias DataSource = UITableViewDiffableDataSource<Section, MovieCellModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, MovieCellModel>
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if viewModel.popularMovies.value?.isEmpty ?? true {
            activityIndicator.startAnimating()
            
            PopularMoviesViewController.operationQueue.addOperation {
                Thread.sleep(forTimeInterval: 3)
                
                OperationQueue.main.addOperation {
                    self.activityIndicator.stopAnimating()
                    self.viewModel.loadMovies()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialise()
    }
    
    private func initialise() {
        viewModel = PopularMoviesViewModel()
        
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        title = "Popular Movies"
        
        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator = activityIndicatorView
        
        view.addSubview(tableview)
        tableview.frame = view.bounds
    }

    var index = 0
    private func bindViewModel() {
        viewModel.popularMovies.bind { [weak self] _ in
            self?.index += 1
            DispatchQueue.main.async {
                self?.tableview.separatorStyle = .singleLine
                print("#Async number of times reloaded : \(self?.index ?? 0)")
                self?.tableview.reloadData()
            }
        }
    }
}

extension PopularMoviesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.popularMovies.value?.isEmpty ?? true ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.popularMovies.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell else { return UITableViewCell() }
        
        guard let movie = viewModel.popularMovies.value?[indexPath.row] else {
            return cell
        }
        cell.configure(movie)

//        var content = cell.defaultContentConfiguration()
//        content.image = cellModel.image
//
//        content.text = cellModel.title
//        content.secondaryText = cellModel.overview
//
//        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
}

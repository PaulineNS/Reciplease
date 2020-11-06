//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 25/10/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var vegetarianSwitch: UISwitch!
    @IBOutlet private weak var loadActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchRecipesButton: UIButton!
    @IBOutlet private var clearButton: UIBarButtonItem!
    @IBOutlet private weak var ingredientsTableView: UITableView! {
        didSet {
            ingredientsTableView.tableFooterView = UIView()
        }
    }
    
    // MARK: - Public Properties

    var viewModel: SearchViewModel!

    // MARK: - Private Properties

    private lazy var source: SearchDataSource = SearchDataSource()
    
    // MARK: - View life cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateView()
        ingredientsTableView.delegate = source
        ingredientsTableView.dataSource = source
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        viewModel.start()
    }
    
    // MARK: - Bindings

    private func bind(to viewModel: SearchViewModel) {
        viewModel.searchPlaceholder = { [weak self] title in
            self?.searchTextField.placeholder = title
        }
        viewModel.ingredientsToSearch = { [weak self] ingredients in
            self?.source.updateCell(with: ingredients)
            self?.ingredientsTableView.reloadData()
        }
        viewModel.activityIndicatorIsHidden = { [weak self] isHidden in
            switch isHidden {
            case true:
                self?.loadActivityIndicator.isHidden = true
                self?.searchRecipesButton.isHidden = false
            case false:
                self?.loadActivityIndicator.isHidden = false
                self?.searchRecipesButton.isHidden = true
            }
        }
        viewModel.rightBarButtonItemIsHidden = { [weak self] isHidden in
            switch isHidden {
            case true:
                self?.navigationItem.rightBarButtonItem = nil
            case false:
                self?.navigationItem.rightBarButtonItem = self?.clearButton
            }
        }
    }
}

// MARK: - Actions

extension SearchViewController {
    
    @IBAction private func didTapAddButton(_ sender: Any) {
        guard let searchBarTxt = searchTextField.text else {return}
        viewModel.didAdd(ingredient: searchBarTxt)
        searchTextField.text = nil
        ingredientsTableView.reloadData()
    }
    
    @IBAction private func didTapClearButton(_ sender: Any) {
        viewModel.didSelectClearButton()
        ingredientsTableView.reloadData()
    }
    
    @IBAction private func didTapGoButton(_ sender: Any) {
        viewModel.didSelectGoButton(for: vegetarianSwitch.isOn)
    }
    
    @IBAction private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()
    }
}

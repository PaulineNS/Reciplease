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
        viewModel.start()
        ingredientsTableView.delegate = source
        ingredientsTableView.dataSource = source
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        loadActivityIndicator.isHidden = true
        navigationItem.rightBarButtonItem = nil
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
    }
}

// MARK: - Actions

extension SearchViewController {
    
    @IBAction private func didTapAddButton(_ sender: Any) {
        guard let searchBarTxt = searchTextField.text else {return}
        viewModel.didAdd(ingredient: searchBarTxt)
        searchTextField.text = nil
        navigationItem.rightBarButtonItem = clearButton
        ingredientsTableView.reloadData()
        self.loadActivityIndicator.isHidden = true
        self.searchRecipesButton.isHidden = false
    }
    
    @IBAction private func didTapClearButton(_ sender: Any) {
        navigationItem.rightBarButtonItem = nil
        viewModel.didSelectClearButton()
        ingredientsTableView.reloadData()
    }
    
    @IBAction private func didTapGoButton(_ sender: Any) {
        loadActivityIndicator.isHidden = false
        searchRecipesButton.isHidden = true
        viewModel.didSelectGoButton(for: vegetarianSwitch.isOn) { response in
            if response == true {
                self.loadActivityIndicator.isHidden = true
                self.searchRecipesButton.isHidden = false
            }
        }
    }
    
    @IBAction private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()
    }
}

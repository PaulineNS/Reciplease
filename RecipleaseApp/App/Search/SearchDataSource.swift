//
//  SearchDataSource.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 02/11/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import UIKit

final class SearchDataSource: NSObject {

    // MARK: - Public properties

    private var ingredientsArray = [String]()

    // MARK: - Methods

    func updateCell (with ingredient: [String]) {
        self.ingredientsArray = ingredient
    }

}

extension SearchDataSource: UITableViewDelegate,
                            UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return ingredientsArray.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell",
                                                 for: indexPath)
        cell.textLabel?.text = "-" + " " + ingredientsArray[indexPath.row].capitalized
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = #colorLiteral(red: 0.08918375522, green: 0.2295971513, blue: 0.2011210024, alpha: 1)
        cell.textLabel?.font = UIFont(name: "Savoye LET", size: 40)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredientsArray.remove(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   viewForFooterInSection section: Int) -> UIView? {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "reciplease")
        imageView.contentMode = .scaleAspectFill
        imageView.contentMode = .center
        return imageView
    }
    
    func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat {
        return ingredientsArray.isEmpty ? tableView.bounds.size.height : 0
    }
    
}

//
//  DetailsViewController.swift
//  Tasty
//
//  Created by EsraaGK on 4/1/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, DetailsViewProtocol {
    var presenter: DetailsPresenter?
    @IBOutlet private weak var detailsImage: UIImageView!
    @IBOutlet private weak var ingrediantTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instatiateIngrediantTableView()
    }
    
    func instatiateIngrediantTableView() {
        ingrediantTable.delegate = self
        ingrediantTable.dataSource = self
        ingrediantTable.register(DetailsTableViewCell.nib,
                                 forCellReuseIdentifier: DetailsTableViewCell.identifire)
    }
    
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifire)
            as? DetailsTableViewCell else { return UITableViewCell() }
        return cell
    }
}

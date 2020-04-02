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
//        ingrediantTable.register(DetailsTableViewHeader.nib,
//                                 forHeaderFooterViewReuseIdentifier: DetailsTableViewHeader.identifire)
        ingrediantTable.tableFooterView = UIView(frame: CGRect.zero)
        let myView = Bundle.loadView(fromNib: "DetailsHeaderView", withType: DetailsHeaderView.self)

        ingrediantTable.tableHeaderView = myView
        
    }
    
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifire)
            as? DetailsTableViewCell else { return UITableViewCell() }
        return cell
    }
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DetailsTableViewHeader.identifire )
//            as? DetailsTableViewHeader else { return DetailsTableViewHeader() }
//
//        return header
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return UIScreen.main.bounds.height*0.3
//    }

}

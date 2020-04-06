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
    var viewObj: Recipe?
    
    @IBOutlet private weak var ingrediantTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewObj = presenter?.getDetailsViewData()
        instatiateIngrediantTableView()
    }
    
    func instatiateIngrediantTableView() {
        ingrediantTable.delegate = self
        ingrediantTable.dataSource = self
        ingrediantTable.isUserInteractionEnabled = false;
        ingrediantTable.register(DetailsTableViewCell.nib,
                                 forCellReuseIdentifier: DetailsTableViewCell.identifire)
//        ingrediantTable.register(DetailsTableViewHeader.nib,
//                                 forHeaderFooterViewReuseIdentifier: DetailsTableViewHeader.identifire)
        ingrediantTable.tableFooterView = UIView(frame: CGRect.zero)
        var frame = UIScreen.main.bounds
        frame.size.height = UIScreen.main.bounds.size.height * CGFloat(0.3)
        let myView = DetailsHeaderView(frame: frame)
        ingrediantTable.tableHeaderView = myView
        myView.configureHeaderView(imgUrlString: viewObj?.image ?? "", title: viewObj?.label ?? "")
        myView.parentViewController = self
        myView.sourceUrl = viewObj?.url
        
    }
    
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewObj?.ingredientLines.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifire)
            as? DetailsTableViewCell else { return UITableViewCell() }
        cell.configureCell( with: viewObj?.ingredientLines[indexPath.row] ?? "")
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

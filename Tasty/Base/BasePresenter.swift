//
//  BasePresenter.swift
//  Checklist
//
//  Created Bassem Abbas on 12/1/19.
//  Copyright © 2019 Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Foundation

class BasePresenter<View: BaseViewProtocol, Model: BaseModelProtocol>: NSObject {

    private var view: View
    private var model: Model
    
    init(view: View, model: Model ) {
        self.view = view
        self.model = model
    }
}

//
//  ProductDetailPresenter.swift
//  dolap-ios-case-study
//
//  Created by Emre Çelik on 5.11.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProductDetailPresentationLogic {
    func presentSomething(response: ProductDetail.Something.Response)
}

class ProductDetailPresenter: ProductDetailPresentationLogic {
    weak var viewController: ProductDetailDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: ProductDetail.Something.Response) {
        let viewModel = ProductDetail.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}

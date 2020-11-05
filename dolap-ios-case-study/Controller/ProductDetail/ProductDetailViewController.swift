//
//  ProductDetailViewController.swift
//  dolap-ios-case-study
//
//  Created by Emre Çelik on 5.11.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProductDetailDisplayLogic: class {
    func displayProduct(product: Product)
    func displaySocial(social: Social)
    func displayLoading()
    func hideLoading()
    func displayError(error: FileManagerError)
    func displayEmpty()
}

final class ProductDetailViewController: UIViewController, ProductDetailDisplayLogic {
 
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameDescLabel: UILabel!
    @IBOutlet private weak var averageRatingLabel: UILabel!
    @IBOutlet private weak var commentCountLabel: UILabel!
    @IBOutlet private weak var likeCountLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private var ratingImageViews: [UIImageView]!
    @IBOutlet private weak var counterBackView: UIView!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var likeButton: UIButton!
    
    var interactor: ProductDetailBusinessLogic?
    var router: (NSObjectProtocol & ProductDetailRoutingLogic & ProductDetailDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ProductDetailInteractor()
        let presenter = ProductDetailPresenter()
        let router = ProductDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProduct()
        getSocial()
    }
    
    @IBAction func likeButtonTouchUpInside(_ sender: Any) {
        likeButton.isSelected = !likeButton.isSelected
    }
    
    private func getProduct() {
        let request = ProductDetail.GetProduct.Request()
        interactor?.fetchProduct(request: request)
    }
    
    private func getSocial() {
        let request = ProductDetail.GetSocial.Request()
        interactor?.fetchSocial(request: request)
    }
    
    
    // MARK: Presenter Funcs
    func displayProduct(product: Product) {
        nameDescLabel.text = "\(product.name) - \(product.desc)"
        priceLabel.text = "\(product.price.value) \(product.price.currency)"
        imageView.imageFromUrl(urlString: product.image)
    }
    
    func displaySocial(social: Social) {
        likeCountLabel.text = "\(social.likeCount)"
        let totalComment = Int(social.commentCounts.anonymousCommentsCount) + Int(social.commentCounts.memberCommentsCount)
        commentCountLabel.text = "( \(totalComment) yorum )"
        averageRatingLabel.text = "\(social.commentCounts.averageRating)"
    }
    
    func displayLoading() {
        self.view.showLoading()
    }
    
    func hideLoading() {
        self.view.stopLoading()
    }
    
    func displayError(error: FileManagerError) {
        switch error {
        case .notFound:
            alert(message: "File not found")
            break
        case .fileNotReadable:
            alert(message: "File not readable")
            break
        case .fileDecode:
            alert(message: "File decode error")
            break
        }
    }
    
    func displayEmpty() {
        alert(message: "Empty")
    }
    
    
}

// https://www.youtube.com/watch?v=Qh1Sxict3io

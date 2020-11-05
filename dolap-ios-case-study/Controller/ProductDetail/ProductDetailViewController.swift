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
    @IBOutlet weak var counterBackView: CircularProgressView!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var likeButton: UIButton!
    
    private var timer: Timer?
    private var counter: Int = 0
    private let socialRefreshTime = 6
    private var isLiked: Bool = false
    
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
        setupView()
        getProduct()
        getSocial()
    }
    
    private func setupView() {
        counterBackView.createCircularPath()
        counterBackView.setProgressWithAnimation(duration: 0, value: 0)
    }
    
    @objc
    private func countTime() {
        counter += 1
        counterLabel.text = "\(counter)"
        counterBackView.setProgressWithAnimation(duration: 0, value: Float(counter) / Float(socialRefreshTime))
        if counter == socialRefreshTime {
            killTimer()
            getSocial()
        }
    }
    
    private func killTimer() {
        timer?.invalidate()
        timer = nil
        counterLabel.text = "0"
        counterBackView.setProgressWithAnimation(duration: 0, value: 0)
    }
    
    @IBAction func likeButtonTouchUpInside(_ sender: Any) {
        if likeButton.isSelected {
            isLiked = false
            likeCountLabel.text = "\((Int(likeCountLabel.text ?? "1") ?? 1) - 1)"
        }
        else {
            isLiked = true
            likeCountLabel.text = "\((Int(likeCountLabel.text ?? "-1") ?? -1) + 1)"
        }
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
    
    private func setRatingStars(rating: Int) {
        if rating == 0 { return }
        for i in 0...rating {
            ratingImageViews[i].tintColor = #colorLiteral(red: 0.9755776525, green: 0.6595294476, blue: 0.1456838846, alpha: 1)
        }
    }
    
    private func setTitleLabel(name: String, description: String) {
        let headingAttribute = [ NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 17.0)! ]
        let headingAttrString = NSAttributedString(string: name, attributes: headingAttribute)
        
        let contentAttribute = [ NSAttributedString.Key.font: UIFont(name: "AvenirNext-Regular", size: 15.0)! ]
        let contentAttrString = NSAttributedString(string: " \(description)", attributes: contentAttribute)
        
        let combination = NSMutableAttributedString()

        combination.append(headingAttrString)
        combination.append(contentAttrString)
        
        nameDescLabel.attributedText = combination
    }
    
    
    // MARK: Presenter Funcs
    func displayProduct(product: Product) {
        setTitleLabel(name: product.name, description: product.desc)
        priceLabel.text = "\(product.price.value) \(product.price.currency)"
        imageView.imageFromUrl(urlString: product.image)
    }
    
    func displaySocial(social: Social) {
        if isLiked {
            likeCountLabel.text = "\(social.likeCount + 1)"
        }
        else {
            likeCountLabel.text = "\(social.likeCount)"
        }
        
        let totalComment = Int(social.commentCounts.anonymousCommentsCount) + Int(social.commentCounts.memberCommentsCount)
        commentCountLabel.text = "( \(totalComment) yorum )"
        averageRatingLabel.text = "\(social.commentCounts.averageRating)"
        setRatingStars(rating: Int(social.commentCounts.averageRating))
        timer = Timer.scheduledTimer(timeInterval:1,
                                     target:self,
                                     selector:#selector(countTime),
                                     userInfo: nil, repeats: true)
        counter = 0
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

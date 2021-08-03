//
//  CustomTableViewCell.swift
//  SamsungUI
//
//  Created by Hemant Sharma on 03/08/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
            let view = UIView()
            return view
        }()
    
    internal var productStatus: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    internal var productName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()

    internal lazy var productPrice: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()

    internal lazy var productOfferPrice: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
    }()

    internal lazy var productView: UIImageView = {
        let productImage = UIImageView ()
        return productImage
    }()
    internal lazy var productBookButton: UIButton = {
            let button = UIButton()
            button.setTitle("Book", for: .normal)
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            return button
        }()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styleView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleView()
    {
        contentView.backgroundColor = .white
        contentView.addSubview(containerView)
        containerView.fillSuperview()
        
        containerView.addSubview(productView)
        productView.anchor(containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 10, bottomConstant: 5, rightConstant: 0 , widthConstant: 100, heightConstant: 100)
        
        containerView.addSubview(productName)
        productName.anchor(containerView.topAnchor, left: productView.rightAnchor, bottom: nil, right: containerView.rightAnchor, topConstant: 5, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        productName.textAlignment = .left

        containerView.addSubview(productPrice)
        productPrice.anchor(productName.bottomAnchor, left: productView.rightAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 140, heightConstant: 0)
        
        containerView.addSubview(productOfferPrice)
        productOfferPrice.anchor(productPrice.bottomAnchor, left: productView.rightAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 140, heightConstant: 0)
                
        containerView.addSubview(productBookButton)
                productBookButton.anchor(nil, left: nil, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 8, rightConstant: 16, widthConstant: 80, heightConstant: 40)
    }
    
    func configure(name: String, priceDisplay: String, offerPriceDisplay: String, imageURL: String) {
        productName.text = name
        productPrice.text = priceDisplay
        productOfferPrice.attributedText = offerPriceDisplay.strikeThrough()
        productView.downloaded(from: imageURL)
    }
}


extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
               value: NSUnderlineStyle.single.rawValue,
                   range:NSMakeRange(0,attributeString.length))
        return attributeString
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String?, contentMode mode: ContentMode = .scaleAspectFit) {
        if let link = link {
            guard let url = URL(string: link) else { return }
            downloaded(from: url, contentMode: mode)
        }
    }
}

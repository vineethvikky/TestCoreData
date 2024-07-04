//
//  DocumentTableViewCell.swift
//  TestCoreData
//
//  Created by Vineeth on 04/07/24.
//

import UIKit
import SDWebImage

final class DocumentTableViewCell: UITableViewCell {

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var discriptionLabel: UILabel!
    @IBOutlet weak private var date: UILabel!
    @IBOutlet weak private var documentImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureItem(item: UserDocument) {
        titleLabel.text = item.title
        discriptionLabel.text = item.discription
        documentImageView.sd_setImage(with: item.url, placeholderImage: UIImage(named: placeHolderImage))
        date.text = item.date
    }
}

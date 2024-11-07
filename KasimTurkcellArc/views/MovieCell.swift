//
//  MovieCell.swift
//  KasimTurkcellArc
//
//  Created by Sefa Aycicek on 7.11.2024.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var acc: UIActivityIndicatorView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(data : MovieUIModel) {
        movieLabel.text = data.title
        self.movieImageView.kf.setImage(with: data.url)
        //self.movieImageView.loadImage(url: data.url, acc: self.acc)
    }
}

extension UIImageView {
    func loadImage(url : URL?, acc : UIActivityIndicatorView? = nil) {
        if let url = url {
            let urlRequest = URLRequest(url: url)
            acc?.startAnimating()
            URLSession.shared.dataTask(with: urlRequest) { data, URLResponse, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                        acc?.stopAnimating()
                    }
                }
            }.resume()
        }
    }
}

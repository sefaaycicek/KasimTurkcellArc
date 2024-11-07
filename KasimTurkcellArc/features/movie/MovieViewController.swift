//
//  MovieViewController.swift
//  KasimTurkcellArc
//
//  Created by Sefa Aycicek on 7.11.2024.
//

import UIKit
import RxSwift

class MovieViewController: UIViewController {

    @IBOutlet weak var collectionView : UICollectionView!
    
    let CELL_PADDING : CGFloat = 10
    let CELL_IDENTIFIER = "MovieCell"
    
    let viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        observeItems()
        viewModel.getData(searchText: "war")
    }
    
    func observeItems() {
        viewModel.data
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { result in
                self.collectionView.reloadData()
            }.disposed(by: viewModel.disposeBag)
    }
    
    private func configureCollectionView() {
        
        collectionView.register(UINib(nibName: CELL_IDENTIFIER, bundle: nil),
                                forCellWithReuseIdentifier: CELL_IDENTIFIER)
        
        let viewFlowLayout = UICollectionViewFlowLayout()
        viewFlowLayout.scrollDirection = .vertical
        //viewFlowLayout.minimumLineSpacing = CELL_PADDING
        //viewFlowLayout.minimumInteritemSpacing = CELL_PADDING
        collectionView.collectionViewLayout = viewFlowLayout
    }
}

extension MovieViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_IDENTIFIER, for: indexPath) as? MovieCell
        
        cell?.configure(data: viewModel.getItem(at: indexPath.row))
        
        
        return cell ?? UICollectionViewCell()
    }
}

extension MovieViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width = (collectionView.bounds.width - CELL_PADDING * 3) / 2
        let ratio = 445.0 / 300.0
        var height = width * ratio
        
        if indexPath.row % 6 == 0 {
            width = collectionView.bounds.width - CELL_PADDING * 2
            height = width * ratio
        }
        //let height: CGFloat = (width: width, ratio: 1.77)}
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CELL_PADDING, left: CELL_PADDING, bottom: CELL_PADDING, right: CELL_PADDING)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CELL_PADDING
    }
}

//
//  MovieViewController.swift
//  KasimTurkcellArc
//
//  Created by Sefa Aycicek on 7.11.2024.
//

import UIKit

class MovieViewController: UIViewController {

    let viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getData(searchText: "love")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

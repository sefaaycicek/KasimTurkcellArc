//
//  ViewController.swift
//  KasimTurkcellArc
//
//  Created by Sefa Aycicek on 6.11.2024.
//

import UIKit
import RxSwift
import RxRelay

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchBar : UISearchBar!
    
    let viewModel = ViewControllerViewModel()
    
    var posts = [PostEntity]()
    
    let PORTAKAL_CELL = "portakal"
    let ELMA_CELL = "elma"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeItems()
        getData()
        
        textField.rx.text.orEmpty
            .bind(to: viewModel.userEmail)
            .disposed(by: viewModel.disposeBag)
        
        searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .subscribe { searchText in
                self.viewModel.filter(prm: searchText)
            }.disposed(by: viewModel.disposeBag)
        
    }
    
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @IBAction func save() {
        if viewModel.validate() {
            viewModel.save()
        }
    }
    
    func getData() {
        viewModel.getData()
        
        /*ApiService.shared.fetchPosts { result in
         self.posts = result
         self.tableView.reloadData()
         }*/
    }
    
    func observeItems() {
        viewModel.data
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { result in
                self.posts = result
                self.tableView.reloadData()
            }.disposed(by: viewModel.disposeBag)
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = (indexPath.row % 2 == 0) ? PORTAKAL_CELL : ELMA_CELL
        let post = self.posts[indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? PostCellTable
        cell?.configure(postEntity: post)
        
        

        /*let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "portakal")
        
        let post = self.posts[indexPath.row]
        
        cell.textLabel?.text = "\(indexPath.section)-\(indexPath.row)" //post.title
        cell.detailTextLabel?.text = post.body*/
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            posts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Sil beni"
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Post Listesi"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Toplam \(posts.count) item"
    }
    
}

/*extension ViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filter(prm: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
*/

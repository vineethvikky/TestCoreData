//
//  ListViewController.swift
//  TestCoreData
//
//  Created by Vineeth on 04/07/24.
//

import UIKit
import SVProgressHUD

final class ListViewController: UIViewController {
    @IBOutlet weak private var listTableView: UITableView!
    private var listViewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
    }
    
    private func configureUi() {
        configureNavigationBar()
        configureTableView()
        getData()
    }
    
    private func configureNavigationBar() {
        self.title = documents
    }
    
    private func configureTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
        listViewModel.listUIProtocol = self
        DocumentTableViewCell.registerNib(tableView: listTableView)
    }
}

//MARK:- API methods
extension ListViewController {
    @MainActor
    private func getData() {
        Task {
            do {
                SVProgressHUD.show()
                let documentResponse = try await listViewModel.getListData()
                listViewModel.deleteAndSaveDocuments(documents: documentResponse.response.docs)
                listViewModel.sortDocumentsAndReload()
                await SVProgressHUD.dismiss()
            } catch {
                listViewModel.sortDocumentsAndReload()
                await SVProgressHUD.dismiss()
                print(error)
            }
        }
    }
}

//MARK:- UITableViewDelegate methods
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

//MARK:- UITableViewDataSource methods
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DocumentTableViewCell.identifier, for: indexPath) as? DocumentTableViewCell else {
            return UITableViewCell(frame: .zero)
        }
        cell.configureItem(item: listViewModel.documents[indexPath.row])
        return cell
    }
}

//MARK:- UITableViewDataSource methods
extension ListViewController: ListUIProtocol {
    func reloadTableView() {
        listTableView.reloadData()
    }
}




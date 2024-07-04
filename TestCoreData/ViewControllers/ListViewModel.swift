//
//  ListViewModel.swift
//  TestCoreData
//
//  Created by Vineeth on 04/07/24.
//

import Foundation

protocol ListUIProtocol: AnyObject {
    func reloadTableView()
}

enum NetworkError: Error {
    case unknown
    case networkError
    case invalidUrl
}

final class ListViewModel {
    var documents = [UserDocument]()
    weak var listUIProtocol: ListUIProtocol?
    
    func getListData() async throws -> DocResponse {
        guard let url = URL(string: documentsUrl) else {
            throw NetworkError.invalidUrl
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let urlResponse = response as? HTTPURLResponse, (200...299).contains(urlResponse.statusCode) else {
            throw NetworkError.networkError
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(DocResponse.self, from: data)
    }
    
    func deleteAndSaveDocuments(documents: [Document]) {
        CoreDataManager.shared.deleteDocuments()
        CoreDataManager.shared.saveDocuments(documents: documents)
    }
    
    func sortDocumentsAndReload() {
        let tempDocuments = CoreDataManager.shared.getDocuments()
        documents = tempDocuments.sorted(by: { $0.formattedDate > $1.formattedDate })
        listUIProtocol?.reloadTableView()
    }
}

extension UserDocument {
    var formattedDate: Date {
        if let date {
            let dateFormatter = DateFormatter()
            return dateFormatter.date(from: date) ?? Date()
        }
        return Date()
    }
}

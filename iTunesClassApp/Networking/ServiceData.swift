//
//  ServiceData.swift
//  GitHubMobile
//
//  Created by Israrul on 4/8/20.
//  Copyright © 2020 Israrul Haque. All rights reserved.
//

import Foundation

struct ContentService {
   
    func fetchUsers(withTerm: String, handler: @escaping (Result<Feed?, Error>) -> Void) {
        let searchString = withTerm.replacingOccurrences(of: " ", with: "+")
        let searchURL = EndPoints.baseUrl.rawValue + EndPointsPath.search.rawValue + searchString
        guard let url = URL(string: searchURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { handler(.failure(error!)); return }
            let decoder = JSONDecoder()
            let users = try? decoder.decode(Feed.self, from: data)
            handler(.success(users))
        }.resume()
   }
}

//
//  URL+Extension.swift
//  RealmApplication
//
//  Created by Evgeniy Chernyshov on 29.07.2021.
//

import Foundation

extension URL {
    
    static var recommendations: URL {
        urlWithEndpoint("recommendations")
    }

    static func article() -> URL {
        urlWithEndpoint("articles/")
    }
}

    private extension URL {
        static func urlWithEndpoint(_ endpoint: String) -> URL {
            URL(string: "https://api.myapp.com/\(endpoint)")!
        }
    }


struct Endpoints {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoints {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.myapp.com"
        components.path = "/" + path
        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }

        return url
    }
}

extension Endpoints {

    static func movieApiPath(with apiKey: String, lang: String) -> Self {
        Endpoints(path: "https://api.themoviedb.org/3/genre/movie/list/\(apiKey)\(lang)")
    }
    
    static func walletApiPath() -> Self {
        Endpoints(path: "https://dev.kuvacash.net/api/mobile/account/v2/wallet-types")
    }
}

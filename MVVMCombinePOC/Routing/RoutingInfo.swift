//
//  RoutingInfo.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 12/10/2021.
//

import Foundation
import UIKit

public class RoutingInfo {
    
    var host: String
    private var mapping: [String : SceneBuilder] = [:]
    
    public init(host: String) {
        self.host = host
    }
    
    public func register(builder: SceneBuilder, to path: String) {
        self.mapping[path] = builder
    }
    
    func getViewController(for url: String) -> UIViewController? {
        guard let url = URL(string: url),
              url.host == self.host,
              let builder = mapping[url.lastPathComponent],
              let params = url.queryDictionary else {
            return nil
        }
        return builder.build(params: params)
    }
}

private extension URL {
    var queryDictionary: [String: String]? {
        guard let query = self.query else { return nil}

        var queryStrings = [String: String]()
        for pair in query.components(separatedBy: "&") {

            let key = pair.components(separatedBy: "=")[0]

            let value = pair
                .components(separatedBy:"=")[1]
                .replacingOccurrences(of: "+", with: " ")
                .removingPercentEncoding ?? ""

            queryStrings[key] = value
        }
        return queryStrings
    }
}

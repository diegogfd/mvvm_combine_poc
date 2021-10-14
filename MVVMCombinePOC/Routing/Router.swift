//
//  Router.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 12/10/2021.
//

import Foundation
import UIKit

public class Router {
    
    public static let shared: Router = Router()
    private var modulesRoutingInfo: [RoutingInfo] = []
        
    public func register(routingInfo: RoutingInfo) {
        modulesRoutingInfo.append(routingInfo)
    }
    
    public func getViewController(for url: String) -> UIViewController? {
        guard let url = URL(string: url) else {
            return nil
        }
        let routingInfo = self.modulesRoutingInfo.first(where: {$0.host == url.host})
        return routingInfo?.mapping[url.lastPathComponent]?.build(params: url.queryDictionary ?? [:])
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

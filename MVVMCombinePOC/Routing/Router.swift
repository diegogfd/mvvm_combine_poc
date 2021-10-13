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
        return routingInfo?.getViewController(for: url.absoluteString)
    }
    
}

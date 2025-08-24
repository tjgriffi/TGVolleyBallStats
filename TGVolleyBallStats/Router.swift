//
//  Router.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 8/22/25.
//

import Foundation
import SwiftUI

enum Route: Hashable {
    case addRally(setViewModel: Binding<SetViewModel>)
    case gameScreen
    
    // TODO: See what this is doing
    nonisolated static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case (.addRally, .addRally):
            return true
        default:
            return true
        }
    }
    
    nonisolated func hash(into hasher: inout Hasher) {
        switch self {
        case .addRally:
            hasher.combine("addRally")
        default:
            hasher.combine("\(self)")
        }
    }
}

@Observable
class Router {
    var navigationPath = NavigationPath()
    
    /// Basic navigation to a route
    func navigate(to route: Route) {
        navigationPath.append(route)
    }
    
    /// Backwards navigation after an action has been completed
    func goBack() {
        navigationPath.removeLast()
    }
    
    
    /// Go to the root of the navigationPath stack
    func goToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}

// Provide the router via environment
extension EnvironmentValues {
    var router: Router {
        get { self[RouterKey.self] }
        set { self[RouterKey.self] = newValue }
    }
}

struct RouterKey: EnvironmentKey {
    static var defaultValue = Router()
}

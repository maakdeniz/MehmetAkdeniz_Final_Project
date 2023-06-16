//
//  MockHomeRouter.swift
//  iTunesAppTests
//
//  Created by Mehmet Akdeniz on 9.06.2023.
//

import XCTest
@testable import iTunesApp 
@testable import iTunesAPI

final class MockHomeRouter: HomeRouterProtocol {
    
    var isNavigateToDetailViewCalled = false

    static func createModule() -> UIViewController {
        return UIViewController()
    }

    func navigateToDetailView(on view: HomeViewProtocol?, with music: Music) {
        isNavigateToDetailViewCalled = true
    }
}

//
//  ConnectivityCheckInteractor.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 6.06.2023.
//

import Foundation
import SystemConfiguration

protocol PresenterToInteractorConnectivityCheckProtocol: AnyObject {
    var presenter: InteractorToPresenterConnectivityCheckProtocol? { get set }
    
    func checkInternetConnection()
}

class ConnectivityCheckInteractor: PresenterToInteractorConnectivityCheckProtocol {
    weak var presenter: InteractorToPresenterConnectivityCheckProtocol?
    
    func checkInternetConnection() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            if Reachability.isConnectedToNetwork() {
                self?.presenter?.internetConnectionSuccess()
            } else {
                self?.presenter?.internetConnectionFailed()
            }
        }
    }
}




public class Reachability {

    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }

        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
}



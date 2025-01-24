import Foundation

/// The browser router object, to be implemented by the objects who trigger the call.
public protocol OSIABRouter {
    associatedtype ReturnType
    
    /// Handles opening the passed `url`.
    /// - Parameter url: URL to be opened.
    /// - Parameter completionHandler: The callback with the result of opening the url.
    func handleOpen(_ url: URL, _ completionHandler: @escaping (ReturnType) -> Void)
}

public protocol OSIABWebViewRouter {
    associatedtype ReturnType
    
    /// Handles opening the passed `urlRequest`.
    /// - Parameter urlRequest: URLRequest to be opened.
    /// - Parameter completionHandler: The callback with the result of opening the url.
    func handleOpen(_ urlRequest: URLRequest, _ completionHandler: @escaping (ReturnType) -> Void)
}

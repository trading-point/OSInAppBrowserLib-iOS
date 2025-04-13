import UIKit

/// Protocol to be implemented by the objects that can handle opening URLs.
/// This is implemented by the `UIApplication` object that can be used as an External Browser.
public protocol OSIABApplicationDelegate: AnyObject {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completionHandler completion: ((Bool) -> Void)?)
}

/// Provide a default implementations that abstracts the options parameter.
extension OSIABApplicationDelegate {
    public func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any] = [:], completionHandler completion: ((Bool) -> Void)?) {
        self.open(url, options: options, completionHandler: completion)
    }
}

/// Make `UIApplication` conform to the `OSIABApplicationDelegate` protocol.
extension UIApplication: OSIABApplicationDelegate {}

/// Adapter that makes the required calls so that an `OSIABApplicationDelegate` implementation can perform the External Browser routing.
public class OSIABApplicationRouterAdapter: OSIABRouter {
    public typealias ReturnType = Bool
        
    /// Constructor method.
    public init() {}
    
    public func handleOpen(_ url: URL, _ completionHandler: @escaping (ReturnType) -> Void) {
        guard UIApplication.shared.canOpenURL(url) else { return completionHandler(false) }
        UIApplication.shared.open(url, completionHandler: completionHandler)
    }
}

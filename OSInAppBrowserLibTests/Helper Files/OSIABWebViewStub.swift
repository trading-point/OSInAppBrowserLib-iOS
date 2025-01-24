import WebKit

class OSIABNavigationActionStub: WKNavigationAction {
    var urlRequest: URLRequest
    var mainDocumentURL: URL
    var useTargetFrame: Bool
    
    init(_ urlRequest: URLRequest, mainDocumentURL: URL? = nil, useTargetFrame: Bool = false) {
        self.urlRequest = urlRequest
        self.mainDocumentURL = mainDocumentURL ?? urlRequest.url!
        self.useTargetFrame = useTargetFrame
    }
    
    override var request: URLRequest {
        urlRequest.mainDocumentURL = mainDocumentURL
        return urlRequest
    }
    
    override var targetFrame: WKFrameInfo? {
        self.useTargetFrame ? .init() : nil
    }
    
}

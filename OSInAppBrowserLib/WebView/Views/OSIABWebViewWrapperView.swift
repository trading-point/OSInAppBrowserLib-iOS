import SwiftUI

/// View that manages which view to present, depending if the page load was successful or not or is being loaded.
@available(iOS 14.0, *)
struct OSIABWebViewWrapperView: View {
    /// View Model containing all the customisable elements.
    @StateObject private var model: OSIABWebViewModel

    /// Constructor method.
    /// - Parameter model: View Model containing all the customisable elements.
    init(_ model: OSIABWebViewModel) {
        self._model = StateObject(wrappedValue: model)
    }

    var body: some View {
        ZStack {
            OSIABWebView(model)
                .ignoresSafeArea(edges: model.toolbarPosition == .bottom ? [] : .bottom)
            if model.isLoading {
                ProgressView()
            }
        }
    }
}

// MARK: - OSIABViewModel's constructor accelerator.
private extension OSIABWebViewModel {
    convenience init(toolbarPosition: OSIABToolbarPosition = .defaultValue) {
        let configurationModel = OSIABWebViewConfigurationModel()
        self.init(
            urlRequest: .init(url: .init(string: "https://outsystems.com")!),
            configurationModel.toWebViewConfiguration(),
            uiModel: .init(toolbarPosition: toolbarPosition),
            callbackHandler: .init(
                onDelegateURL: { _ in },
                onDelegateAlertController: { _ in },
                onBrowserPageLoad: {},
                onBrowserClosed: { _ in }
            )
        )
    }

    convenience init(url: String) {
        self.init(urlRequest: .init(url: .init(string: url)!))
    }
    
    convenience init(urlRequest: URLRequest) {
        let configurationModel = OSIABWebViewConfigurationModel()
        self.init(
            urlRequest: urlRequest,
            configurationModel.toWebViewConfiguration(),
            uiModel: .init(),
            callbackHandler: .init(
                onDelegateURL: { _ in },
                onDelegateAlertController: { _ in },
                onBrowserPageLoad: {},
                onBrowserClosed: { _ in }
            )
        )
    }
}

@available(iOS 14.0, *)
struct OSIABWebViewWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        // Default - Light Mode
        OSIABWebViewWrapperView(.init())

        // Default - Dark Mode
        OSIABWebViewWrapperView(.init())
            .preferredColorScheme(.dark)

        // Bottom Toolbar Defined
        OSIABWebViewWrapperView(.init(toolbarPosition: .bottom))

        // Error View - Light mode
        OSIABWebViewWrapperView(.init(url: "https://outsystems/"))

        // Error View - Dark mode
        OSIABWebViewWrapperView(.init(url: "https://outsystems/"))
            .preferredColorScheme(.dark)
    }
}

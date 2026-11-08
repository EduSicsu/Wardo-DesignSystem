#if os(iOS)
import SwiftUI
import UIKit

/// Present with .sheet or .popover. UIKit supplies the device-specific activity layout.
public struct NativeActivityView: UIViewControllerRepresentable {
    private let items: [Any]
    private let excluded: [UIActivity.ActivityType]?
    private let completion: UIActivityViewController.CompletionWithItemsHandler?
    public init(items: [Any], excludedActivityTypes: [UIActivity.ActivityType]? = nil, completion: UIActivityViewController.CompletionWithItemsHandler? = nil) {
        self.items = items; excluded = excludedActivityTypes; self.completion = completion
    }
    public func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        controller.excludedActivityTypes = excluded
        controller.completionWithItemsHandler = completion
        return controller
    }
    public func updateUIViewController(_ controller: UIActivityViewController, context: Context) {}
}
#endif

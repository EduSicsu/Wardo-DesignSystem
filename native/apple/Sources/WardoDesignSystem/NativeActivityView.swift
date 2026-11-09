#if os(iOS)
import SwiftUI
import UIKit

/// Present from an anchored .popover (adapts to a sheet on compact iPhone).
/// UIKit supplies contacts, destinations, materials and device-specific layout.
/// Items and application activities are fixed for one presentation; recreate to share new content.
public struct NativeActivityView: UIViewControllerRepresentable {
    private let items: [Any]
    private let activities: [UIActivity]?
    private let excluded: [UIActivity.ActivityType]?
    private let completion: UIActivityViewController.CompletionWithItemsHandler?
    public init(items: [Any], excludedActivityTypes: [UIActivity.ActivityType]? = nil, completion: UIActivityViewController.CompletionWithItemsHandler? = nil, applicationActivities: [UIActivity]? = nil) {
        self.items = items; activities = applicationActivities; excluded = excludedActivityTypes; self.completion = completion
    }
    public func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: activities)
        controller.excludedActivityTypes = excluded
        controller.completionWithItemsHandler = completion
        return controller
    }
    public func updateUIViewController(_ controller: UIActivityViewController, context: Context) {
        controller.excludedActivityTypes = excluded
        controller.completionWithItemsHandler = completion
    }
}
#endif

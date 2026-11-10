import SwiftUI
import WardoDesignSystem

@main struct WardoCatalogueApp: App {
    var body: some Scene {
        WindowGroup {
            if ProcessInfo.processInfo.arguments.contains("--wardo-sidebar-search") {
                NavigationStack { SidebarSearchExample() }
            } else { CatalogueView() }
        }
    }
}
struct CatalogueView: View {
    @State private var theme = WardoTheme.wardoLight
    @State private var text = "Ceramics"
    @State private var enabled = true
    @State private var visionOn = false
    @State private var checked = true
    @State private var value = 0.5
    @State private var color = WardoRGBA(red: 1, green: 85.0 / 255, blue: 5.0 / 255)
    @State private var swatches = [WardoRGBA(red: 0, green: 0, blue: 0), WardoRGBA(red: 0, green: 0.48, blue: 1), WardoRGBA(red: 0.2, green: 0.78, blue: 0.35)]
    @State private var showColor = false
    @State private var alert = false
    @State private var date = Date()
    @State private var notice = "Ready"
    var body: some View {
        NavigationStack {
            List {
                Section("Appearance") {
                    Picker("Theme", selection: $theme) { ForEach(WardoTheme.allCases, id: \.self) { Text($0.rawValue).tag($0) } }
                }
                Section("Actions and inputs") {
                    WardoButton(action: { notice = "Button activated" }) { Text("Activate") }
                    WardoSearchField("Find events", text: $text) { notice = "Search: \(text)" }
                    WardoToggle("Notifications", isOn: $enabled)
                    Toggle("Vision notifications", isOn: $visionOn).toggleStyle(WardoVisionToggleStyle())
                    WardoCheckbox("Select reminders", isOn: $checked)
                    WardoTimePicker("Event time", selection: $date)
                    WardoSlider("System volume", value: $value)
                    WardoVisionSlider("Wardo volume", value: $value)
                    Text("Volume: \(Int(value * 100))%").accessibilityIdentifier("volume-value")
                    WardoVisionDatePicker("Event date", selection: $date, collapsed: true)
                    Button("Choose color") { showColor = true }
                    Button("Show alert") { alert = true }
                }
                Section("Navigation") {
                    NavigationLink { SidebarSearchExample() } label: { Text("Sidebar search example").frame(maxWidth: .infinity, alignment: .leading).frame(minHeight: 44).contentShape(Rectangle()) }
                    NavigationLink { SidebarExample() } label: { Text("Sidebar example").frame(maxWidth: .infinity, alignment: .leading).frame(minHeight: 44).contentShape(Rectangle()) }
                    NavigationLink { PagingExample() } label: { Text("Paging example").frame(maxWidth: .infinity, alignment: .leading).frame(minHeight: 44).contentShape(Rectangle()) }
                    NavigationLink { SliderExample() } label: { Text("Slider variants").frame(maxWidth: .infinity, alignment: .leading).frame(minHeight: 44).contentShape(Rectangle()) }
                    NavigationLink { SectionIndexExample() } label: { Text("Section index example").frame(maxWidth: .infinity, alignment: .leading).frame(minHeight: 44).contentShape(Rectangle()) }
                    NavigationLink { AppleNavigationItemExample() } label: { Text("Apple navigation item example").frame(maxWidth: .infinity, alignment: .leading).frame(minHeight: 44).contentShape(Rectangle()) }
                }
                Section("Presentations") {
                    NavigationLink { NativePresentationExample() } label: { Text("Native presentation examples").frame(maxWidth: .infinity, alignment: .leading).frame(minHeight: 44).contentShape(Rectangle()) }
                }
                Section("Swipe actions") {
                    WardoSwipeActionRow(leading: [.init(id: "archive", title: "Archive", systemImage: "archivebox", action: { notice = "Archived" })], trailing: [.init(id: "delete", title: "Delete", systemImage: "trash", role: .destructive, tint: .red, action: { notice = "Deleted" })]) { Text("Swipe this row") }
                }
                Section("Feedback") { WardoProgress("Loading", value: value) }
            }.navigationTitle("Wardo native catalogue")
                .safeAreaInset(edge: .bottom) { Text(notice).font(.footnote).frame(maxWidth: .infinity).padding().background(.regularMaterial).accessibilityIdentifier("action-status") }
                .alert("Wardo alert", isPresented: $alert) { Button("Continue") { notice = "Alert confirmed" }; Button("Cancel", role: .cancel) {} } message: { Text("Native system presentation") }
                .sheet(isPresented: $showColor) { ScrollView { WardoVisionColorPicker(selection: $color, swatches: $swatches, onClose: { showColor = false }) }.padding() }
        }.wardoTheme(theme)
    }
}

struct SidebarSearchExample: View {
    @State private var query = ""
    @State private var rtl = false
    @State private var disabled = false
    @State private var largeText = false
    @State private var dark = false
    @State private var status = "Ready"
    var body: some View {
        Form {
            Section("Native sidebar search") {
                WardoSidebarSearchField("Search events", text: $query, onSubmit: {
                    status = "Search submitted: \(query)"
                }, onVoiceSearch: {
                    status = "Voice search requested"
                })
                .environment(\.layoutDirection, rtl ? .rightToLeft : .leftToRight)
                .dynamicTypeSize(largeText ? .accessibility3 : .large)
                .disabled(disabled)
                Text("Query: \(query)").accessibilityIdentifier("sidebar-search-query")
                Text(status).accessibilityIdentifier("sidebar-search-status")
            }
            Section("Appearance and behavior") {
                Toggle("Right-to-left search", isOn: $rtl)
                Toggle("Disable search", isOn: $disabled)
                Toggle("Larger search text", isOn: $largeText)
                Toggle("Dark search appearance", isOn: $dark)
                Button("Set query from application") { query = "Ceramics" }
                Button("Clear query from application") { query = "" }
            }
        }
        .navigationTitle("Sidebar search")
        .wardoTheme(dark ? .wardoDark : .wardoLight)
    }
}

struct PagingExample: View {
    @State private var page = 0
    @State private var rtl = false
    @State private var count = 5
    var body: some View {
        VStack(spacing: 20) {
            Toggle("Right-to-left paging", isOn: $rtl)
            WardoPageControl("Document pages", selection: $page, count: count)
                .environment(\.layoutDirection, rtl ? .rightToLeft : .leftToRight)
            Text("Selected page: \(page + 1) of \(count)").accessibilityIdentifier("paging-selection")
            HStack {
                Button("Previous page") { page = max(0, page - 1) }.disabled(page == 0)
                Button("Next page") { page = min(count - 1, page + 1) }.disabled(page == count - 1)
            }
            Button("Use two pages") { count = 2; page = min(page, 1) }
        }.padding().navigationTitle("Paging example")
    }
}

struct SliderExample: View {
    @State private var size = WardoVisionSliderSize.regular
    @State private var filled = 0.5
    @State private var stepped = 0.5
    @State private var color = 0.5
    @State private var enabled = true
    @State private var rtl = false
    @State private var editing = false
    var body: some View {
        VStack(spacing: 20) {
            Picker("Slider size", selection: $size) {
                ForEach(WardoVisionSliderSize.allCases, id: \.self) { size in Text(String(describing: size).capitalized).tag(size) }
            }.pickerStyle(.segmented)
            Toggle("Enable sliders", isOn: $enabled)
            Toggle("Right-to-left sliders", isOn: $rtl)
            VStack(spacing: 16) {
                WardoVisionLabeledSlider("Filled volume", value: $filled, size: size) { Image(systemName: "speaker.fill").frame(width: 20, height: 20) } maximumValueLabel: { Image(systemName: "speaker.wave.3.fill").frame(width: 20, height: 20) }
                WardoVisionLabeledSlider("Stepped volume", value: $stepped, size: size, appearance: .segmented, onEditingChanged: { editing = $0 }) { Image(systemName: "speaker.fill").frame(width: 20, height: 20) } maximumValueLabel: { Image(systemName: "speaker.wave.3.fill").frame(width: 20, height: 20) }
                WardoVisionSlider("Colour mix", value: $color, appearance: .color)
            }.disabled(!enabled).environment(\.layoutDirection, rtl ? .rightToLeft : .leftToRight)
            Text("Stepped value: \(Int((stepped * 100).rounded()))%").accessibilityIdentifier("stepped-value")
            Text(editing ? "Editing slider" : "Slider idle").accessibilityIdentifier("slider-editing")
            Button("Reset stepped value") { stepped = 0 }
        }.padding().navigationTitle("Slider variants")
    }
}

struct SectionIndexExample: View {
    private let sections = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ#").map(String.init)
    @State private var selection: String? = "A"
    @State private var rtl = false
    @State private var enabled = true
    var body: some View {
        VStack(spacing: 12) {
            Toggle("Right-to-left section index", isOn: $rtl)
            Toggle("Enable section index", isOn: $enabled)
            ScrollViewReader { proxy in
                HStack {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 16) {
                            ForEach(sections, id: \.self) { section in
                                VStack(alignment: .leading) {
                                    Text("Section \(section)").font(.headline)
                                    ForEach(1...3, id: \.self) { row in Text("\(section) item \(row)").padding(.vertical, 12) }
                                }.id(section)
                            }
                        }.frame(maxWidth: .infinity, alignment: .leading)
                    }.frame(height: 466)
                    WardoIndexBar(sections: sections, selection: $selection) { target in
                        proxy.scrollTo(target, anchor: .top)
                    }.disabled(!enabled).accessibilityIdentifier("section-index")
                }.environment(\.layoutDirection, rtl ? .rightToLeft : .leftToRight)
                .safeAreaInset(edge: .bottom) {
                    Button("Go to last section") { selection = "#"; proxy.scrollTo("#", anchor: .top) }
                }
            }
            Text("Selected section: \(selection ?? "None")").accessibilityIdentifier("selected-section")
        }.padding().navigationTitle("Section index example")
    }
}

struct SidebarExample: View {
    @State private var selection = "Inbox"
    @State private var rtl = false
    @State private var expanded = true
    var body: some View {
        VStack(spacing: 0) {
            Toggle("Right-to-left layout", isOn: $rtl).padding()
            WardoVisionSidebar("Collections", actions: {
                Button("Reset") { selection = "Inbox" }
            }, rows: {
                WardoVisionSidebarItem("Inbox", counter: "42", selected: selection == "Inbox", action: { selection = "Inbox" }) { Image(systemName: "tray") }.accessibilityIdentifier("sidebar-inbox")
                WardoVisionSidebarGroup("Library", isExpanded: $expanded) {
                WardoVisionSidebarItem("Saved", counter: "3", selected: selection == "Saved", action: { selection = "Saved" }) { Image(systemName: "bookmark") }.accessibilityIdentifier("sidebar-saved")
                WardoVisionSidebarItem("Archive", selected: selection == "Archive", action: { selection = "Archive" }) { Image(systemName: "archivebox") }
                }
            }).environment(\.layoutDirection, rtl ? .rightToLeft : .leftToRight)
            Text("Selected: \(selection)").padding().accessibilityIdentifier("sidebar-selection")
        }.navigationTitle("Sidebar example")
    }
}

struct AppleNavigationItemExample: View {
    @Environment(\.wardoTheme) private var theme
    @State private var selection = "None"
    @State private var rtl = false
    @State private var enabled = true
    @State private var largeText = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Toggle("Right-to-left destination items", isOn: $rtl)
                Toggle("Enable destination items", isOn: $enabled)
                Toggle("Large navigation text", isOn: $largeText)
                VStack(alignment: .leading, spacing: 16) {
                    WardoAppleNavigationItem("Sidebar destination", layout: .horizontal, selected: selection == "Sidebar", badge: "3", badgeDescription: "3 unread items", action: { selection = "Sidebar" }) { wardoNavigationImage(.events).resizable().scaledToFit() }
                    WardoAppleNavigationItem("Tab destination", layout: .vertical, selected: selection == "Tab", action: { selection = "Tab" }) { wardoNavigationImage(.saved).resizable().scaledToFit() }
                    WardoAppleNavigationItem("Text destination", layout: .textOnly, selected: selection == "Text", action: { selection = "Text" }) { EmptyView() }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .dynamicTypeSize(largeText ? .accessibility3 : .large)
                .environment(\.layoutDirection, rtl ? .rightToLeft : .leftToRight)
                .disabled(!enabled)
                Text("Selected destination: \(selection)").accessibilityIdentifier("apple-destination-selection")
                HStack(spacing: 24) {
                    ForEach(WardoNavigationGlyph.allCases, id: \.self) { glyph in
                        wardoNavigationImage(glyph).resizable().scaledToFit().frame(width: 24, height: 24)
                    }
                }.foregroundStyle(WardoColorToken.textPrimary.color(in: theme)).accessibilityHidden(true)
            }.padding()
        }.navigationTitle("Wardo destination items")
    }
}

struct NativePresentationExample: View {
    @State private var showAlert = false
    @State private var fields = true
    @State private var secondField = true
    @State private var stackedActions = true
    @State private var title = ""
    @State private var detail = ""
    @State private var status = "Ready"
    @State private var showSheet = false
    @State private var showActivity = false
    @State private var dark = false
    var body: some View {
        Form {
            Section("System alert") {
                Toggle("Include alert fields", isOn: $fields)
                Toggle("Include second alert field", isOn: $secondField).disabled(!fields)
                Toggle("Include destructive alert action", isOn: $stackedActions)
                Button("Present native alert") { showAlert = true }
                    .modifier(NativeAlertModifier("Edit event", isPresented: $showAlert, message: "Update this event's details.") {
                        if fields {
                            TextField("Event name", text: $title)
                            if secondField { SecureField("Access code", text: $detail) }
                        }
                        Button("Save event") { status = "Saved: \(title)" }
                            .disabled(fields && title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        if stackedActions { Button("Delete event", role: .destructive) { status = "Deleted event" } }
                        Button("Cancel", role: .cancel) { status = "Alert cancelled" }
                    })
            }
            Section("Native context menu") {
                Text("Event context actions")
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .contentShape(Rectangle())
                    .modifier(NativeContextMenuPreviewModifier(items: {
                        Button("Save to collection", systemImage: "bookmark") { status = "Added to collection" }
                        Button("Unavailable action", systemImage: "pencil") {}.disabled(true)
                        Section("More actions") {
                            Menu("Move event") {
                                Button("Move to archive") { status = "Moved to archive" }
                            }
                            Button("Remove event", systemImage: "trash", role: .destructive) { status = "Removed event" }
                        }
                    }, preview: {
                        Label("Event preview", systemImage: "calendar").padding().frame(minWidth: 220, minHeight: 140)
                    }))
            }
            #if os(iOS)
            Section("System sheet and sharing") {
                Button("Present native page sheet") { showSheet = true }
                    .modifier(NativePageSheetModifier(isPresented: $showSheet, onDismiss: { status = "Page sheet dismissed" }) {
                        NativePageSheetExample(level: 1)
                    })
                Button("Present native share activity") { showActivity = true }
                    .popover(isPresented: $showActivity, attachmentAnchor: .rect(.bounds), arrowEdge: .bottom) {
                        NativeActivityView(items: ["Wardo event"], completion: { activity, completed, _, error in
                            if let error { status = "Share failed: \(error.localizedDescription)" }
                            else { status = completed ? "Share completed" : "Share cancelled" }
                        })
                    }
            }
            #endif
            Section("Appearance") { Toggle("Dark native presentations", isOn: $dark) }
            Section("Application callback") { Text(status).accessibilityIdentifier("native-presentation-status") }
        }
        .preferredColorScheme(dark ? .dark : .light)
        .navigationTitle("Native presentations")
    }
}

#if os(iOS)
struct NativePageSheetExample: View {
    @Environment(\.dismiss) private var dismiss
    @State private var stacked = false
    @State private var saved = false
    let level: Int
    var body: some View {
        NavigationStack {
            Form {
                Text("Sheet level \(level)").accessibilityIdentifier("native-sheet-level")
                if level == 1 {
                    Button("Stack another sheet") { stacked = true }
                        .modifier(NativePageSheetModifier(isPresented: $stacked) { NativePageSheetExample(level: 2) })
                }
                Text(saved ? "Sheet changes saved" : "Sheet content")
            }
            .navigationTitle("Event details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close sheet \(level)", systemImage: "xmark") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save sheet changes", systemImage: "arrow.up") { saved = true }
                }
            }
        }
    }
}
#endif

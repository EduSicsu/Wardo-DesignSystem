package com.wardo.xrcatalogue

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.selection.selectableGroup
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.LayoutDirection
import androidx.compose.ui.platform.LocalLayoutDirection
import androidx.compose.ui.platform.testTag
import com.wardo.designsystem.*
import com.wardo.designsystem.xr.*

class XrCatalogueActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent { XrCatalogue() }
    }
}
@Composable fun XrCatalogue() {
    var notice by remember { mutableStateOf("Ready") }
    var dialog by remember { mutableStateOf(false) }
    var railExample by remember { mutableStateOf(false) }
    var itemExample by remember { mutableStateOf(false) }
    var artworkExample by remember { mutableStateOf(false) }
    WardoTheme {
        WardoSpatialPanel {
            Surface(Modifier.fillMaxSize()) {
                if (artworkExample) ToolbarArtworkExample(onBack = { artworkExample = false })
                else if (itemExample) NavigationItemExample(onBack = { itemExample = false })
                else if (railExample) ExpandedRailExample(onBack = { railExample = false })
                else Column(Modifier.padding(40.dp), verticalArrangement = Arrangement.spacedBy(24.dp)) {
                    Text("Wardo XR catalogue", style = MaterialTheme.typography.headlineLarge)
                    Text("Move and resize this panel using the system controls.")
                    Button(onClick = { notice = "Panel activated" }) { Text("Activate panel") }
                    Button(onClick = { dialog = true }) { Text("Show spatial dialog") }
                    Button(onClick = { railExample = true }) { Text("Expanded navigation example") }
                    Button(onClick = { itemExample = true }) { Text("Android navigation item example") }
                    Button(onClick = { artworkExample = true }) { Text("Android toolbar artwork example") }
                    Text(notice)
                }
            }
            WardoSpatialToolbar {
                WardoButton(hierarchy = WardoHierarchy.Text, onClick = { notice = "Toolbar activated" }) { Text("Toolbar action") }
            }
            if (dialog) WardoSpatialDialog("Spatial confirmation", onDismissRequest = { dialog = false }, actions = {
                WardoButton(hierarchy = WardoHierarchy.Text, onClick = { dialog = false }) { Text("Cancel") }
                WardoButton(hierarchy = WardoHierarchy.Text, onClick = { notice = "Spatial dialog confirmed"; dialog = false }) { Text("Confirm") }
            }) { Text("Presentation state belongs to this sample application.") }
        }
    }
}

@Composable private fun ToolbarArtworkExample(onBack: () -> Unit) {
    var activated by remember { mutableStateOf("None") }
    Column(Modifier.padding(24.dp), verticalArrangement = Arrangement.spacedBy(16.dp)) {
        Text("Exact Android toolbar artwork")
        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
            WardoToolbarGlyph.entries.forEach { glyph ->
                WardoToolbarIconButton(onClick = { activated = glyph.name }) {
                    WardoToolbarArtwork(glyph, contentDescription = "Activate ${glyph.name}")
                }
            }
        }
        Text("Artwork activated: $activated")
        WardoButton(hierarchy = WardoHierarchy.Text, onClick = onBack) { Text("Back to XR catalogue") }
    }
}

/** Android's 2D compatibility specimens, deliberately separate from native XR navigation. */
@Composable private fun NavigationItemExample(onBack: () -> Unit) {
    var selected by remember { mutableStateOf("none") }
    var rtl by remember { mutableStateOf(false) }
    var enabled by remember { mutableStateOf(true) }
    var barCount by remember { mutableIntStateOf(4) }
    var barSelected by remember { mutableStateOf("0") }
    Column(Modifier.padding(24.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
        Text("Android navigation item compatibility")
        Text("Selected item: $selected")
        CompositionLocalProvider(LocalLayoutDirection provides if (rtl) LayoutDirection.Rtl else LayoutDirection.Ltr) {
            Row(Modifier.selectableGroup(), horizontalArrangement = Arrangement.spacedBy(16.dp)) {
                WardoRailItem(selected == "rail", { selected = "rail" }, "Rail destination", icon = { WardoNavigationArtwork(WardoNavigationGlyph.Events) }, enabled = enabled, badge = "3", badgeContentDescription = "3 unread messages")
                WardoNavigationBarItem(selected == "bar", { selected = "bar" }, "Bar destination", icon = { WardoNavigationArtwork(WardoNavigationGlyph.Saved) }, enabled = enabled)
                WardoNavigationItem(selected == "text", { selected = "text" }, "Text destination", icon = {}, layout = WardoNavigationItemLayout.TextOnly, enabled = enabled)
            }
        }
        WardoButton(hierarchy = WardoHierarchy.Text, onClick = { rtl = !rtl }) { Text("Toggle item RTL") }
        WardoButton(hierarchy = WardoHierarchy.Text, onClick = { enabled = !enabled }) { Text("Toggle items enabled") }
        Row {
            (3..5).forEach { count -> WardoButton(hierarchy = WardoHierarchy.Text, onClick = { barCount = count }) { Text("$count bar destinations") } }
        }
        Text("Native bar selection: $barSelected")
        Row(horizontalArrangement = Arrangement.spacedBy(16.dp)) {
            WardoNavigationGlyph.entries.forEach { glyph -> WardoNavigationArtwork(glyph) }
        }
        CompositionLocalProvider(LocalLayoutDirection provides if (rtl) LayoutDirection.Rtl else LayoutDirection.Ltr) {
            WardoNavigationBar(
                destinations = (0 until barCount).map { WardoDestination("$it", "Native destination $it") },
                selectedId = barSelected, onSelect = { barSelected = it }, modifier = Modifier.width(412.dp).testTag("native-short-bar"),
                icon = { destination -> Text(destination.id) },
            )
        }
        WardoButton(hierarchy = WardoHierarchy.Text, onClick = onBack) { Text("Back to XR catalogue") }
    }
}

/** Numbered icon slots deliberately exercise caller-owned content, not Figma artwork. */
@Composable private fun ExpandedRailExample(onBack: () -> Unit) {
    var selected by remember { mutableIntStateOf(0) }
    var rtl by remember { mutableStateOf(false) }
    var floating by remember { mutableStateOf(false) }
    var centered by remember { mutableStateOf(false) }
    var message by remember { mutableStateOf("Navigation ready") }
    Row(Modifier.fillMaxSize()) {
        CompositionLocalProvider(LocalLayoutDirection provides if (rtl) LayoutDirection.Rtl else LayoutDirection.Ltr) {
            WardoExpandedNavigationRail(
                surface = if (floating) WardoRailSurface.Floating else WardoRailSurface.Docked,
                alignment = if (centered) WardoRailAlignment.Middle else WardoRailAlignment.Top,
                menu = { WardoButton(hierarchy = WardoHierarchy.Text, onClick = { message = "Menu activated" }) { Text("Rail menu") } },
                floatingActionButton = { Button(onClick = { message = "Create activated" }) { Text("Create") } },
            ) {
                listOf("Events", "Saved", "Reviews").forEachIndexed { index, title ->
                    WardoExpandedRailItem(selected == index, { selected = index }, icon = { Text("${index + 1}") }, label = { Text(title) })
                }
            }
        }
        Column(Modifier.padding(24.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
            Text("Selected destination: $selected")
            Text(message)
            WardoButton(hierarchy = WardoHierarchy.Text, onClick = { rtl = !rtl }) { Text("Toggle rail RTL") }
            WardoButton(hierarchy = WardoHierarchy.Text, onClick = { floating = !floating }) { Text("Toggle floating rail") }
            WardoButton(hierarchy = WardoHierarchy.Text, onClick = { centered = !centered }) { Text("Toggle centered rail") }
            WardoButton(hierarchy = WardoHierarchy.Text, onClick = onBack) { Text("Back to XR catalogue") }
        }
    }
}

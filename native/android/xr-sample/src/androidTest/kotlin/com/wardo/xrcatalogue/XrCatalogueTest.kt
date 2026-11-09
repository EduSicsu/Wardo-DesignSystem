package com.wardo.xrcatalogue

import android.app.Activity
import android.app.Instrumentation
import android.content.Intent
import android.os.ParcelFileDescriptor
import androidx.compose.ui.test.*
import androidx.compose.ui.test.junit4.v2.createEmptyComposeRule
import androidx.compose.ui.unit.dp
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.SemanticsProperties
import android.graphics.Bitmap
import java.io.File
import androidx.test.platform.app.InstrumentationRegistry
import org.junit.*
import org.junit.Assert.*

/** Launch XR activities through the shell, then query every registered Compose panel root. */
class XrCatalogueTest {
    @get:Rule val compose = createEmptyComposeRule()
    private val instrumentation = InstrumentationRegistry.getInstrumentation()
    private var activity: Activity? = null
    private var monitor: Instrumentation.ActivityMonitor? = null
    @Before fun launch() {
        monitor = instrumentation.addMonitor(XrCatalogueActivity::class.java.name, null, false)
        val flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        val result = instrumentation.uiAutomation.executeShellCommand("am start -f $flags -n com.wardo.xrcatalogue/.XrCatalogueActivity")
        val output = ParcelFileDescriptor.AutoCloseInputStream(result).bufferedReader().use { it.readText() }
        assertFalse("XR launch failed: $output", output.contains("Error:"))
        activity = monitor!!.waitForActivityWithTimeout(20_000)
        assertNotNull("The XR activity must launch", activity)
    }
    @After fun close() {
        activity?.let { current -> instrumentation.runOnMainSync { current.finish() } }
        monitor?.let { instrumentation.removeMonitor(it) }
    }
    @Test fun spatialPanelAndOrbiterUpdateApplicationState() {
        compose.onNodeWithText("Activate panel").performClick()
        compose.onNodeWithText("Panel activated").assertExists()
        compose.onNodeWithText("Toolbar action").performClick()
        compose.onNodeWithText("Toolbar activated").assertExists()
    }
    @Test fun spatialDialogConfirmsAndDismisses() {
        compose.onNodeWithText("Show spatial dialog").performClick()
        compose.onNodeWithText("Spatial confirmation").assertExists()
        compose.onNodeWithText("Confirm").performClick()
        compose.onNodeWithText("Spatial dialog confirmed").assertExists()
        compose.onNodeWithText("Spatial confirmation").assertDoesNotExist()
    }
    @Test fun expandedRailSelectionActionsAndRTLRemainApplicationOwned() {
        compose.onNodeWithText("Expanded navigation example").performClick()
        compose.onNodeWithText("Saved").assertWidthIsAtLeast(48.dp).assertHeightIsAtLeast(48.dp).performClick().assertIsSelected()
        compose.onNodeWithText("Selected destination: 1").assertExists()
        compose.onNodeWithText("Rail menu").performClick()
        compose.onNodeWithText("Menu activated").assertExists()
        compose.onNodeWithText("Create").performClick()
        compose.onNodeWithText("Create activated").assertExists()
        compose.onNodeWithText("Toggle rail RTL").performClick()
        compose.onNodeWithText("Reviews").performClick().assertIsSelected()
        compose.onNodeWithText("Selected destination: 2").assertExists()
        compose.onNodeWithText("Toggle floating rail").performClick()
        compose.onNodeWithText("Toggle centered rail").performClick()
        compose.onNodeWithText("Events").performClick().assertIsSelected()
        compose.onNodeWithText("Selected destination: 0").assertExists()
    }
    @Test fun androidNavigationItemsExposeIndependentSelectionAndDisabledState() {
        compose.onNodeWithText("Android navigation item example").performClick()
        val role = SemanticsMatcher.expectValue(SemanticsProperties.Role, Role.Tab)
        val rail = compose.onNode(hasText("Rail destination") and role)
        val bar = compose.onNode(hasText("Bar destination") and role)
        val text = compose.onNode(hasText("Text destination") and role)
        rail.assertWidthIsEqualTo(240.dp).assertHeightIsAtLeast(48.dp).assertIsNotSelected().performClick().assertIsSelected()
        compose.onNodeWithText("Selected item: rail").assertExists()
        compose.onNodeWithContentDescription("3 unread messages").assertExists()
        bar.assertWidthIsEqualTo(88.dp).assertHeightIsAtLeast(64.dp).performClick().assertIsSelected()
        rail.assertIsNotSelected()
        text.assertWidthIsEqualTo(148.dp).assertHeightIsAtLeast(48.dp).performClick().assertIsSelected()
        val originalRailX = rail.getUnclippedBoundsInRoot().left
        compose.onNodeWithText("Toggle item RTL").performClick()
        assertTrue("Sibling order follows the RTL environment", rail.getUnclippedBoundsInRoot().left > originalRailX)
        rail.performClick().assertIsSelected()
        compose.onNodeWithText("Selected item: rail").assertExists()
        compose.onNodeWithText("Toggle items enabled").performClick()
        rail.assertIsNotEnabled()
        bar.assertIsNotEnabled()
        text.assertIsNotEnabled()
        bar.performClick()
        compose.onNodeWithText("Selected item: rail").assertExists()
    }
    @Test fun nativeShortNavigationBarSupportsDestinationCountsAndRTL() {
        compose.onNodeWithText("Android navigation item example").performClick()
        val role = SemanticsMatcher.expectValue(SemanticsProperties.Role, Role.Tab)
        for (count in 3..5) {
            compose.onNodeWithText("$count bar destinations").performClick()
            val last = compose.onNode(hasText("Native destination ${count - 1}") and role)
            last.assertHeightIsAtLeast(64.dp).assertWidthIsAtLeast(48.dp)
            last.assertWidthIsEqualTo((412f / count).dp)
            last.performClick().assertIsSelected()
            compose.onNodeWithText("Native bar selection: ${count - 1}").assertExists()
            compose.onNodeWithText("Native destination $count").assertDoesNotExist()
            saveBarPreview("android-short-bar-$count-ltr.png")
        }
        val first = compose.onNode(hasText("Native destination 0") and role)
        val originalX = first.getUnclippedBoundsInRoot().left
        compose.onNodeWithText("Toggle item RTL").performClick()
        assertTrue("Native bar follows RTL order", first.getUnclippedBoundsInRoot().left > originalX)
        first.performClick().assertIsSelected()
        compose.onNodeWithText("Native bar selection: 0").assertExists()
        saveBarPreview("android-short-bar-5-rtl.png")
    }
    private fun saveBarPreview(name: String) {
        // XR panels are rendered by a separate compositor; PixelCopy of their
        // 2D host window returns an empty frame. Capture the device scene instead.
        val image = checkNotNull(instrumentation.uiAutomation.takeScreenshot())
        File(instrumentation.targetContext.filesDir, name).outputStream().use { output ->
            assertTrue("Native preview must encode", image.compress(Bitmap.CompressFormat.PNG, 100, output))
        }
    }
    @Test fun exactToolbarArtworkResourcesLoadAndActionsHaveAccessibleNames() {
        compose.onNodeWithText("Android toolbar artwork example").performClick()
        for (name in listOf("Stars", "StarsFilled", "Share", "Comment", "Download", "Edit", "MoreVert", "Image")) {
            compose.onNodeWithContentDescription("Activate $name").assertWidthIsAtLeast(48.dp).assertHeightIsAtLeast(48.dp).performClick()
            compose.onNodeWithText("Artwork activated: $name").assertExists()
        }
        saveBarPreview("android-toolbar-artwork-scene.png")
    }
}

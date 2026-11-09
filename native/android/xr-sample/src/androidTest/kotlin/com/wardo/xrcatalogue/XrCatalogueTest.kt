package com.wardo.xrcatalogue

import android.app.Activity
import android.app.Instrumentation
import android.content.Intent
import android.os.ParcelFileDescriptor
import androidx.compose.ui.test.*
import androidx.compose.ui.test.junit4.v2.createEmptyComposeRule
import androidx.compose.ui.unit.dp
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
}

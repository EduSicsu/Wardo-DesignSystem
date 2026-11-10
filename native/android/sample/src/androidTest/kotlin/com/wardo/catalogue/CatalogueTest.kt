package com.wardo.catalogue

import androidx.compose.ui.test.*
import androidx.compose.ui.test.junit4.createAndroidComposeRule
import org.junit.Rule
import org.junit.Test

class CatalogueTest {
    @get:Rule val compose = createAndroidComposeRule<CatalogueActivity>()
    @Test fun inputAndActionsUpdateApplicationState() {
        compose.onNodeWithText("Activate").performClick()
        compose.onNodeWithText("Button activated").assertExists()
        compose.onNode(hasSetTextAction()).performTextReplacement("Books")
        compose.onNode(hasSetTextAction()).assertTextContains("Books")
        compose.onNodeWithContentDescription("Notifications").assertIsOn().performClick().assertIsOff()
    }
    @Test fun dialogConfirmAndDismissRemainApplicationOwned() {
        compose.onNodeWithText("Show alert").performClick()
        compose.onNodeWithText("Wardo alert").assertExists()
        compose.onNodeWithText("Confirm").performClick()
        compose.onNodeWithText("Alert confirmed").assertExists()
        compose.onNodeWithText("Wardo alert").assertDoesNotExist()
    }
}

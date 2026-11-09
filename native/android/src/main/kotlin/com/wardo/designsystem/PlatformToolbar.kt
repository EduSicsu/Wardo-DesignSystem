package com.wardo.designsystem

import androidx.compose.foundation.layout.RowScope
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier

enum class WardoToolbarPosition { Top, Bottom }

@Composable
fun WardoPlatformToolbar(title: String, position: WardoToolbarPosition = WardoToolbarPosition.Top, modifier: Modifier = Modifier, navigationIcon: @Composable () -> Unit = {}, actions: @Composable RowScope.() -> Unit = {}) {
    when (position) {
        WardoToolbarPosition.Top -> WardoTopAppBar(title, modifier, navigationIcon, actions)
        WardoToolbarPosition.Bottom -> WardoBottomAppBar(modifier, actions)
    }
}

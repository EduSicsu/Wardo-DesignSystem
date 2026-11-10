package com.wardo.designsystem

import androidx.compose.foundation.layout.size
import androidx.compose.material3.Icon
import androidx.compose.material3.LocalContentColor
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp

enum class WardoNavigationGlyph { Events, Saved, Notifications, Profile }

/** Source SVG geometry with caller-owned semantic tint and optional description. */
@Composable
fun WardoNavigationArtwork(
    glyph: WardoNavigationGlyph,
    contentDescription: String? = null,
    modifier: Modifier = Modifier,
    tint: Color = LocalContentColor.current,
) {
    val resource = when (glyph) {
        WardoNavigationGlyph.Events -> R.drawable.wardo_navigation_events
        WardoNavigationGlyph.Saved -> R.drawable.wardo_navigation_saved
        WardoNavigationGlyph.Notifications -> R.drawable.wardo_navigation_notifications
        WardoNavigationGlyph.Profile -> R.drawable.wardo_navigation_profile
    }
    Icon(painterResource(resource), contentDescription, modifier.size(24.dp), tint)
}

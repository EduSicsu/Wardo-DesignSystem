package com.wardo.designsystem

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.RectangleShape
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

enum class WardoRailSurface { Docked, Floating }
enum class WardoRailAlignment { Top, Middle }

/**
 * Expanded Material navigation, distinct from the compact WardoNavigationRail.
 * The application supplies actions, destination state and optional section content.
 * Native layout owns insets, focus, minimum targets and expanded item placement.
 */
@Composable
fun WardoExpandedNavigationRail(
    modifier: Modifier = Modifier,
    surface: WardoRailSurface = WardoRailSurface.Docked,
    alignment: WardoRailAlignment = WardoRailAlignment.Top,
    menu: (@Composable () -> Unit)? = null,
    floatingActionButton: (@Composable () -> Unit)? = null,
    content: @Composable () -> Unit,
) {
    val colors = LocalWardoColors.current
    WideNavigationRail(
        modifier = modifier,
        state = rememberWideNavigationRailState(WideNavigationRailValue.Expanded),
        shape = if (surface == WardoRailSurface.Floating) RoundedCornerShape(16.dp) else RectangleShape,
        colors = WideNavigationRailDefaults.colors(
            containerColor = if (surface == WardoRailSurface.Floating) colors.backgroundRaised else Color.Transparent,
            contentColor = colors.textPrimary,
        ),
        arrangement = if (alignment == WardoRailAlignment.Middle) Arrangement.Center else Arrangement.Top,
        header = {
            Column(Modifier.padding(horizontal = 20.dp), verticalArrangement = Arrangement.spacedBy(4.dp)) {
                Box(Modifier.heightIn(min = 56.dp)) { menu?.invoke() }
                Box(Modifier.heightIn(min = 56.dp)) { floatingActionButton?.invoke() }
            }
        },
        content = content,
    )
}

@Composable
fun WardoExpandedRailItem(
    selected: Boolean,
    onClick: () -> Unit,
    icon: @Composable () -> Unit,
    label: @Composable () -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
) {
    val colors = LocalWardoColors.current
    WideNavigationRailItem(
        selected = selected,
        onClick = onClick,
        icon = icon,
        label = {
            ProvideTextStyle(MaterialTheme.typography.labelLarge.copy(fontSize = 14.sp, lineHeight = 19.6.sp, fontWeight = FontWeight.Medium)) { label() }
        },
        railExpanded = true,
        modifier = modifier,
        enabled = enabled,
        colors = WideNavigationRailItemDefaults.colors(
            selectedIconColor = colors.actionPrimaryForeground,
            selectedTextColor = colors.actionPrimaryForeground,
            selectedIndicatorColor = colors.backgroundRaised,
            unselectedIconColor = colors.textPrimary,
            unselectedTextColor = colors.textPrimary,
        ),
    )
}

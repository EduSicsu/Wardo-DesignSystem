package com.wardo.designsystem

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.unit.dp

enum class WardoToolbarSurface { Standard, Vibrant, SurfaceHigh, TertiaryContainer, Surface }

@Composable
fun WardoSymbol(imageVector: ImageVector, contentDescription: String?, modifier: Modifier = Modifier, tint: Color = LocalContentColor.current) {
    Icon(imageVector, contentDescription, modifier.size(24.dp), tint)
}

@Composable
private fun toolbarContainer(surface: WardoToolbarSurface): Color = when (surface) {
    WardoToolbarSurface.Standard -> Color.Transparent
    WardoToolbarSurface.Vibrant -> MaterialTheme.colorScheme.primaryContainer
    WardoToolbarSurface.SurfaceHigh -> MaterialTheme.colorScheme.surfaceContainerHigh
    WardoToolbarSurface.TertiaryContainer -> MaterialTheme.colorScheme.tertiaryContainer
    WardoToolbarSurface.Surface -> MaterialTheme.colorScheme.surface
}

@Composable
fun WardoToolbarIconButton(onClick: () -> Unit, modifier: Modifier = Modifier, enabled: Boolean = true, surface: WardoToolbarSurface = WardoToolbarSurface.Standard, content: @Composable () -> Unit) {
    FilledIconButton(onClick, modifier.sizeIn(minWidth = 48.dp, minHeight = 48.dp), enabled, colors = IconButtonDefaults.filledIconButtonColors(containerColor = toolbarContainer(surface)), content = content)
}

@Composable
fun WardoToolbarIconToggle(checked: Boolean, onCheckedChange: (Boolean) -> Unit, modifier: Modifier = Modifier, enabled: Boolean = true, surface: WardoToolbarSurface = WardoToolbarSurface.Standard, content: @Composable () -> Unit) {
    FilledIconToggleButton(checked, onCheckedChange, modifier.sizeIn(minWidth = 48.dp, minHeight = 48.dp), enabled, colors = IconButtonDefaults.filledIconToggleButtonColors(containerColor = toolbarContainer(surface)), content = content)
}

@Composable
fun WardoToolbarTextToggle(checked: Boolean, onCheckedChange: (Boolean) -> Unit, label: String, modifier: Modifier = Modifier, enabled: Boolean = true, surface: WardoToolbarSurface = WardoToolbarSurface.Standard) {
    // FilterChip supplies selected state, click action, focus, and screen-reader semantics.
    FilterChip(selected = checked, onClick = { onCheckedChange(!checked) }, label = { Text(label) }, modifier = modifier.defaultMinSize(minHeight = 48.dp), enabled = enabled, colors = FilterChipDefaults.filterChipColors(containerColor = toolbarContainer(surface)))
}

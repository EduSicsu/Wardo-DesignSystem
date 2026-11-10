package com.wardo.designsystem

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

enum class WardoHierarchy { Primary, Secondary, Outline, Text }

@Composable
fun WardoButton(onClick: () -> Unit, modifier: Modifier = Modifier, enabled: Boolean = true, hierarchy: WardoHierarchy = WardoHierarchy.Primary, content: @Composable RowScope.() -> Unit) {
    val shape = RoundedCornerShape(8.dp)
    val sized = modifier.defaultMinSize(minHeight = 48.dp)
    when (hierarchy) {
        WardoHierarchy.Primary -> Button(onClick, sized, enabled, shape = shape, content = content)
        WardoHierarchy.Secondary -> FilledTonalButton(onClick, sized, enabled, shape = shape, content = content)
        WardoHierarchy.Outline -> OutlinedButton(onClick, sized, enabled, shape = shape, colors = ButtonDefaults.outlinedButtonColors(contentColor = MaterialTheme.colorScheme.onSurface), content = content)
        WardoHierarchy.Text -> TextButton(onClick, sized, enabled, shape = shape, colors = ButtonDefaults.textButtonColors(contentColor = MaterialTheme.colorScheme.onSurface), content = content)
    }
}

@Composable
fun WardoIconButton(onClick: () -> Unit, modifier: Modifier = Modifier, enabled: Boolean = true, content: @Composable () -> Unit) {
    IconButton(onClick, modifier, enabled, content = content)
}

@Composable
fun WardoToggleButton(checked: Boolean, onCheckedChange: (Boolean) -> Unit, modifier: Modifier = Modifier, enabled: Boolean = true, content: @Composable () -> Unit) {
    FilledIconToggleButton(checked, onCheckedChange, modifier, enabled, content = content)
}

@Composable
fun WardoFloatingActionButton(onClick: () -> Unit, modifier: Modifier = Modifier, content: @Composable () -> Unit) {
    FloatingActionButton(onClick, modifier, content = content)
}

@Composable
fun WardoSplitButton(onClick: () -> Unit, expanded: Boolean, onExpandedChange: (Boolean) -> Unit, modifier: Modifier = Modifier, menu: @Composable ColumnScope.() -> Unit, label: @Composable RowScope.() -> Unit, menuIcon: @Composable () -> Unit) {
    Row(modifier) {
        WardoButton(onClick, content = label)
        Box {
            WardoIconButton({ onExpandedChange(!expanded) }, content = menuIcon)
            DropdownMenu(expanded, { onExpandedChange(false) }, content = menu)
        }
    }
}

@Composable
fun WardoMenuItem(text: String, onClick: () -> Unit, modifier: Modifier = Modifier, enabled: Boolean = true, leadingIcon: (@Composable () -> Unit)? = null, trailingIcon: (@Composable () -> Unit)? = null) {
    DropdownMenuItem(text = { Text(text) }, onClick = onClick, modifier = modifier, enabled = enabled, leadingIcon = leadingIcon, trailingIcon = trailingIcon)
}

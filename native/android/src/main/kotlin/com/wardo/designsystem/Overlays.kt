package com.wardo.designsystem

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.DialogProperties

/// An app-owned dialog; OS permission prompts remain owned by Android.
@Composable
fun WardoDialog(title: String, message: String, onDismissRequest: () -> Unit, onConfirm: () -> Unit, modifier: Modifier = Modifier, confirmLabel: String = "Confirm", dismissLabel: String = "Cancel", icon: (@Composable () -> Unit)? = null) {
    AlertDialog(onDismissRequest, confirmButton = { WardoButton(onConfirm) { Text(confirmLabel) } }, modifier = modifier, dismissButton = { WardoButton(onDismissRequest, hierarchy = WardoHierarchy.Outline) { Text(dismissLabel) } }, icon = icon, title = { Text(title) }, text = { Text(message) })
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun WardoListDialog(title: String, onDismissRequest: () -> Unit, modifier: Modifier = Modifier, scrollable: Boolean = true, actions: @Composable RowScope.() -> Unit, content: @Composable ColumnScope.() -> Unit) {
    BasicAlertDialog(onDismissRequest, modifier, properties = DialogProperties()) {
        Surface(shape = MaterialTheme.shapes.large, color = MaterialTheme.colorScheme.surface) {
            Column(Modifier.padding(24.dp)) {
                Text(title, style = MaterialTheme.typography.titleLarge)
                Column(if (scrollable) Modifier.heightIn(max = 400.dp).verticalScroll(rememberScrollState()) else Modifier, content = content)
                Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.End, content = actions)
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun WardoBottomSheet(onDismissRequest: () -> Unit, modifier: Modifier = Modifier, content: @Composable ColumnScope.() -> Unit) {
    ModalBottomSheet(onDismissRequest, modifier, content = content)
}

@Composable
fun WardoModalDrawer(drawerState: DrawerState, modifier: Modifier = Modifier, drawerContent: @Composable ColumnScope.() -> Unit, content: @Composable () -> Unit) {
    ModalNavigationDrawer(drawerContent = { ModalDrawerSheet(content = drawerContent) }, modifier = modifier, drawerState = drawerState, content = content)
}

@Composable
fun WardoContextMenu(expanded: Boolean, onDismissRequest: () -> Unit, modifier: Modifier = Modifier, content: @Composable ColumnScope.() -> Unit) {
    DropdownMenu(expanded, onDismissRequest, modifier, content = content)
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun WardoTooltip(text: String, modifier: Modifier = Modifier, content: @Composable () -> Unit) {
    TooltipBox(positionProvider = TooltipDefaults.rememberPlainTooltipPositionProvider(), tooltip = { PlainTooltip { Text(text) } }, state = rememberTooltipState(), modifier = modifier, content = content)
}

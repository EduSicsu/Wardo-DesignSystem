package com.wardo.designsystem

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyListScope
import androidx.compose.foundation.lazy.grid.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

@Composable
fun WardoList(modifier: Modifier = Modifier, content: LazyListScope.() -> Unit) { LazyColumn(modifier, content = content) }

@Composable
fun WardoListItem(title: String, modifier: Modifier = Modifier, subtitle: String? = null, leadingContent: (@Composable () -> Unit)? = null, trailingContent: (@Composable () -> Unit)? = null) {
    ListItem(headlineContent = { Text(title) }, modifier = modifier, supportingContent = subtitle?.let { { Text(it) } }, leadingContent = leadingContent, trailingContent = trailingContent)
}

@Composable
fun WardoContentGrid(modifier: Modifier = Modifier, minItemWidth: Dp = 160.dp, content: LazyGridScope.() -> Unit) {
    LazyVerticalGrid(GridCells.Adaptive(minItemWidth), modifier, content = content)
}

@Composable
fun WardoCard(modifier: Modifier = Modifier, content: @Composable ColumnScope.() -> Unit) { Card(modifier, content = content) }

@Composable
fun WardoBadge(modifier: Modifier = Modifier, content: @Composable RowScope.() -> Unit) { Badge(modifier, content = content) }

@Composable
fun WardoProgress(value: Float?, modifier: Modifier = Modifier, circular: Boolean = false) {
    if (circular) {
        if (value == null) CircularProgressIndicator(modifier) else CircularProgressIndicator(progress = { value.coerceIn(0f, 1f) }, modifier = modifier)
    } else {
        if (value == null) LinearProgressIndicator(modifier) else LinearProgressIndicator(progress = { value.coerceIn(0f, 1f) }, modifier = modifier)
    }
}

@Composable
fun WardoSnackbar(message: String, modifier: Modifier = Modifier, action: (@Composable () -> Unit)? = null, dismissAction: (@Composable () -> Unit)? = null) {
    Snackbar(modifier, action = action, dismissAction = dismissAction) { Text(message) }
}

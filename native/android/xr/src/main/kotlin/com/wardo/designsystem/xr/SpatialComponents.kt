package com.wardo.designsystem.xr

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.xr.compose.spatial.*
import androidx.xr.compose.subspace.*
import androidx.xr.compose.subspace.layout.*
import com.wardo.designsystem.*

/** Real spatial panel with system-managed movement and resizing, plus a 2D fallback. */
@Composable
fun WardoSpatialPanel(content: @Composable () -> Unit) {
    Subspace {
        SpatialPanel(SubspaceModifier.width(1024.dp).height(720.dp).movable().resizable()) { content() }
    }
}

/** Place inside the owning panel so the orbiter remains anchored to its content. */
@Composable
fun WardoSpatialToolbar(content: @Composable RowScope.() -> Unit) {
    Orbiter(position = OrbiterPosition.BottomCenter()) {
        Surface(shape = MaterialTheme.shapes.extraLarge) {
            Row(Modifier.padding(12.dp), horizontalArrangement = Arrangement.spacedBy(8.dp), content = content)
        }
    }
}

@Composable
fun WardoSpatialNavigationBar(destinations: List<WardoDestination>, selectedId: String, onSelect: (String) -> Unit, icon: @Composable (WardoDestination) -> Unit) {
    Orbiter(position = OrbiterPosition.BottomCenter()) {
        WardoNavigationBar(destinations, selectedId, onSelect, icon = icon)
    }
}

@Composable
fun WardoSpatialNavigationRail(destinations: List<WardoDestination>, selectedId: String, onSelect: (String) -> Unit, icon: @Composable (WardoDestination) -> Unit) {
    Orbiter(position = OrbiterPosition.CenterStart()) {
        WardoNavigationRail(destinations, selectedId, onSelect, icon = icon)
    }
}

/** SpatialDialog owns the panel's depth transition; application state owns presentation. */
@Composable
fun WardoSpatialDialog(title: String, onDismissRequest: () -> Unit, actions: @Composable RowScope.() -> Unit, content: @Composable ColumnScope.() -> Unit) {
    SpatialDialog(onDismissRequest = onDismissRequest) {
        Surface(shape = MaterialTheme.shapes.extraLarge) {
            Column(Modifier.widthIn(min = 280.dp, max = 560.dp).padding(24.dp), verticalArrangement = Arrangement.spacedBy(16.dp)) {
                Text(title, style = MaterialTheme.typography.titleLarge)
                content()
                Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.End, content = actions)
            }
        }
    }
}

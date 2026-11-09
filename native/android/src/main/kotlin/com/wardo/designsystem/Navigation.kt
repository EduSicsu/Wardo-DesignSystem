package com.wardo.designsystem

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.contentDescription

data class WardoDestination(val id: String, val label: String)

@Composable
fun WardoNavigationBar(destinations: List<WardoDestination>, selectedId: String, onSelect: (String) -> Unit, modifier: Modifier = Modifier, icon: @Composable (WardoDestination) -> Unit) {
    NavigationBar(modifier) {
        destinations.forEach { destination -> NavigationBarItem(selectedId == destination.id, { onSelect(destination.id) }, { icon(destination) }, label = { Text(destination.label) }) }
    }
}

@Composable
fun WardoNavigationRail(destinations: List<WardoDestination>, selectedId: String, onSelect: (String) -> Unit, modifier: Modifier = Modifier, icon: @Composable (WardoDestination) -> Unit) {
    NavigationRail(modifier) {
        destinations.forEach { destination -> NavigationRailItem(selectedId == destination.id, { onSelect(destination.id) }, { icon(destination) }, label = { Text(destination.label) }) }
    }
}

@Composable
fun WardoSidebar(destinations: List<WardoDestination>, selectedId: String, onSelect: (String) -> Unit, modifier: Modifier = Modifier, icon: @Composable (WardoDestination) -> Unit) {
    PermanentDrawerSheet(modifier) {
        destinations.forEach { destination -> NavigationDrawerItem(label = { Text(destination.label) }, selected = selectedId == destination.id, onClick = { onSelect(destination.id) }, icon = { icon(destination) }) }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun WardoTopAppBar(title: String, modifier: Modifier = Modifier, navigationIcon: @Composable () -> Unit = {}, actions: @Composable RowScope.() -> Unit = {}) {
    TopAppBar(title = { Text(title) }, modifier = modifier, navigationIcon = navigationIcon, actions = actions)
}

@Composable
fun WardoBottomAppBar(modifier: Modifier = Modifier, actions: @Composable RowScope.() -> Unit) { BottomAppBar(modifier, content = actions) }

enum class WardoTabPresentation { Primary, Secondary }
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun WardoTabs(tabs: List<String>, selectedIndex: Int, onSelect: (Int) -> Unit, modifier: Modifier = Modifier, presentation: WardoTabPresentation = WardoTabPresentation.Primary, icon: (@Composable (Int) -> Unit)? = null, showLabels: Boolean = true) {
    require(selectedIndex in tabs.indices)
    val items: @Composable () -> Unit = {
        tabs.forEachIndexed { index, title ->
            Tab(selectedIndex == index, { onSelect(index) }, text = if (showLabels) ({ Text(title) }) else null, icon = icon?.let { render -> { render(index) } }, modifier = Modifier.semantics { contentDescription = title })
        }
    }
    when (presentation) {
        WardoTabPresentation.Primary -> PrimaryTabRow(selectedIndex, modifier, tabs = items)
        WardoTabPresentation.Secondary -> SecondaryTabRow(selectedIndex, modifier, tabs = items)
    }
}

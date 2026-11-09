package com.wardo.designsystem

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.selection.selectable
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.clearAndSetSemantics
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

enum class WardoNavigationItemLayout { Vertical, Horizontal, TextOnly }

/**
 * Android anatomy of the canonical Navigation Item, not a navigation container.
 * Place sibling destinations in a selectableGroup. The application owns selection,
 * navigation, localized labels, icon content and optional badge announcements.
 * LocalLayoutDirection mirrors leading/trailing placement without reversing labels.
 */
@Composable
fun WardoNavigationItem(
    selected: Boolean,
    onClick: () -> Unit,
    label: String,
    icon: @Composable () -> Unit,
    modifier: Modifier = Modifier,
    layout: WardoNavigationItemLayout = WardoNavigationItemLayout.Vertical,
    enabled: Boolean = true,
    badge: String? = null,
    badgeContentDescription: String? = null,
) {
    val colors = LocalWardoColors.current
    val vertical = layout == WardoNavigationItemLayout.Vertical
    val textOnly = layout == WardoNavigationItemLayout.TextOnly
    val shape = RoundedCornerShape(if (textOnly) 8.dp else 16.dp)
    val background = when {
        !selected || vertical -> Color.Transparent
        textOnly -> colors.backgroundSubtle
        else -> colors.actionPrimary
    }
    val foreground = if (selected && !vertical && !textOnly) colors.actionPrimaryForeground else colors.textPrimary
    val textStyle = MaterialTheme.typography.labelLarge.copy(
        fontWeight = FontWeight.Medium,
        fontSize = if (vertical) 12.sp else 14.sp,
        lineHeight = if (vertical) 16.sp else 20.sp,
    )
    Box(
        modifier.width(if (vertical) 88.dp else if (textOnly) 148.dp else 240.dp)
            .heightIn(min = 48.dp)
            .alpha(if (enabled) 1f else 0.38f)
            .clip(shape)
            .background(background)
            .selectable(selected, enabled = enabled, role = Role.Tab, onClick = onClick),
    ) {
        CompositionLocalProvider(LocalContentColor provides foreground) {
            if (vertical) {
                Column(
                    Modifier.fillMaxWidth().padding(4.dp),
                    horizontalAlignment = Alignment.CenterHorizontally,
                    verticalArrangement = Arrangement.spacedBy(4.dp),
                ) {
                    Box(
                        Modifier.size(64.dp, 32.dp)
                            .background(if (selected) colors.actionPrimary else Color.Transparent, RoundedCornerShape(256.dp)),
                        contentAlignment = Alignment.Center,
                    ) {
                        CompositionLocalProvider(LocalContentColor provides if (selected) colors.actionPrimaryForeground else colors.textPrimary) {
                            Box(Modifier.size(24.dp).clearAndSetSemantics {}, contentAlignment = Alignment.Center) { icon() }
                        }
                    }
                    Text(label, Modifier.fillMaxWidth().heightIn(min = 20.dp), color = colors.textPrimary, style = textStyle, textAlign = TextAlign.Center)
                }
            } else {
                Row(
                    Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 12.dp),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.spacedBy(12.dp),
                ) {
                    if (!textOnly) Box(Modifier.size(24.dp).clearAndSetSemantics {}, contentAlignment = Alignment.Center) { icon() }
                    Text(label, Modifier.weight(1f), style = textStyle, textAlign = TextAlign.Start)
                }
            }
        }
        if (badge != null) {
            Box(
                Modifier.align(Alignment.TopEnd).padding(top = if (vertical) 2.dp else 6.dp, end = if (vertical) 2.dp else 6.dp)
                    .background(colors.feedbackErrorBackground, RoundedCornerShape(16.dp))
                    .padding(horizontal = 6.dp, vertical = 2.dp)
                    .then(if (badgeContentDescription != null) Modifier.clearAndSetSemantics { contentDescription = badgeContentDescription } else Modifier),
            ) {
                Text(badge, color = colors.feedbackErrorForeground, style = textStyle.copy(fontSize = 12.sp, lineHeight = 16.8.sp))
            }
        }
    }
}

/** Android / Rail Item: the horizontal configuration of the shared item. */
@Composable
fun WardoRailItem(
    selected: Boolean, onClick: () -> Unit, label: String, icon: @Composable () -> Unit,
    modifier: Modifier = Modifier, enabled: Boolean = true, badge: String? = null,
    badgeContentDescription: String? = null,
) = WardoNavigationItem(selected, onClick, label, icon, modifier, WardoNavigationItemLayout.Horizontal, enabled, badge, badgeContentDescription)

/** Android / Navigation Bar Item: the vertical configuration of the shared item. */
@Composable
fun WardoNavigationBarItem(
    selected: Boolean, onClick: () -> Unit, label: String, icon: @Composable () -> Unit,
    modifier: Modifier = Modifier, enabled: Boolean = true, badge: String? = null,
    badgeContentDescription: String? = null,
) = WardoNavigationItem(selected, onClick, label, icon, modifier, WardoNavigationItemLayout.Vertical, enabled, badge, badgeContentDescription)

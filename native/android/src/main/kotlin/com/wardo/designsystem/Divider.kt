package com.wardo.designsystem

import androidx.compose.foundation.layout.padding
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.VerticalDivider
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

enum class WardoDividerOrientation { Horizontal, Vertical }
enum class WardoDividerInset { None, Start, Both }

/** Horizontal start follows layout direction; vertical start remains the top edge. */
@Composable
fun WardoDivider(modifier: Modifier = Modifier, orientation: WardoDividerOrientation = WardoDividerOrientation.Horizontal, inset: WardoDividerInset = WardoDividerInset.None) {
    val start = if (inset == WardoDividerInset.None) 0.dp else 16.dp
    val end = if (inset == WardoDividerInset.Both) 16.dp else 0.dp
    val color = LocalWardoColors.current.separatorDefault
    if (orientation == WardoDividerOrientation.Horizontal) {
        HorizontalDivider(modifier.padding(start = start, end = end), thickness = 1.dp, color = color)
    } else {
        VerticalDivider(modifier.padding(top = start, bottom = end), thickness = 1.dp, color = color)
    }
}

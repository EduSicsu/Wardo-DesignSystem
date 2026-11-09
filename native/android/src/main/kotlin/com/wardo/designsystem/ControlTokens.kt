// Generated from tokens/controls.figma.json by npm run tokens.
package com.wardo.designsystem

import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.TextUnit
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

enum class WardoSharedControlSize { M, XS, S, L, XL, XXL, Chonky, Hero }

data class WardoSharedControlMetrics(
    val minHeight: Dp,
    val contentSpacing: Dp,
    val labelFontSize: TextUnit,
    val labelLineHeight: TextUnit,
)

fun wardoControlMetrics(size: WardoSharedControlSize = WardoSharedControlSize.M): WardoSharedControlMetrics = when (size) {
    WardoSharedControlSize.M -> WardoSharedControlMetrics(48.dp, 8.dp, 16.sp, 19.200000762939453.sp)
    WardoSharedControlSize.XS -> WardoSharedControlMetrics(32.dp, 4.dp, 12.sp, 14.399999618530273.sp)
    WardoSharedControlSize.S -> WardoSharedControlMetrics(40.dp, 4.dp, 14.sp, 16.799999237060547.sp)
    WardoSharedControlSize.L -> WardoSharedControlMetrics(64.dp, 8.dp, 20.sp, 24.sp)
    WardoSharedControlSize.XL -> WardoSharedControlMetrics(72.dp, 12.dp, 24.sp, 28.799999237060547.sp)
    WardoSharedControlSize.XXL -> WardoSharedControlMetrics(88.dp, 12.dp, 32.sp, 38.400001525878906.sp)
    WardoSharedControlSize.Chonky -> WardoSharedControlMetrics(100.dp, 16.dp, 36.sp, 43.20000076293945.sp)
    WardoSharedControlSize.Hero -> WardoSharedControlMetrics(116.dp, 16.dp, 40.sp, 48.sp)
}

enum class WardoSharedControlContent { Labelled, Icon }

data class WardoSharedControlPadding(val horizontal: Dp, val vertical: Dp)

fun wardoControlPadding(content: WardoSharedControlContent): WardoSharedControlPadding = when (content) {
    WardoSharedControlContent.Labelled -> WardoSharedControlPadding(24.dp, 12.dp)
    WardoSharedControlContent.Icon -> WardoSharedControlPadding(0.dp, 0.dp)
}

enum class WardoSharedControlCondition { Normal, Serious, Chonky }

fun wardoControlRadius(condition: WardoSharedControlCondition): Dp = when (condition) {
    WardoSharedControlCondition.Normal -> 8.dp
    WardoSharedControlCondition.Serious -> 4.dp
    WardoSharedControlCondition.Chonky -> 256.dp
}

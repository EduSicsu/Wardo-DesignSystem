package com.wardo.designsystem

import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.runtime.staticCompositionLocalOf
import androidx.compose.material3.*
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.Font
import androidx.compose.ui.unit.sp

val LocalWardoColors = staticCompositionLocalOf { wardoColors(WardoTheme.WardoLight) }

@Composable
fun WardoTheme(theme: WardoTheme = WardoTheme.WardoLight, labelFont: FontFamily = FontFamily(Font(R.font.geologica)), bodyFont: FontFamily = FontFamily(Font(R.font.source_serif_4)), content: @Composable () -> Unit) {
    val c = wardoColors(theme)
    val scheme = if (theme.name.endsWith("Dark")) darkColorScheme() else lightColorScheme()
    CompositionLocalProvider(LocalWardoColors provides c) { MaterialTheme(
        colorScheme = scheme.copy(primary = c.actionPrimary, onPrimary = c.actionPrimaryForeground, primaryContainer = c.backgroundBrand, onPrimaryContainer = c.textPrimary, secondary = c.actionSecondary, onSecondary = c.actionSecondaryForeground, secondaryContainer = c.actionSecondary, onSecondaryContainer = c.actionSecondaryForeground, background = c.backgroundDefault, onBackground = c.textPrimary, surface = c.backgroundRaised, onSurface = c.textPrimary, surfaceVariant = c.backgroundSubtle, onSurfaceVariant = c.textSecondary, outline = c.borderDefault, error = c.feedbackErrorForeground),
        typography = Typography(titleLarge = TextStyle(fontFamily = labelFont, fontSize = 20.sp, lineHeight = 24.sp), bodyLarge = TextStyle(fontFamily = bodyFont, fontSize = 20.sp, lineHeight = 30.sp), labelLarge = TextStyle(fontFamily = labelFont, fontSize = 16.sp, lineHeight = 20.sp)),
        content = content
    ) }
}

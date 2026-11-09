package com.wardo.designsystem

import androidx.compose.foundation.layout.size
import androidx.compose.material3.Icon
import androidx.compose.material3.LocalContentColor
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp

/** Exact Wardo toolbar geometry, converted from the source SVGs with Android's Svg2Vector. */
enum class WardoToolbarGlyph { Stars, StarsFilled, Share, Comment, Download, Edit, MoreVert, Image }

/**
 * A 24 dp decorative glyph when description is null. The consuming action owns
 * its accessible label and target size. Native content tint follows the parent
 * control's selected, disabled, surface and theme state.
 */
@Composable
fun WardoToolbarArtwork(
    glyph: WardoToolbarGlyph,
    contentDescription: String? = null,
    modifier: Modifier = Modifier,
    tint: Color = LocalContentColor.current,
) {
    val resource = when (glyph) {
        WardoToolbarGlyph.Stars -> R.drawable.wardo_toolbar_stars
        WardoToolbarGlyph.StarsFilled -> R.drawable.wardo_toolbar_stars_filled
        WardoToolbarGlyph.Share -> R.drawable.wardo_toolbar_share
        WardoToolbarGlyph.Comment -> R.drawable.wardo_toolbar_comment
        WardoToolbarGlyph.Download -> R.drawable.wardo_toolbar_download
        WardoToolbarGlyph.Edit -> R.drawable.wardo_toolbar_edit
        WardoToolbarGlyph.MoreVert -> R.drawable.wardo_toolbar_more_vert
        WardoToolbarGlyph.Image -> R.drawable.wardo_toolbar_image
    }
    Icon(painterResource(resource), contentDescription, modifier.size(24.dp), tint)
}

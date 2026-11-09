package com.wardo.catalogue

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.contentDescription
import com.wardo.designsystem.*

class CatalogueActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) { super.onCreate(savedInstanceState); setContent { Catalogue() } }
}
@Composable fun Catalogue() {
    var theme by remember { mutableStateOf(WardoTheme.WardoLight) }
    var text by remember { mutableStateOf("Ceramics") }
    var checked by remember { mutableStateOf(true) }
    var volume by remember { mutableFloatStateOf(0.5f) }
    var notice by remember { mutableStateOf("Ready") }
    var dialog by remember { mutableStateOf(false) }
    WardoTheme(theme) {
        Surface(Modifier.fillMaxSize()) {
            Column(Modifier.verticalScroll(rememberScrollState()).padding(24.dp), verticalArrangement = Arrangement.spacedBy(16.dp)) {
                Text("Wardo native catalogue", style = MaterialTheme.typography.titleLarge)
                Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) { WardoTheme.entries.take(2).forEach { option -> TextButton({ theme = option }) { Text(option.name) } } }
                WardoButton(onClick = { notice = "Button activated" }) { Text("Activate") }
                WardoTextField(value = text, onValueChange = { text = it }, label = "Find events")
                Row { WardoCheckbox(checked, { checked = it }, Modifier.semantics { contentDescription = "Notifications" }); Text("Notifications") }
                WardoSlider(volume, { volume = it })
                Text("Volume: ${(volume * 100).toInt()}%")
                Button({ dialog = true }) { Text("Show alert") }
                Text(notice)
                WardoProgress(volume)
            }
            if (dialog) WardoDialog("Wardo alert", "Native system presentation", onDismissRequest = { dialog = false }, onConfirm = { notice = "Alert confirmed"; dialog = false })
        }
    }
}

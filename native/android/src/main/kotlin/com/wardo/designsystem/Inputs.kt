package com.wardo.designsystem

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.text.input.VisualTransformation
import androidx.compose.ui.unit.dp

@Composable
fun WardoTextField(value: String, onValueChange: (String) -> Unit, label: String, modifier: Modifier = Modifier, enabled: Boolean = true, isError: Boolean = false, secure: Boolean = false, singleLine: Boolean = true, supportingText: (@Composable () -> Unit)? = null) {
    OutlinedTextField(value, onValueChange, modifier, enabled = enabled, label = { Text(label) }, supportingText = supportingText, isError = isError, singleLine = singleLine, visualTransformation = if (secure) PasswordVisualTransformation() else VisualTransformation.None)
}

@Composable
fun WardoCheckbox(checked: Boolean, onCheckedChange: (Boolean) -> Unit, modifier: Modifier = Modifier, enabled: Boolean = true) {
    Checkbox(checked, onCheckedChange, modifier, enabled = enabled)
}

@Composable
fun WardoSwitch(checked: Boolean, onCheckedChange: (Boolean) -> Unit, modifier: Modifier = Modifier, enabled: Boolean = true) {
    Switch(checked, onCheckedChange, modifier, enabled = enabled)
}

@Composable
fun WardoRadio(selected: Boolean, onClick: () -> Unit, modifier: Modifier = Modifier, enabled: Boolean = true) {
    RadioButton(selected, onClick, modifier, enabled = enabled)
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun WardoSegmentedControl(options: List<String>, selected: Int, onSelectionChange: (Int) -> Unit, modifier: Modifier = Modifier) {
    SingleChoiceSegmentedButtonRow(modifier) {
        options.forEachIndexed { index, option ->
            SegmentedButton(selected == index, { onSelectionChange(index) }, SegmentedButtonDefaults.itemShape(index, options.size)) { Text(option) }
        }
    }
}

@Composable
fun WardoSlider(value: Float, onValueChange: (Float) -> Unit, modifier: Modifier = Modifier, enabled: Boolean = true, valueRange: ClosedFloatingPointRange<Float> = 0f..1f, steps: Int = 0) {
    Slider(value, onValueChange, modifier, enabled = enabled, valueRange = valueRange, steps = steps)
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun WardoRangeSlider(value: ClosedFloatingPointRange<Float>, onValueChange: (ClosedFloatingPointRange<Float>) -> Unit, modifier: Modifier = Modifier, enabled: Boolean = true, valueRange: ClosedFloatingPointRange<Float> = 0f..1f, steps: Int = 0) {
    RangeSlider(value, onValueChange, modifier, enabled = enabled, valueRange = valueRange, steps = steps)
}

@Composable
fun WardoStepper(value: Int, onValueChange: (Int) -> Unit, label: String, range: IntRange, modifier: Modifier = Modifier) {
    require(!range.isEmpty())
    Row(modifier, horizontalArrangement = Arrangement.spacedBy(8.dp)) {
        WardoButton({ onValueChange((value - 1).coerceIn(range)) }, enabled = value > range.first, hierarchy = WardoHierarchy.Outline) { Text("−") }
        Text("$label: $value")
        WardoButton({ onValueChange((value + 1).coerceIn(range)) }, enabled = value < range.last, hierarchy = WardoHierarchy.Outline) { Text("+") }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun WardoDatePicker(state: DatePickerState, modifier: Modifier = Modifier) { DatePicker(state, modifier) }

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun WardoTimePicker(state: TimePickerState, modifier: Modifier = Modifier) { TimePicker(state, modifier) }

@Composable
fun WardoFilterChip(selected: Boolean, onClick: () -> Unit, label: String, modifier: Modifier = Modifier, enabled: Boolean = true) {
    FilterChip(selected, onClick, { Text(label) }, modifier, enabled = enabled)
}

@Composable
fun WardoInputChip(selected: Boolean, onClick: () -> Unit, label: String, modifier: Modifier = Modifier, enabled: Boolean = true, trailingIcon: (@Composable () -> Unit)? = null) {
    InputChip(selected, onClick, { Text(label) }, modifier, enabled = enabled, trailingIcon = trailingIcon)
}

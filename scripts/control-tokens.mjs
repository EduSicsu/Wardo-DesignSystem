// Shared Wardo control metrics. Native system-control geometry remains platform owned.
export function generateControlTokens(tokens) {
  const get = (name, mode) => {
    const value = tokens.find(token => token.name === name)?.modes[mode];
    if (typeof value !== 'number' || !Number.isFinite(value) || value < 0) throw Error(`Invalid control token ${name}/${mode}`);
    return value;
  };
  const sizes = Object.keys(tokens.find(token => token.name === 'control/size/min-height')?.modes ?? {});
  if (!sizes.length) throw Error('Missing control sizes');
  const swiftNames = { XS: 'xs', S: 's', M: 'm', L: 'l', XL: 'xl', '2XL': 'xxl', Chonky: 'chonky', Hero: 'hero' };
  const kotlinNames = { XS: 'XS', S: 'S', M: 'M', L: 'L', XL: 'XL', '2XL': 'XXL', Chonky: 'Chonky', Hero: 'Hero' };
  const fields = { minHeight: 'control/size/min-height', contentSpacing: 'control/spacing/content', labelFontSize: 'control/type/label/font-size', labelLineHeight: 'control/type/label/line-height' };
  for (const size of sizes) if (!swiftNames[size]) throw Error(`Unknown control size ${size}`);
  let swift = '// Generated from tokens/controls.figma.json by npm run tokens.\nimport CoreGraphics\n\npublic enum WardoSharedControlSize: String, CaseIterable, Sendable {\n';
  for (const size of sizes) swift += `    case ${swiftNames[size]} = "${size}"\n`;
  swift += '}\n\npublic struct WardoSharedControlMetrics: Sendable {\n';
  for (const field of Object.keys(fields)) swift += `    public let ${field}: CGFloat\n`;
  swift += '    public init(size: WardoSharedControlSize = .m) {\n        switch size {\n';
  for (const size of sizes) swift += `        case .${swiftNames[size]}: ${Object.entries(fields).map(([field, name]) => `self.${field} = ${get(name, size)}`).join('; ')}\n`;
  swift += '        }\n    }\n}\n';
  swift += '\npublic enum WardoSharedControlContent: Sendable {\n    case labelled, icon\n';
  for (const [field, token] of [['horizontalPadding', 'control/content/padding-x'], ['verticalPadding', 'control/content/padding-y']]) {
    swift += `    public var ${field}: CGFloat { switch self { case .labelled: ${get(token, 'Labelled')}; case .icon: ${get(token, 'Icon')} } }\n`;
  }
  swift += '}\n\npublic enum WardoSharedControlCondition: String, CaseIterable, Sendable {\n    case normal = "Normal", serious = "Serious", chonky = "Chonky"\n    public var cornerRadius: CGFloat {\n        switch self {\n';
  for (const mode of ['Normal', 'Serious', 'Chonky']) swift += `        case .${mode.toLowerCase()}: ${get('control/theme/radius', mode)}\n`;
  swift += '        }\n    }\n}\n';
  let kotlin = '// Generated from tokens/controls.figma.json by npm run tokens.\npackage com.wardo.designsystem\n\nimport androidx.compose.ui.unit.Dp\nimport androidx.compose.ui.unit.TextUnit\nimport androidx.compose.ui.unit.dp\nimport androidx.compose.ui.unit.sp\n\nenum class WardoSharedControlSize { '+sizes.map(size => kotlinNames[size]).join(', ')+' }\n\ndata class WardoSharedControlMetrics(\n';
  for (const field of Object.keys(fields)) kotlin += `    val ${field}: ${field.startsWith('label') ? 'TextUnit' : 'Dp'},\n`;
  kotlin += ')\n\nfun wardoControlMetrics(size: WardoSharedControlSize = WardoSharedControlSize.M): WardoSharedControlMetrics = when (size) {\n';
  for (const size of sizes) kotlin += `    WardoSharedControlSize.${kotlinNames[size]} -> WardoSharedControlMetrics(${Object.entries(fields).map(([field, name]) => `${get(name, size)}.${field.startsWith('label') ? 'sp' : 'dp'}`).join(', ')})\n`;
  kotlin += '}\n';
  kotlin += '\nenum class WardoSharedControlContent { Labelled, Icon }\n\ndata class WardoSharedControlPadding(val horizontal: Dp, val vertical: Dp)\n\nfun wardoControlPadding(content: WardoSharedControlContent): WardoSharedControlPadding = when (content) {\n';
  for (const mode of ['Labelled', 'Icon']) kotlin += `    WardoSharedControlContent.${mode} -> WardoSharedControlPadding(${get('control/content/padding-x', mode)}.dp, ${get('control/content/padding-y', mode)}.dp)\n`;
  kotlin += '}\n\nenum class WardoSharedControlCondition { Normal, Serious, Chonky }\n\nfun wardoControlRadius(condition: WardoSharedControlCondition): Dp = when (condition) {\n';
  for (const mode of ['Normal', 'Serious', 'Chonky']) kotlin += `    WardoSharedControlCondition.${mode} -> ${get('control/theme/radius', mode)}.dp\n`;
  kotlin += '}\n';
  return [
    ['../native/apple/Sources/WardoDesignSystem/ControlTokens.swift', swift],
    ['../native/android/src/main/kotlin/com/wardo/designsystem/ControlTokens.kt', kotlin],
  ];
}

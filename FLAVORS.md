# Configuração de Flavors (Ambientes)

Este projeto está configurado com 3 flavors/ambientes:

## Identificadores de Bundle/Pacote

### Android
- **DEVELOPMENT**: `br.com.htech.ofmAppDemo.ofm_demo.development`
- **HOMOLOGATION**: `br.com.htech.ofmAppDemo.ofm_demo.homologation`
- **PRODUCTION**: `br.com.htech.ofmAppDemo.ofm_demo`

### iOS
- **DEVELOPMENT**: `br.com.htech.ofmAppDemo.ofm_demo-development`
- **HOMOLOGATION**: `br.com.htech.ofmAppDemo.ofm_demo-homologation`
- **PRODUCTION**: `br.com.htech.ofmAppDemo.ofm_demo`

## Como executar cada flavor

### Development
```bash
flutter run --flavor development
```

### Homologation
```bash
flutter run --flavor homologation
```

### Production
```bash
flutter run --flavor production
```

## Build para release

### Android
```bash
# Development
flutter build apk --flavor development --release

# Homologation
flutter build apk --flavor homologation --release

# Production
flutter build apk --flavor production --release
```

### iOS
```bash
# Development
flutter build ios --flavor development --release

# Homologation
flutter build ios --flavor homologation --release

# Production
flutter build ios --flavor production --release
```

## Arquivos de configuração

### Android
- Configuração em: `android/app/build.gradle`
- Product flavors definidos com diferentes `applicationIdSuffix`

### iOS
- Arquivos de configuração:
  - `ios/Flutter/Development.xcconfig`
  - `ios/Flutter/Homologation.xcconfig`
  - `ios/Flutter/Production.xcconfig`
- Cada arquivo define o `PRODUCT_BUNDLE_IDENTIFIER` específico

## Observações

- Os 3 flavors podem ser instalados simultaneamente no mesmo dispositivo devido aos diferentes identificadores
- Development e Homologation incluem sufixos no nome da versão (`-dev`, `-hml`)
- Certifique-se de configurar diferentes arquivos de configuração (Firebase, API keys, etc.) para cada ambiente se necessário

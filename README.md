<p align="center">
  <img src="https://enlace-de-tu-imagen-o-gif-de-flores.com" alt="Flores" width="100%">
</p>

# App de Autenticación en Flutter

App móvil con 6 pantallas: Login, Registro, Recuperar contraseña, Verificación de código, Nueva contraseña y Home. Usa solo el SDK estándar de Flutter, sin dependencias externas.

## Requisitos

| Herramienta | Versión mínima |
|-------------|----------------|
| Flutter SDK | 3.27 o superior (canal stable) |
| Dart SDK    | 3.6 o superior (incluido con Flutter) |
| Android Studio o VS Code | Con los plugins de Flutter y Dart |
| Emulador o dispositivo físico | Android 5.0+ (API 21) o iOS 12+ |

Verifica tu instalación con:

```bash
flutter --version
flutter doctor
```

## Ejecución

1. Clona o descarga el proyecto y entra a la carpeta:

   ```bash
   cd nombre_del_proyecto
   ```

2. Instala las dependencias:

   ```bash
   flutter pub get
   ```

3. Inicia un emulador o conecta un dispositivo y revisa que se detecte:

   ```bash
   flutter devices
   ```

4. Ejecuta la app:

   ```bash
   flutter run
   ```

> Si empiezas desde cero: `flutter create nombre_del_proyecto`, crea la carpeta `lib/pages/`, copia allí las pantallas y `widgets.dart`, reemplaza `lib/main.dart` y sigue desde el paso 2.

## Estructura

```
lib/
├── main.dart                  # MaterialApp y rutas nombradas
└── pages/
    ├── widgets.dart           # Colores, gradientes y componentes reutilizables
    ├── login.dart             # LoginScreen
    ├── registro.dart          # RegisterScreen
    ├── recuperar.dart         # ForgotPasswordScreen
    ├── verificar.dart         # VerificationCodeScreen
    ├── nueva_contrasena.dart  # NewPasswordScreen
    └── home.dart              # HomeScreen
```

## Rutas

| Ruta | Pantalla |
|------|----------|
| `/` | Login (ruta inicial) |
| `/register` | Registro |
| `/forgot-password` | Recuperar contraseña |
| `/verification` | Verificación de código |
| `/new-password` | Nueva contraseña |
| `/home` | Home |

## Flujo de navegación

- **Login** → Home, Registro o Recuperar contraseña.
- **Registro** → Home.
- **Recuperar contraseña** → Verificación → Nueva contraseña → Login.

## Notas

- Los datos son simulados: no hay backend, la autenticación solo valida los formularios.
- La fuente del diseño es **Inter**. Es opcional: si no la agregas en `pubspec.yaml`, Flutter usa la fuente por defecto.
- Si te sale un error con `withValues`, tu Flutter es anterior a 3.27: actualiza con `flutter upgrade`.

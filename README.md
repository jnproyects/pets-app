# PetsApp

Aplicación móvil desarrollada en **Flutter** que permite registrar y gestionar la información básica de tus **mascotas** (perros y gatos).

# Dev

Si hay cambios en la entidad, se debe ejecutar el comando:
```
flutter pub run build_runner build
```

# Prod

Para cambiar **nombre** de la app:
```
flutter pub run change_app_package_name:main com.juanpabmgg.pets_app
```

Para cambiar el **ícono** de la app:
```
flutter pub run flutter_launcher_icons
```

Generar AAB
```
flutter build appbundle
```
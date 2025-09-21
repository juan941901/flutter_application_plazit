# Curso Plazit flutter

Este proyecto es de un recetario, realizado siguiendo los pasos indicados en el curso de plazit

## Puntos clave

### Provider

Para la instalacción del paquete usaremos el comando.

``` dart
flutter pub add provider
```

Con esto se agrega el paquete a nuestro archivo `pubspec.yaml`.

Haciendo uso del paquete de provider, podremos manejar lógica de manera global dentro del proyecto permitiendo así llevar valores o funcionabilidades a cualquier parte de nuestro código.

Para ello necesitaremos importar el paquete en el archivo donde vamos a hacer uso, también debemos en nuestro archivo main usar `MultiProvider`, con el cual podremos registrar los providers que vamos a usar dentro de nuestro proyecto.

```dart
MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipesProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Libro de recetas",
        home: const RecipeBook(),
      ),
    )
```
Las siguientes son caracteristicas de provider

# 📑 Chuleta Provider en Flutter

| Widget / Método          | ¿Qué hace?                                                                 | ¿Cuándo usarlo?                                                | Ejemplo rápido |
|---------------------------|-----------------------------------------------------------------------------|----------------------------------------------------------------|----------------|
| **Provider**              | Inyecta un objeto (ej. clase, valor, servicio) en el árbol de widgets.     | Cuando quieres exponer un objeto a los hijos.                  | ```Provider(create: (_) => MiServicio(), child: MyApp())``` |
| **ChangeNotifierProvider**| Inyecta un objeto que extiende `ChangeNotifier` y notifica a los widgets.  | Para estados que cambian dinámicamente.                        | ```ChangeNotifierProvider(create: (_) => RecipesProvider())``` |
| **MultiProvider**         | Agrupa varios `Provider` o `ChangeNotifierProvider` en uno solo.           | Cuando tienes más de un estado/servicio.                       | ```MultiProvider(providers: [ChangeNotifierProvider(create: (_) => AuthProvider()), ChangeNotifierProvider(create: (_) => RecipesProvider())], child: MyApp())``` |
| **Provider.of<T>**        | Obtiene el objeto inyectado en el árbol. Puede escuchar cambios o no.      | Cuando necesitas acceder al provider directamente en el código.| ```final auth = Provider.of<AuthProvider>(context, listen: false);``` |
| **Consumer<T>**           | Escucha al provider y reconstruye solo ese widget cuando cambie.           | Cuando quieres redibujar solo una parte del árbol.             | ```Consumer<AuthProvider>(builder: (_, auth, __) => Text(auth.user))``` |
| **Selector<T, R>**        | Similar a `Consumer`, pero selecciona un valor específico del provider.    | Cuando no quieres que un widget se redibuje por cambios globales.| ```Selector<AuthProvider, String>(selector: (_, auth) => auth.userName, builder: (_, name, __) => Text(name))``` |
| **context.read<T>()**     | Obtiene el provider **una sola vez** sin escuchar cambios.                 | Cuando solo necesitas llamar un método (ej. login).            | ```context.read<AuthProvider>().login();``` |
| **context.watch<T>()**    | Obtiene el provider y escucha cambios.                                     | Cuando quieres que se reconstruya el widget al cambiar estado. | ```final user = context.watch<AuthProvider>().user;``` |
| **context.select<T, R>()**| Escucha **solo un campo** del provider, se reconstruye si ese campo cambia.| Para optimizar rendimiento cuando solo te importa un valor.    | ```final username = context.select<AuthProvider, String>((auth) => auth.userName);``` |


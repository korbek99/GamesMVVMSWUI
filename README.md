# 🎮 GamesMVVMSWUI

[![Swift Version](https://img.shields.io/badge/Swift-5.9%2B-orange.svg?style=flat&logo=swift)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%2016%2B-blue.svg?style=flat&logo=apple)](https://developer.apple.com/ios/)
[![Architecture](https://img.shields.io/badge/Architecture-MVVM-green.svg?style=flat)](https://en.wikipedia.org/wiki/Model–view–viewmodel)

> **"A clean and simple example of the MVVM pattern implemented in SwiftUI."**

`GamesMVVMSWUI` es una aplicación de demostración que muestra cómo estructurar un proyecto siguiendo el patrón de diseño **Model-View-ViewModel (MVVM)**. La app consume datos de videojuegos para presentarlos en una interfaz moderna y fluida utilizando los últimos estándares de **SwiftUI**.

---

## 🚀 Características (Features)
- **👾 Listado de Juegos:** Visualización dinámica de títulos de videojuegos populares.
- **🏗️ Patrón MVVM:** Separación clara entre la lógica de negocio, los datos y la interfaz de usuario.
- **🌐 Networking:** Implementación de peticiones HTTP para obtener datos en tiempo real.
- **📱 SwiftUI Native:** Interfaz construida íntegramente con componentes declarativos de Apple.
- **🔄 State Management:** Uso eficiente de `@Published`, `@StateObject` y `@ObservedObject`.

---

## 🏗️ Estructura del Proyecto

El proyecto se divide en tres capas principales para garantizar la mantenibilidad:

* **Model:** Define las estructuras de datos (Entities) y los objetos `Codable` para el mapeo del JSON.
* **ViewModel:** Actúa como el cerebro de la aplicación, manejando la lógica de red y preparando los datos para la vista.
* **View:** Capa de interfaz de usuario pura que reacciona a los cambios en el ViewModel.

---

## 📸 Screenshots

| Game List | Game Details |
| :---: | :---: |

---

## 📖 Guía para Estudiantes

Este repositorio es un recurso ideal para aprender:
1. **Inyección de Dependencias básica:** Cómo pasar el ViewModel a la Vista.
2. **Async/Await:** Manejo moderno de concurrencia en las llamadas a la API.
3. **Parseo de JSON:** Transformación de respuestas complejas de una API a modelos de Swift.

---


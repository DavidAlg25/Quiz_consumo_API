markdown
# Proyecto Login Flutter - Evaluación

Este proyecto consiste en una aplicación móvil desarrollada en **Flutter** que se conecta a una **API REST** creada con **Node.js** y **MySQL**.  
La aplicación permite registrar nuevos usuarios, iniciar sesión y acceder a una pantalla de inicio con contenido aleatorio.

---

## Requisitos previos

Antes de empezar, instala lo siguiente en tu equipo:

- **Git** – para clonar el repositorio.
- **Visual Studio Code** (u otro editor de código) – recomendado.
- **Node.js** (última versión estable) – para ejecutar el backend.
- **Flutter SDK** junto con **Dart SDK** – para compilar y ejecutar el frontend.
- **MySQL** – como base de datos (se recomienda usar **XAMPP** para tener MySQL y phpMyAdmin).

---

## 1. Clonar el repositorio

Abre una terminal en la carpeta donde deseas guardar el proyecto y ejecuta:

```bash
git clone https://github.com/TU_USUARIO/TU_REPO.git
cd TU_REPO
El repositorio contiene la siguiente estructura:

text
PROYECTO LOGIN FLUTTER/
├── api/                # Backend (Node.js)
│   └── api_basic/      # Código fuente de la API
│       ├── src/        # Controladores, modelos, rutas, etc.
│       ├── .env        # Variables de entorno (configurar)
│       ├── package.json
│       └── package-lock.json
├── db/                 # Base de datos
│   └── api-crud.sql    # Script SQL con estructura y datos de prueba
└── flutter/            # Frontend (Flutter)
    └── flutter_app_2/  # Código fuente de la aplicación
        ├── lib/
        ├── pubspec.yaml
        └── ...
2. Configurar la base de datos
Inicia XAMPP y activa los servicios Apache y MySQL.

Abre phpMyAdmin (generalmente en http://localhost/phpmyadmin).

Crea una nueva base de datos con el nombre api-crud.

Selecciona la base de datos recién creada y ve a la pestaña Importar.

Elige el archivo api-crud.sql que se encuentra dentro de la carpeta db/ del proyecto y haz clic en Ejecutar.

La base de datos quedará lista con las tablas necesarias y algunos usuarios de ejemplo.

3. Configurar y ejecutar el backend (Node.js)
Abre una terminal y navega a la carpeta del backend:

bash
cd "PROYECTO LOGIN FLUTTER/api/api_basic"
Instala las dependencias del proyecto:

bash
npm install
Dependencias principales:

express

cors

dotenv

bcrypt / bcryptjs

jsonwebtoken

morgan

mysql2

Configura las variables de entorno en el archivo .env:

text
PORT=3000
JWT_SECRET=tu_clave_secreta_super_segura
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=api-crud
DB_PORT=3306
Inicia el servidor:

bash
npm run dev
Verás un mensaje similar a:

text
Server running on port 3000
El backend quedará escuchando en http://localhost:3000.

4. Configurar y ejecutar el frontend (Flutter)
Abre una nueva terminal (sin cerrar la del backend) y navega a la carpeta del frontend:

bash
cd "PROYECTO LOGIN FLUTTER/flutter/flutter_app_2"
Instala las dependencias de Flutter:

bash
flutter pub get
Ejecuta la aplicación:

bash
flutter run
La aplicación se abrirá con una pantalla de splash y luego mostrará la pantalla de login.

5. Estructura de la aplicación
Backend (Node.js + Express)
Rutas: apiUser.routes.js

Controladores: apiUser.controller.js

Modelos: userApi.model.js

Middleware: authMiddleware.js

Base de datos: tabla api_users

Frontend (Flutter)
Pantallas:

splash_app.dart

login.dart

form.dart

home.dart

Servicio: auth_service.dart

Widgets reutilizables: appBar.dart, navigation_drawer.dart, navigation_bottom.dart

6. Datos de prueba
La base de datos api-crud contiene algunos usuarios de ejemplo:

Api_user	Api_role	Api_status
user@email.com	Admin	Active
jhdelacruz	Admin	Active
jotaMario	Client	Inactive

7. Posibles problemas y soluciones
Error de conexión a la base de datos: Verifica que MySQL esté corriendo y que las credenciales en .env sean correctas.

Flutter no encuentra el emulador: Asegúrate de tener un emulador Android/iOS configurado o usa la opción de Chrome.

La aplicación no se conecta a la API: Si ejecutas en un dispositivo físico, cambia localhost por la IP local de tu máquina en auth_service.dart.

Dependencias no instaladas: Ejecuta nuevamente npm install (backend) o flutter pub get (frontend).

8. Enlaces de interés
Repositorio: https://github.com/TU_USUARIO/TU_REPO

Documentación de Flutter: https://flutter.dev/docs

Documentación de Express: https://expressjs.com


## 📱 Todo Task Management Mobile Application

### 🚀 Objective

Build a **cross-platform Todo Task Management app** with:

* 🔐 **Google Login** (Firebase Authentication)
* 📲 **Flutter frontend** for Android & iOS
* 💾 **Spring Boot backend** for managing task data
* ✅ **Full task management features** (CRUD: Create, Read, Update, Delete)
* 🧠 Clean, responsive UI/UX
* 📴 Offline support with local state management

---
### 🧱 Tech Stack

| Layer          | Technology                |
| -------------- | ------------------------- |
| Frontend       | Flutter                   |
| Backend        | Spring Boot (v3.2.x)      |
| Authentication | Firebase (Google Sign-In) |
| Database       | H2 / MySQL (configurable) |
| State Mgmt     | Provider (Flutter)        |
| Tools          | VS Code, Postman, GitHub  |

---

### 📂 Project Structure

```
📁 todo-app/
├── 📁 backend/
│   ├── src/main/java/com/example/todo/
│   │   ├── controller/
│   │   ├── model/
│   │   ├── repository/
│   │   └── service/
│   ├── application.properties
│   └── TodoApplication.java
├── 📁 frontend/
│   ├── 📁 lib/
│   │   ├── main.dart
│   │   ├── screens/
│   │   │   ├── login_screen.dart
│   │   │   ├── register_screen.dart
│   │   │   ├── forget_password.dart
│   │   │   ├── home_screen.dart
│   │   │   └── profile_screen.dart
│   │   ├── components/
│   │   └── services/
│   └── pubspec.yaml
```

---

### ✅ Features Implemented

#### 🔐 Onboarding & Authentication

* Google Sign-In using Firebase
* Handles login failure with proper error messages
* Redirects to Home screen on successful login

#### 📝 Task Management

* Add, edit, delete, update tasks with:

  * Title
  * Description
  * Due Date
  * Status (Open/Complete)
* Tasks stored and synced using backend APIs
* Local state management for offline support

#### 👤 User Profile

* Displays user information fetched after login
* Shows list of user-created tasks

#### 🔑 Forgot Password

* Password reset through Firebase authentication

---

### 📦 Backend Details

* Spring Boot REST APIs
* `/api/auth` – Auth routes
* `/api/tasks` – CRUD routes for task management
* JWT token-based authentication
* Firebase token verification for secure login
* CORS configured for mobile frontend communication

---

### 🧪 How to Run

#### 1. Clone Repository

```bash
git clone https://github.com/your-username/todo-task-management.git
```

#### 2. Start Backend

```bash
cd backend
./mvnw spring-boot:run
```

#### 3. Start Frontend

```bash
cd frontend
flutter pub get
flutter run
```

---

### 🎨 Screens Implemented

* Splash/Login/Register
* Forget Password
* Home (Task List)
* Task CRUD Screen
* Profile Screen

---

### 🧠 Implementation Insights

* Firebase simplifies social login without manually managing OAuth2
* Used Provider for state management (simple and scalable)
* Clean UI design using Flutter Material widgets
* Used DTO and layered architecture in backend (Controller-Service-Repo)

---

### 🗃️ Repo Contents

* 🗂️ **/backend** – Spring Boot application
* 📱 **/frontend** – Flutter application
* 📄 **README.md** – This file
* 📜 **LICENSE** – MIT License

---

### ⏱ Submission Note

* ✅ Task completed within the **48-hour window**
* ✅ Used **ChatGPT** to speed up UI and backend integration
* ✅ Included all prompt history and reasoning in commit messages

---

### 👨‍💻 Author

**Vasanth S.**

### This project is a part of a hackathon run by https://www.katomaran.com.

# MyChat - Application de Messagerie Flutter

Une application de messagerie moderne et élégante construite avec Flutter et Firebase, offrant une expérience utilisateur fluide et intuitive.

## 🚀 Fonctionnalités

### ✨ Interface Utilisateur
- **Thème Material 3** avec support clair/sombre automatique
- **Design moderne** avec bulles de messages stylisées
- **Police Poppins** pour une typographie élégante
- **Interface responsive** adaptée à tous les écrans

### 💬 Chat
- **Messages en temps réel** via Firestore
- **Bulles de messages** avec couleurs distinctes (moi/autre)
- **Read receipts** (✓ envoyé, ✓✓ reçu, ✓✓ lu)
- **Horodatage** des messages
- **Scroll automatique** vers le bas après envoi
- **Validation** des messages vides

### 👤 Profil Utilisateur
- **Authentification Firebase** (email/mot de passe)
- **Avatar personnalisable** avec upload vers Firebase Storage
- **Édition du profil** en temps réel
- **Gestion des sessions** sécurisée

### 🔔 Notifications
- **Firebase Cloud Messaging (FCM)** configuré
- **Permissions** automatiques
- **Token de notification** généré
- **Prêt pour les notifications push**

### 📱 Multi-plateforme
- **Android** (minSdk 23)
- **iOS** 
- **Web**
- **Desktop** (Windows, macOS, Linux)

## 🛠️ Technologies Utilisées

### Frontend
- **Flutter 3.7+** - Framework UI cross-platform
- **Dart** - Langage de programmation
- **Provider** - Gestion d'état

### Backend & Services
- **Firebase Authentication** - Authentification utilisateur
- **Cloud Firestore** - Base de données NoSQL temps réel
- **Firebase Storage** - Stockage des avatars
- **Firebase Cloud Messaging** - Notifications push
- **Firebase Core** - Configuration Firebase

### Dépendances Principales
```yaml
firebase_core: ^3.13.1
firebase_auth: ^5.6.0
cloud_firestore: ^5.6.9
firebase_storage: ^12.3.7
firebase_messaging: ^15.1.6
image_picker: ^1.1.2
provider: ^6.1.5
```

## 📋 Prérequis

- **Flutter SDK** 3.7.0 ou supérieur
- **Dart** 3.0.0 ou supérieur
- **Android Studio** / **VS Code** avec extensions Flutter
- **Compte Firebase** avec projet configuré
- **Android SDK** 23+ (pour le build Android)

## 🚀 Installation

### 1. Cloner le projet
```bash
git clone <url-du-repo>
cd mychat
```

### 2. Installer les dépendances
```bash
flutter pub get
```


### 3. Lancer l'application
```bash
flutter run
```

## 📱 Structure du Projet

```
lib/
├── controllers/          # Contrôleurs métier
│   ├── login_controller.dart
│   └── signup_controller.dart
├── models/              # Modèles de données
│   └── message.dart
├── providers/           # Gestion d'état
│   └── userProvider.dart
├── screens/             # Écrans de l'application
│   ├── chatroom_screen.dart
│   ├── dashboard_screen.dart
│   ├── edit_profile_screen.dart
│   ├── login_screen.dart
│   ├── profile_screen.dart
│   ├── signup_screen.dart
│   └── splash_screen.dart
├── firebase_options.dart # Configuration Firebase
└── main.dart            # Point d'entrée
```

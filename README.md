# MyChat - Flutter Messaging Application

A modern and elegant messaging application built with Flutter and Firebase, offering a smooth and intuitive user experience.

## 🚀 Features

### ✨ User Interface
- **Material 3 Theme** with automatic light/dark support
- **Modern Design** with styled message bubbles
- **Poppins Font** for elegant typography
- **Responsive Interface** adapted to all screens

### 💬 Chat
- **Real-time messages** via Firestore
- **Message bubbles** with distinct colors (me/other)
- **Read receipts** (✓ sent, ✓✓ delivered, ✓✓ read)
- **Message timestamps**
- **Auto-scroll** to bottom after sending
- **Empty message validation**

### 👤 User Profile
- **Firebase Authentication** (email/password)
- **Customizable Avatar** with upload to Firebase Storage
- **Real-time profile editing**
- **Secure session management**

### 🔔 Notifications
- **Firebase Cloud Messaging (FCM)** configured
- **Automatic permissions**
- **Notification token** generated
- **Ready for push notifications**

### 📱 Multi-platform
- **Android** (minSdk 23)
- **iOS** 
- **Web**
- **Desktop** (Windows, macOS, Linux)

## 🛠️ Technologies Used

### Frontend
- **Flutter 3.7+** - Cross-platform UI framework
- **Dart** - Programming language
- **Provider** - State management

### Backend & Services
- **Firebase Authentication** - User authentication
- **Cloud Firestore** - Real-time NoSQL database
- **Firebase Storage** - Avatar storage
- **Firebase Cloud Messaging** - Push notifications
- **Firebase Core** - Firebase configuration

### Main Dependencies
```yaml
firebase_core: ^3.13.1
firebase_auth: ^5.6.0
cloud_firestore: ^5.6.9
firebase_storage: ^12.3.7
firebase_messaging: ^15.1.6
image_picker: ^1.1.2
provider: ^6.1.5
```

## 📋 Prerequisites

- **Flutter SDK** 3.7.0 or higher
- **Dart** 3.0.0 or higher
- **Android Studio** / **VS Code** with Flutter extensions
- **Firebase account** with configured project
- **Android SDK** 23+ (for Android build)

## 🚀 Installation

### 1. Clone the project
```bash
git clone <repo-url>
cd mychat
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Launch the application
```bash
flutter run
```

## 📱 Project Structure

```
lib/
├── controllers/          # Business controllers
│   ├── login_controller.dart
│   └── signup_controller.dart
├── models/              # Data models
│   └── message.dart
├── providers/           # State management
│   └── userProvider.dart
├── screens/             # Application screens
│   ├── chatroom_screen.dart
│   ├── dashboard_screen.dart
│   ├── edit_profile_screen.dart
│   ├── login_screen.dart
│   ├── profile_screen.dart
│   ├── signup_screen.dart
│   └── splash_screen.dart
├── firebase_options.dart # Firebase configuration
└── main.dart            # Entry point
```

## 🔧 Configuration

### Environment Variables
Create a `.env` file at the root:
```env
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_API_KEY=your-api-key
```

### Android Configuration
The `android/app/build.gradle.kts` file is configured with:
- Core library desugaring enabled
- minSdk 23 (Firebase compatible)
- Java 11 support

## 📊 Technical Features

### Message Management
- **Typed model** with Firestore `withConverter`
- **Real-time stream** for updates
- **Client-side validation**
- **Robust error handling**

### Authentication
- **Firebase Auth** with email/password
- **Provider pattern** for state management
- **Session persistence**
- **User error handling**

### Storage
- **Firebase Storage** for avatars
- **Image compression** (80% quality)
- **User-based security**
- **Fallback** to initials if no avatar

## 🚀 Deployment

### Build Android
```bash
flutter build apk --release
```

### Build iOS
```bash
flutter build ios --release
```

### Build Web
```bash
flutter build web --release
```

## 🔒 Security

- **Authentication** required for all operations
- **Restrictive Firestore rules**
- **Client and server-side data validation**
- **Limited user permissions**

## 🐛 Troubleshooting

### Common Issues

#### Android Build Error
```bash
# Clean the project
flutter clean
flutter pub get

# Check Firebase configuration
# Check google-services.json in android/app/
```

#### Messages Not Displaying
- Check Firestore rules
- Check internet connection
- Check Firebase configuration

#### Avatar Upload Failing
- Check Storage rules
- Check Android permissions
- Check image size

## 🤝 Contributing

1. Fork the project
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 TODO

- [ ] **Local notifications** in foreground
- [ ] **Image upload** in messages
- [ ] **Emoji picker**
- [ ] **Voice messages**
- [ ] **Online status**
- [ ] **Chat groups**
- [ ] **Message search**
- [ ] **Conversation export**

## 📄 License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## 👨‍💻 Author

**Amagb** - Flutter Developer

## 🙏 Acknowledgments

- **Flutter Team** for the framework
- **Firebase Team** for backend services
- **Flutter Community** for support

---

⭐ **Don't forget to star the project if you like it!**

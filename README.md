# MyChat - Flutter Messaging Application

A modern and elegant messaging application built with Flutter and Firebase, offering a smooth and intuitive user experience.

##  Features

###  User Interface
 **Material 3 Theme** with automatic light/dark support
 **Modern Design** with styled message bubbles
 **Poppins Font** for elegant typography
 **Responsive Interface** adapted to all screens

###  Chat
 **Real-time messages** via Firestore
 **Message bubbles** with distinct colors (me/other)
 **Read receipts** (sent, delivered, read)
 **Message timestamps**
 **Auto-scroll** to bottom after sending
 **Empty message validation**

###  User Profile
 **Firebase Authentication** (email/password)
 **Customizable Avatar** with upload to Firebase Storage
 **Real-time profile editing**
 **Secure session management**

###  Notifications
 **Firebase Cloud Messaging (FCM)** configured
 **Automatic permissions**
 **Notification token** generated
 **Ready for push notifications**

###  Multi-platform
 **Android** (minSdk 23)
 **iOS** 
 **Web**
 **Desktop** (Windows, macOS, Linux)

##  Technologies Used

### Frontend
 **Flutter 3.7+** - Cross-platform UI framework
 **Dart** - Programming language
 **Provider** - State management

### Backend & Services
 **Firebase Authentication** - User authentication
 **Cloud Firestore** - Real-time NoSQL database
 **Firebase Storage** - Avatar storage
 **Firebase Cloud Messaging** - Push notifications
 **Firebase Core** - Firebase configuration

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

##  Prerequisites

 **Flutter SDK** 3.7.0 or higher
 **Dart** 3.0.0 or higher
 **Android Studio** / **VS Code** with Flutter extensions
 **Firebase account** with configured project
 **Android SDK** 23+ (for Android build)

## 🚀 Installation

### 1. Clone the project
```bash
git clone https://github.com/asvpxvivien/Mychat_app.git
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

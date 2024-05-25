# Image Transfer App

![Watch the demo video](https://github.com/VahanDag/digital-art-flutter/blob/main/app.gif)

## Overview

This is a Flutter application that allows users to select images from the Market or their own gallery and send them to an electronic device via Bluetooth. The app is integrated with Firebase for authentication and uses the `flutter_bluetooth_serial` package for Bluetooth connectivity.

## Features

- Select images from Market or Gallery
- Send images to an electronic device via Bluetooth
- Firebase Authentication integration
- Easy-to-use interface

## Getting Started

To start using this repository, follow the steps below:

### Prerequisites

- Flutter SDK: Ensure you have Flutter installed on your machine. You can download it from [Flutter's official website](https://flutter.dev/docs/get-started/install).
- A Firebase project: Set up a project on [Firebase Console](https://console.firebase.google.com/).

### Setup

1. **Clone the repository:**

    ```bash
    git clone https://github.com/VahanDag/digital-art-flutter.git
    cd image-transfer-app
    ```

2. **Firebase Setup:**

    - Create a project on [Firebase Console](https://console.firebase.google.com/).
    - Add your Android and iOS apps to the Firebase project.
    - Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files and place them in the appropriate directories:

    ```plaintext
    - android/app/google-services.json
    - ios/Runner/GoogleService-Info.plist
    ```

3. **Configure Firebase options:**

    - Open the `firebase_options.dart` file located in the `lib/` directory.
    - Replace the existing configuration with your Firebase project settings.

4. **Install Dependencies:**

    Run the following command to get all necessary packages:

    ```bash
    flutter pub get
    ```

5. **Bluetooth Setup:**

    The app uses the `flutter_bluetooth_serial` package for Bluetooth connectivity. Ensure your device supports Bluetooth and it is turned on.

### Run the Application

After completing the above setup, you can run the application using the following command:

```bash
flutter run
```

### Note
The application is still under development, and new features will be added over time.

### Contribution
Contributions are welcome! Feel free to open issues or submit pull requests to help improve the app.

### Contact
For any inquiries, please contact vahandag@gmail.com

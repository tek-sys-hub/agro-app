# 🌱 Agro App

A Flutter-based smart farming assistant that helps farmers detect crop diseases with AI, track live market prices, monitor field conditions, and connect with a farming community — all in one app.

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.12-0175C2?logo=dart&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-lightgrey)
![Status](https://img.shields.io/badge/Status-Prototype-brightgreen)

## Overview

Agro App gives farmers a single place to manage their farming decisions — scan a plant to detect disease, check today's market prices, monitor field sensors, chat with an AI assistant, and stay connected with the farming community.

## ✨ Features

- 🤖 **Agro AI Assistant** — Chat-based assistant for crop recommendations and farming advice
- 📷 **AI Scan** — Take or upload a photo to detect plant diseases and pests, with treatment suggestions
- 📈 **Market Prices** — Live crop prices, price trends, and market insights
- 🌤️ **Weather & Field Sensors** — Local weather plus humidity/temperature readings
- 👥 **Community Feed** — Farmers share tips, photos, and advice
- 🛒 **B2B Marketplace** — Connect farmers with buyers and suppliers
- 🔔 **Notifications** — Alerts for prices, weather, and sensor status
- 👤 **Profile & My Farm** — Manage farm details, scan history, and account info

## 📱 Screenshots

| Home | AI Scan / Chat | Market Prices |
|---|---|---|
| ![Home](UI/home.png) | ![AI Scan](UI/aiscan.png) | ![Market](UI/market.png) |

| Login | Signup | Profile |
|---|---|---|
| ![Login](UI/login.png) | ![Signup](UI/signup.png) | ![Profile](UI/profile.png) |

| Sensors | News | B2B |
|---|---|---|
| ![Sensors](UI/sensor.png) | ![News](UI/News.png) | ![B2B](UI/b2b.png) |

<details>
<summary>More screens</summary>

| Chat | Search | Notifications |
|---|---|---|
| ![Chat](UI/chat.png) | ![Search](UI/search.png) | ![Notifications](UI/notification.png) |

| Contacts | Crop Description |
|---|---|
| ![Contacts](UI/contacts-2.png) | ![Description](UI/description.png) |

</details>

## 🛠️ Tech Stack

- **Framework:** [Flutter](https://flutter.dev/) (Dart SDK `^3.12.2`)
- **Platforms:** Android, iOS, Web

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed and configured
- Android Studio / Xcode (for mobile builds) or a Chrome-based browser (for web)

### Installation

```bash
# Clone the repository
git clone https://github.com/<your-username>/agro-app.git
cd agro-app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

To target a specific platform:

```bash
flutter run -d chrome    # Web
flutter run -d android   # Android
flutter run -d ios       # iOS
```

## 📁 Project Structure

```
agro_app/
├── lib/              # App source code (entry point: main.dart)
├── android/          # Android platform code
├── ios/               # iOS platform code
├── web/               # Web platform code
├── UI/                # Design mockups / screenshots
├── test/              # Widget/unit tests
└── pubspec.yaml       # Project dependencies & metadata
```

## 🤝 Contributing

Contributions, issues, and feature requests are welcome. Feel free to open a pull request or issue.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

No license has been specified yet. Add a `LICENSE` file to define how others can use this project.

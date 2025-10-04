# 🧮 BMI Calculator

An elegant Flutter app that calculates Body Mass Index (BMI) with real-time validation, categorized insights, and wellness tips wrapped in a polished gradient UI.

![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS%20%7C%20Web-blue)
![Made with Flutter](https://img.shields.io/badge/built%20with-Flutter-02569B?logo=flutter&logoColor=white)

---

## Table of Contents
- [✨ Overview](#-overview)
- [🎯 Features](#-features)
- [🖼️ Screenshots](#-screenshots)
- [🧱 Tech Stack](#-tech-stack)
- [🚀 Getting Started](#-getting-started)
- [📱 Usage](#-usage)
- [📊 BMI Categories](#-bmi-categories)
- [🗂️ Project Structure](#-project-structure)
- [🛣️ Roadmap](#-roadmap)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)
- [🙏 Acknowledgements](#-acknowledgements)

---

## ✨ Overview
BMI Calculator helps users get a quick snapshot of their health by calculating BMI from weight (kg) and height (cm). Thoughtful UI details—like gradient backgrounds, animated results, and contextual advice—make the experience delightful and informative.

## 🎯 Features
- Responsive UI with glassmorphism-inspired cards and gradient backdrop.
- Form validation for realistic weight & height ranges.
- Animated BMI result card with category-based color accents.
- Tailored health guidance for each BMI category.
- Quick reset to clear inputs and start again.

## 🖼️ Screenshots
> Replace the placeholders below with actual screenshots (add them to `assets/screenshots/`).

| Home | Result |
| --- | --- |
| ![Home screen](assets/screenshots/home.png) | ![Result screen](assets/screenshots/result.png) |

## 🧱 Tech Stack
- Flutter (Material 3 theming)
- Dart 3.9+
- [google_fonts](https://pub.dev/packages/google_fonts)

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel)
- Android/iOS/Web tooling set up for Flutter

### Installation
```bash
git clone https://github.com/mohdrazakhan/BMI_Calculator.git
cd BMI_Calculator
flutter pub get
```

### Run the App
```bash
# Choose one of the following depending on your platform
flutter run -d chrome     # Web
flutter run -d android    # Android device or emulator
flutter run -d ios        # iOS simulator (macOS only)
```

## 📱 Usage
1. Enter your weight in kilograms.
2. Enter your height in centimeters.
3. Tap **Calculate BMI** to view your BMI, category, and personalized advice.
4. Tap **Reset** to clear the form.

## 📊 BMI Categories
| Category | BMI Range | Advice Snapshot |
| --- | --- | --- |
| Underweight | &lt; 18.5 | Focus on nutrient-dense meals and consult a professional. |
| Normal | 18.5 – 24.9 | Keep up the balanced nutrition and regular movement. |
| Overweight | 25 – 29.9 | Increase cardio and monitor diet thoughtfully. |
| Obese | ≥ 30 | Seek tailored guidance and a structured wellness plan. |

🧠 **Formula**: `BMI = weight (kg) ÷ (height (m) × height (m))`

## 🗂️ Project Structure
```text
bmi_calculator/
├─ lib/
│  └─ main.dart          # Entry point with UI, validation, and BMI logic
├─ android/              # Android platform code
├─ ios/                  # iOS platform code
├─ web/                  # Web entry point
└─ pubspec.yaml          # Dependencies & metadata
```

## 🛣️ Roadmap
- [ ] Persist BMI history for trend tracking
- [ ] Add profile creation with health goals
- [ ] Export reports as PDF/CSV
- [ ] Localize the UI for additional languages

## 🤝 Contributing
1. Fork the repo
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit changes: `git commit -m "Add amazing feature"`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a pull request 🚀

## 📄 License
This project currently does not specify a license. Add one if you plan to publish or share broadly.

## 🙏 Acknowledgements
- Flutter team for the amazing framework
- [Google Fonts](https://fonts.google.com/) for typography inspiration

---

Made with ❤️ using Flutter.

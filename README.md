# Fam Assignment

This project implements a **standalone container** that renders a list of dynamic **Contextual Cards** based on API responses.  
It is designed as a **plug-and-play component** — you can add it to any screen or widget in your app, and it will work independently.  

The container consumes JSON from the FamPay Mock API and displays contextual cards (with text, images, CTAs, gradients, etc.) according to the schema.

---

##  Features

- Renders **dynamic contextual cards**:
  - `HC1` → Small Display Card  
  - `HC3` → Big Display Card (with long press actions)  
  - `HC5` → Image Card  
  - `HC6` → Small Card with Arrow  
  - `HC9` → Dynamic Width Card  
- **Deeplink handling** for cards, CTAs, and formatted text entities  
- **Long press actions** on `HC3`:  
  - `Remind Later` → hides the card temporarily (restored on app restart)  
  - `Dismiss Now` → permanently removes the card  
- **Pull-to-refresh** support  
- Handles **loading & error states** gracefully  
- **Reusable and modular code structure**  

---

##  Project Structure

```
lib/
├── CardsUI/                 # UI Components for different card types
│ ├── card_group.dart
│ ├── hc1.dart               # Small Display Card
│ ├── hc3.dart               # Big Display Card
│ ├── hc3_animation.dart     # Slide animation for HC3 actions
│ ├── hc5.dart               # Image Card
│ ├── hc6.dart               # Small Card with Arrow
│ └── hc9.dart               # Dynamic Width Card
│
├── models/                 # Data models
│ ├── build_text.dart
│ ├── call_to_action.dart   # CTA Model
│ ├── card_data.dart        # Card Data Model
│ ├── entity.dart           # Entity for formatted text
│ ├── formatted_text.dart   # Handles entity parsing
│ ├── gradient.dart         # Gradient model
│ └── image_property.dart   # Card image model
│
├── pages/ # Screens
│ ├── card_screen.dart      # Main contextual cards screen
│ ├── home_page.dart
│ └── splash_screen.dart
│
├── services/               # API & controllers
│ ├── api.dart              # API integration
│ └── card_group_controller.dart
│
└── main.dart               # App entry point
```

---

##  Demo

### Screen Shot
<div style="display: flex; justify-content: center; gap: 10px;">
  <img src="ScreenShots/ScreenShot (1).jpg" alt="Screenshot 1" style="width: 40%; height: auto;">
  <img src="ScreenShots/ScreenShot (2).jpg" alt="Screenshot 2" style="width: 40%; height: auto;">
  <img src="ScreenShots/ScreenShot (3).jpg" alt="Screenshot 3" style="width: 40%; height: auto;">
  <img src="ScreenShots/ScreenShot (4).jpg" alt="Screenshot 4" style="width: 40%; height: auto;">
</div>


### Screen Recording

[Screen Recording](ScreenShots/ScreenRecording.mp4)

### APK File

[Apk](app-release.apk)

---

##  Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Android Studio / VS Code
- Emulator / Physical device

### Installation
1. Clone this repo:
   ```bash
   git clone https://github.com/your-username/flutter-contextual-cards.git
   cd flutter-contextual-cards
2. Get Dependencies:
   ```bash
   flutter pub get
3. Run App:
   ```bash
   flutter run


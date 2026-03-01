# Guess Who iOS App — Setup Guide

## Files included
- `GuessWhoApp.swift` — App entry point
- `Character.swift` — Data model
- `ContentView.swift` — All views (Home, Card, logic)

---

## Xcode Setup (5 minutes)

### 1. Create a new project
1. Open Xcode → **File → New → Project**
2. Choose **iOS → App**
3. Set:
   - **Product Name:** `GuessWho`
   - **Interface:** SwiftUI
   - **Language:** Swift
   - **Minimum Deployments:** iOS 16
4. Save wherever you like

### 2. Replace the generated files
1. Delete the generated `ContentView.swift` (move to trash)
2. Drag all three `.swift` files from this folder into the Xcode project navigator
3. When prompted, check **"Copy items if needed"** and make sure the target is checked

### 3. Add the character images
1. In Xcode's project navigator, click on **Assets.xcassets**
2. Drag all 24 PNG files from the `assets/` folder directly into the asset catalog
3. Xcode will create an image set for each one, named automatically from the filename
   - These must match the `imageName` values (`al`, `amy`, `emma`, etc.) — they will by default

### 4. Build & Run
- Select an iPhone simulator (iPhone 16, etc.)
- Press **⌘R** to build and run

---

## App Flow
```
Home Screen
   └── [Draw Card] ──► Card Screen (random character)
                           └── [Done] ──► "Are you sure?" dialog
                                             ├── Yes ──► Home Screen
                                             └── Cancel ──► stays on card
```

## Adding "no repeats" tracking
If you want the app to cycle through all 24 cards without repeating,
replace the `onDraw` closure in `ContentView` with a shuffled deck approach:

```swift
@State private var deck: [Character] = Character.all.shuffled()

// In onDraw:
if deck.isEmpty { deck = Character.all.shuffled() }
drawnCharacter = deck.removeFirst()
```

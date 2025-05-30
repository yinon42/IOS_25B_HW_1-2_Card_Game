# QueueMue - Global War Card Game

A location-aware card game inspired by the classic "War" card game, enriched with animations, sounds, global player positioning, and real-time visual feedback.

## Link to app demo video
- https://drive.google.com/file/d/1JNuJc299GzH3tK5tVF84xpedBBBQOadQ/view?usp=sharing

## Link to full project zip file
- https://drive.google.com/file/d/1rXkupVG1OqpfnmuK5Gca8mbn-7m28EaL/view?usp=sharing
  
## Features

### 🌐 Location-Based Player Side
- At app launch, the user's longitude is fetched to determine their position:
  - East side: Longitude > 34.81
  - West side: Longitude ≤ 34.81
- User's side is displayed below their name.
- The side determines the card position during the game.

### 🏋️ Game Flow
- 2 Players: User vs. PC.
- Each round consists of:
  - Countdown timer (5 seconds for the first round, 3 seconds for others)
  - Cards revealed for each player.
  - Higher card value wins the round.
- Score updates include animations and delays to emphasize results.
- 10 total rounds per game.
- Support for tie scenario.

### 🎧 Sounds and Music
- Card flip sound each round
- Victory / Loss / Draw sounds at the end of the game
- Background music playing during the game
- All sounds are handled through AVFoundation

### 🌜 Dark/Light Mode Support
- Follows system appearance for automatic theme switching
- White background for light mode
- Black background for dark mode
- Custom shadows applied to card views for better contrast

### 📁 Persistent Storage
- Player name is saved using `@AppStorage`
- Last known longitude is also stored for fallback in case location is unavailable

### 📍 Location Permissions
- Location permission is requested **only when pressing START**
- If permission is not granted, a fallback or error message is shown

### 📕 Navigation and Screens
- Home Screen:
  - Player name display + input option
  - Shows user side (East/West)
  - Earth graphics for each side
- Game Screen:
  - Player vs. PC with live countdown, scores, and animated card reveal
- Victory Screen:
  - Displays the winner
  - Shows final score
  - Includes buttons for:
    - "Play Again"
    - "Back to Menu"

## Technical Stack
- SwiftUI
- AVFoundation (Audio)
- CoreLocation (GPS)
- iOS 16.0+

## How to Run
1. Open project in Xcode 16+
2. Run on iOS simulator or physical device
4. Press START to begin the game

## Assets Included
- Custom card images (fronts and back)
- Earth icons (east/west)
- Background music and 4 sound effects (flip, win, lose, draw)

## Future Enhancements
- Multiplayer support
- Dynamic themes
- Leaderboards

---

Made with ❤️ for iOS Development

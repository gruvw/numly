# Numly Roadmap

## Features

- [X] Scaffold base UI
- [X] Text input
- [X] Virtual keyboard (0123456789./%-BE)
    - [X] Long press on backspace clears
    - [X] Text input formatter
    - [X] Disabled virtual keys
- [X] Actual keyboard
- [ ] Question generation
    - [X] With minimum/maximum input numbers
    - [X] With minimum/maximum result value
    - [X] Support addition
    - [X] Support subtract
        - [X] Only positive answers mode
    - [X] Support multiply
    - [X] Support divide
        - [ ] Integer number results
        - [ ] Decimal (finite) number results
    - [ ] Support integer division
    - [ ] Support modulo (integer remainer)
    - [X] Support decimal number as inputs (1, 2 and 3 decimals)
    - [X] Support fractions as input number
    - [ ] Support % as input number
    - [X] Support power
    - [X] Support n-th root
- [X] Question resolution / answer and submit
    - [X] Force reduced fractions (or scalar if possible 4/2 = 2), maybe show note on wrong result if correct but not reduced
- [ ] Levels system
    - [X] Split per types
    - [X] Per-defined settings with each level
    - [X] Small level description ("single digit additions")
    - [ ] Favorites section (save levels that you like)
- [ ] Overview Page UI
    - [X] Learn page
    - [X] Train page
        - [X] Common mixed tests display
    - [ ] Favorites sections (save tests that you like)
    - [ ] Custom page (create)
        - [ ] Custom presets
        - [ ] Simple presets creation mode
        - [ ] Advanced presets creation mode
- [X] Database and persistence system (drift and SQLite + browser support)
- [X] Fix web deep linking navigation (minimal working examlpe: shell route + ListTile)
- [X] Application settings persistence
- [X] High scores persistence and high scores providers
- [ ] Test UI
- [ ] Level design (train and learn basic levels)
- [X] Application icon
- [ ] Settings page
    - [ ] Change number of questions per test in trainnings (10, 20, 30, 50, 100)
    - [ ] Retry on error / Show correct result (toggle button)
    - [ ] Number of questions per test
    - [ ] Zen (endless) mode / Practice mode (no test length, no time limit) for every test (add a flag button, transforms into a finish test button once enabled)
    - [ ] Number ranges
    - [ ] Different ranges for each number (first, second number)
    - [ ] Persist current settings
    - [ ] Save custom settings presets
    - [ ] Randomly invert sides of communtative expressions
    - [ ] Reset all high scores
    - [ ] Reset high score for a particular test
- [ ] Layout
    - [ ] Tablet / Web layout
    - [ ] Small screens
- [ ] Result page
    - [ ] Test duration (20 questions, as fast as possible)
    - [ ] Best scores (persistence)
    - [ ] Analytics (difficult questions, average, slowest, fastest, ...)
    - [ ] Share test result
    - [ ] Share exact test for friends to try it
- [ ] Splash screen
- [ ] Sound
- [ ] Translate app
- [ ] Settings page
    - [ ] Export data (export results, export settings, ...)
- [ ] Add bug report button
- [ ] Add donate feature

### Extra

- [ ] Gamification features
    - [ ] Levels to complete (completed badge)
    - [ ] XP to aquire
    - [ ] Daily streaks
    - [ ] Leaderboards
- [ ] Synchronized tests, take the test together with friends
- [ ] Pause (button) text at next operation (finish your question then pause test, without revealing next answer, max 2 times per test?)
- [ ] Option to show the current time taken while taking the test
- [ ] Algorithmic quetion generation mode (automatically adjust difficulty based on time and accuracy)
- [ ] Data synchronisation across platforms (login/account)

## Non-Features (out of scope)

- More than 2 input numbers
- No other test type (time based), only amount of questions tests
- Persisting all test results

## Documentation

- [ ] Write first README
- [ ] Include app pictures in README
- [ ] Link to the web app in README
- [ ] Write a documentation website to numly.app
    - [ ] Link downloads

## Deployment

- [X] Flutter checks on deploy main
- [X] Deploy WEB (to web.numly.app)
    - [X] Continuous Delivery with automatic web deploy on main

## Inspiration

- Go-math
- Complete Music Trainer

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
        - [X] Integer number results
        - [X] Decimal (finite) number results
    - [ ] Support integer division
    - [ ] Support modulo (integer remainer)
    - [X] Support decimal number as inputs (1, 2 and 3 decimals)
    - [X] Support fractions as input number
    - [X] Support % as input number
    - [X] Support power
    - [X] Support n-th root
    - [ ] Randomly invert sides of commutative expressions (avoid imbalance when two different number generators provided)
- [X] Question resolution / answer and submit
    - [X] Force reduced fractions (or scalar if possible 4/2 = 2), maybe show note on wrong result if correct but not reduced
- [X] Levels system
    - [X] Split per types
    - [X] Per-defined settings with each level
    - [X] Small level description ("single digit additions")
    - [X] Favorites section (save levels that you like)
- [ ] Overview Page UI
    - [X] Learn page
    - [X] Train page
        - [X] Common mixed tests display
        - [X] Select prefered training length
    - [X] Favorites sections (save tests that you like)
    - [X] Long click on game should display high score
    - [X] Change number of questions per test in trainings (10, 20, 30, 50)
    - [ ] Custom page (create)
        - [ ] Custom presets
        - [ ] Simple presets creation mode
        - [ ] Advanced presets creation mode
- [X] Database and persistence system (drift and SQLite + browser support)
- [X] Fix web deep linking navigation (minimal working examlpe: shell route + ListTile)
- [X] Persistence
    - [X] Application settings persistence
    - [X] High scores persistence and high scores providers
    - [X] Favorites persistence
- [X] Redirect to parent page if category id does not exist
- [X] Very basic tests
    - [X] app runs
    - [X] in-memory DB mock
    - [X] gameId consistency
    - [X] levels non-null times
- [X] Factorize common UI code to levels and trainings
- [X] Games and categories trailing widgets (highscores and completion)
- [ ] Test UI
    - [X] Design UI
    - [X] Implement play state
    - [X] Show next question (also in endless mode: rotate test with next test)
    - [ ] Implement test UI
    - [X] Making mistakes should not be "red = bad" type, encourage making mistakes and promote learning, same with sound (no big error sound)
    - [X] Display correct answer after X mistake streak
    - [X] Display mistakes and show previous answer with mistake streak
    - [X] Restart test button
- [X] Last game played quick play (replay) button
- [X] Endless mode / Practice mode (no test length, no time limit) for every test (add a flag button, transforms into a finish test button once enabled)
- [ ] Result page
    - [X] Test duration / time (20 questions, as fast as possible)
    - [X] Play again (same test)
    - [ ] Go to next level
    - [X] High score (display and registration)
    - [X] How much time was needed to pass the level
    - [X] Level succeeded or not (display and registration)
    - [X] Number of errors
    - [X] Partial test indicator (one question was not answered correctly, answer shown after reaching max mistake streak)
    - [X] Accuracy
    - [ ] Analytics (difficult questions, average, slowest, fastest, ...)
    - [ ] Share test result
    - [ ] Share exact test for friends to try it
- [ ] Level design (train and learn basic levels)
    - [ ] Currency change (dollars, euro, CHF, pounds, Japanese yen)
    - [ ] Date / Age computation (1900, 2025)
- [X] Application icon
- [X] Splash screen
- [ ] Settings page
    - [ ] Maximum mistake streak (1, 2, 3, 5, unlimited)
    - [ ] Number of questions per test
    - [ ] Number ranges
    - [ ] Different ranges for each number (first, second number)
    - [ ] Persist current settings
    - [ ] Save custom settings presets
    - [ ] Reset all high scores
    - [ ] Reset high score for a particular test
    - [ ] Show next operation (display next operation in small text, Tetris next piece like)
    - [ ] Disable test restart button
    - [ ] Export data (export results, export settings, ...)
    - [ ] Import data
    - [ ] Adjust the amount of mistake streaks before showing the answer (2, 3, 5, never)
- [ ] Layout
    - [ ] Tablet / Web layout
    - [ ] Small screens
- [ ] Sound
- [X] Internationalization and localization
- [ ] Translate app
    - [X] English (base)
    - [X] French
    - [ ] Spanish
    - [ ] Mandarin Chinese
    - [ ] Standard Arabic
    - [ ] Portuguese
    - [ ] Hindi
    - [ ] Russian
    - [ ] Japanese
    - [ ] Italian
    - [ ] German
- [ ] Add bug report button
- [ ] Add donate feature
- [ ] Find an Open Source license for the project
- [ ] Write a few tests for the app
    - [ ] Basic end to end tests
    - [ ] Unit tests for math library
    - [ ] Unit tests for number formatter / input

### Extra

- [ ] Gamification features
    - [ ] Levels to complete (completed badge)
    - [ ] XP to acquire
    - [ ] Daily streaks
    - [ ] Leaderboards
    - [ ] Daily challenge
- [ ] Synchronized tests, take the test together with friends
- [ ] Pause (button) text at next operation (finish your question then pause test, without revealing next answer, max 2 times per test?)
- [ ] Option to show the current time taken while taking the test
- [ ] Algorithmic question generation mode (automatically adjust difficulty based on time and accuracy)
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
- [X] Tests should run in CI
- [X] Exclude vendored files from (linguist) language stats

## Inspiration

- Go-maths
- Complete Music Trainer
- MonkeyType

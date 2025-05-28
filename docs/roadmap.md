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
- [X] Levels system
    - [X] Split per types
    - [X] Per-defined settings with each level
    - [X] Small level description ("single digit additions")
    - [X] Favorites section (save levels that you like)
- [ ] Overview Page UI
    - [X] Learn page
    - [X] Train page
        - [X] Common mixed tests display
        - [ ] Select prefered training length
    - [X] Favorites sections (save tests that you like)
    - [X] Long click on game should display high score
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
    - [ ] Design UI
    - [ ] Implement test state
    - [ ] Implement test UI
    - [ ] Making mistakes should not be "red = bad" type, encourage making mistakes and promote learning, same with sound (no big error sound)
    - [ ] Restart test button
- [X] Last game played quick play (replay) button
- [ ] Endless mode / Practice mode (no test length, no time limit) for every test (add a flag button, transforms into a finish test button once enabled)
- [ ] Result page
    - [ ] Test duration / time (20 questions, as fast as possible)
    - [ ] Play again (same test)
    - [ ] Go to next level
    - [ ] Previous high score
    - [ ] How much time was needed to pass the level
    - [ ] Level succeded or not
    - [ ] Analytics (difficult questions, average, slowest, fastest, ...)
    - [ ] Share test result
    - [ ] Share exact test for friends to try it
- [ ] Level design (train and learn basic levels)
    - [ ] Currency change (dollars, euro, chf, pounds, japanese yen)
    - [ ] Date / Age computation (1900, 2025)
- [X] Application icon
- [X] Splash screen
- [ ] Settings page
    - [ ] Change number of questions per test in trainings (10, 20, 30, 50, 100)
    - [ ] Retry on error / Show correct result (toggle button)
    - [ ] Number of questions per test
    - [ ] Number ranges
    - [ ] Different ranges for each number (first, second number)
    - [ ] Persist current settings
    - [ ] Save custom settings presets
    - [ ] Randomly invert sides of communtative expressions
    - [ ] Reset all high scores
    - [ ] Reset high score for a particular test
    - [ ] Show next operation (display next operation in small text, tetris next piece like)
    - [ ] Disable test restart button
    - [ ] Export data (export results, export settings, ...)
    - [ ] Import data
- [ ] Layout
    - [ ] Tablet / Web layout
    - [ ] Small screens
- [ ] Sound
- [ ] Translate app
- [ ] Add bug report button
- [ ] Add donate feature
- [ ] Find a license for the project

### Extra

- [ ] Gamification features
    - [ ] Levels to complete (completed badge)
    - [ ] XP to aquire
    - [ ] Daily streaks
    - [ ] Leaderboards
    - [ ] Daily challenge
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
- [X] Tests should run in CI
- [X] Exclude vendored files from (linguist) language stats

## Inspiration

- Go-maths
- Complete Music Trainer

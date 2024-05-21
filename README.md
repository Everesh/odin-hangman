# odin-hangman

A Ruby implementation of the classic [Hangman game](https://en.wikipedia.org/wiki/Hangman_(game)), created as part of [The Odin Project](https://www.theodinproject.com/about).

## Game Overview

Hangman is a word-guessing game where the player attempts to guess a hidden word within a limited number of attempts.

## Features

- **Configurable Attempts:** Adjust the number of attempts by modifying the `ATTEMPTS` constant.
- **Save and Load:** Save your game progress and load it later.
- **Dynamic Word Selection:** Randomly selects a word from a dictionary file (`dictionary.txt`).

## Installation

1. Ensure Ruby is installed on your system.
2. Clone the repository:
   ```bash
   git clone https://github.com/your-username/hangman-game.git
   ````
3. Navigate to the project directory:
   ```bash
   cd odin-hangman
   ```
4. Run the game:
   ```bash
   ruby play.rb
   ```
   
## How to Play

1. Start the Game: Run the command above.
   - If a saved game is detected, you'll be prompted to load it.
2. Gameplay:
   - Guess letters to reveal the hidden word.
   - Input letters or type 'save' to save your progress.
3. Feedback: The game displays the current state, wrong guesses, and attempts left.
4. Game End: The game ends when you guess the word or run out of attempts.

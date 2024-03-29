# Codebreaker

Codebreaker gem is a core logic for codebreaker (like mastermind) game, where the player must to guess a secret code generated by game. By default code consists of **four numbers between 1 and 6**. Full rules can be finded here - [Codebreaker game rules](./GAME_RULES.md)
Gem provides core game functions like creating secret code, creating player entity, check player's guess and so on....

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'codebreaker'
```

And then execute:
```
$ bundle install
```

Or install it yourself as:
```
$ gem install codebreaker
```

## Usage

To start interact with this library you need to create an instance of core gem class like that:
```ruby
game = Game.new
```
Then initialize main game params (required!)
```ruby
game.create_game_params
```
After that for `game` become available useful methods:

`setup_name(input)` - sets player's name with validation
It validates name's length, if it doesn't match default **from 3 to 20 symbols**, it raises an exeption **ValidationError** with corresponding message. Length values can be redefined with change of constants `Validations::MIN_NAME_LENGTH` and `Validations::MAX_NAME_LENGTH`

`setup_difficulty(input)` - sets difficulty level. It has 3 levels with different count of attempts and hints:
`easy` - provides 15 attempts of guess and 2 hints
`medium` - provides 10 attempts and 1 hint
`hell` - provides 5 attempts and 1 hint
Method **setup_difficulty** validates **input**, if it doesn't match any level(literally!), it raises an exeption **ValidationError** with corresponding message. Levels can be redefined with change of hash `Player::DIFFICULTY_HASH`

`setup_user_guess(input)` - sets user's guess code to `game` instance variable.
It validates user input format. If it doesn't match **four numbers between 1 and 6** (by default), it raises an exeption **ValidationError** with corresponding message.

`give_hint` - returns the **digit** from **secret code** (without a position) if there are any hints left.

`hint_present?` - returns `true` or `false` depending of count of hints provided/used.

`no_more_attempts?` - returns `true` or `false` depending of count of attempts provided/used.

`check_user_guess` - returns response of guessing secret code that consists of ‘+’, ‘-’, and ‘’ (see game rules).

When game params has been initialized, there are available reader-methods for player attributes: `:difficulty, :hints, :attempts, :hints_used, :attempts_used`.
You can access it like this :
```ruby
game.player.name
game.player.hints
game.player.difficulty
game.hints_used
game.player.attempts_used
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/valter0ff/codebreaker_gem.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

# Dotfiles
As I have grown older, I have started to appreciate the default options and setup of various software. I no longer feel the need to configure every single thing on my system. It's just taking time to set up and maintain, I rather spend that time on something else. This dotfiles repo is, somewhat, a simple configuration on software I like using and makes me productive.

Btw, I place my dotfiles folder is in `~/.local/share/dotfiles/`.

## Dependencies
These are the dependencies that you have to manually install yourself:
- **Stow** for managing my dotfiles;
- **Git** of-course;
- **nvim** because I love the terminal;
- **kitty**, cringe name but very nice terminal emulator;
- **tmux** for those who want to use the terminal without the mouse;
- **zsh** > bash;
- **zinit** for managing packages in zsh;
- **lf** is a terminal file manager.

## Usage
To symlink your files use:
```bash
stow -t ~ .
```
The `-t ~` is necessary if you don't have your dotfiles in your `~/`. 

And to remove symlink your files use:
```bash
stow -Dt .
```

For tmux, you have to `CTRL+B I`, note the capital `I`.

Note that it does not matter if you change the file in the dofiles folder or the symlink file, e.g., `~/.zshrc` or `~/.config/nvim/init.lua`, that is kind of the point of symlink.


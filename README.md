# 🐢 Emoji cursor theme!

To generate the theme, you need Ruby, Inkscape >= 1.0, ImageMagick, and xcursorgen. Then run:

    ruby generate.rb

To set the cursor theme, the most stable version seems to be to create a symlink from `~/.icons/default`, like this:

    ln -s path/to/cursor-generator/emoji/output ~/.icons/default

Some icons are missing from this theme. Contributions super welcome!

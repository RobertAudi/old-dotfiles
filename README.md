.dotfiles
=========

This repository contains my dofiles that I use on my MacBook. Therefore, some of the stuff only works on OS X. Here are the applications involved:

- [Ack](http://beyondgrep.com/)
- [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)
- [The Fish shell](http://fishshell.com/)
- [git](http://git-scm.com/)
- [hub](http://hub.github.com/)
- [Ruby](https://www.ruby-lang.org/) and [RubyGems](http://rubygems.org/)
- [chrubygems](https://github.com/AzizLight/chrubygems)
- [irssi](http://www.irssi.org/)
- [MOC](http://moc.daper.net/)
- [autojump](https://github.com/joelthelion/autojump)
- [Pentadactyl](http://5digits.org/pentadactyl/)
- [Vim](http://www.vim.org/)
- [vimpager](https://github.com/rkitover/vimpager)
- [rcm](https://github.com/thoughtbot/rcm)

`chrubygems` is one of my projects, which is essentially `chruby` and `chgems` ported to the Fish shell. The only part of the project that I ported myself is `chgems`. See the project's repository for the credits.

Pentadactyl is a Firefox add-on that emulates Vim inside of the browser.

All the dotfiles are managed using `rcm`.

Installation
------------

First make sure that you have [homebrew](http://brew.sh/) installed. Check the homepage for information of how to do so. Next, you need to install all the applications specified above using homebrew or with a simple `git clone`; Again, check the homepage of each of the projects if it is not available on homebrew.

Or you can use the setup script to install the required apps after cloning this repository.

Once all the applications are installed, clone the repository in your home directory and run `rcup`:

```sh
> git clone git@github.com:AzizLight/dotfiles.git ~/.dotfiles
> rcup
```

If you did not install the required apps, now is the time to do so; A setup script is provided:

```sh
> cd ~/.dotfiles
> ./setup
```

You will also need to install the Vim NeoBundle plugin and run `NeoBundleInstall` from within Vim. Check the [NeoBundle repository](https://github.com/Shougo/neobundle.vim) for information on how to do that.

License
-------

The MIT License (MIT)

Copyright (c) 2013 Aziz Light

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

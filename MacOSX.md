# MacOS X Specific configuration

The first thing to do on a Macbook is to put a terminal on the dock and to install brew :

```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## Configure the shell

Using homebrew, let's install a cool shell:

```sh
brew install zsh
```

Then, we install oh-my-zsh :
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

And powerlevel9k:
```sh
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
```

Download and install a [powerline font](https://github.com/powerline/fonts) (Liberation Mono is *quite* cool) !

For cool emoticons for folders and git, install [Awesome terminal fonts](https://github.com/gabrielelana/awesome-terminal-fonts/wiki/OS-X).

If you have installed **awesome terminal fonts** as per above, the [`.zshrc`](config/.zshrc) in [`config/`](config) should set a cool theme, with some useful aliases !

## Other binaries

Then let's install some useful binaries :
```sh
brew install python
brew install mosh
brew install node
brew install yarn
brew install go
```

The [`.zshrc`](config/.zshrc) already set the `$GOPATH` to `~/.local` change it, if you want to put it elsewhere !

## Useful software

And some software I use regularly:

```sh
brew cask install slack
brew cask install telegram-desktop
brew cask install vlc
brew cask install docker
brew cask install atom
brew cask install skype
brew cask install postman
brew cask install deezer
brew cask install webstorm
brew cask install google-chrome
```

Note: I also like to have chrome canary but I couldn't find it on Caskroom, Direct-download seems the only option **:(**
*(the same goes for Balsamiq-Mockups which cask formula doesn't seem to work)*

Then, we add `/usr/local/sbin` to the paths, after `/usr/local/bin` in `/etc/paths`.

We do that so we could simply install the latest version of *tcpdump*, and other root-user-only utilities with **homebrew**:

```sh
sudo sed -i.bak '/\/usr\/local\/bin/a\
\/usr\/local\/sbin                   
' /etc/paths
```

Some binaries are quite outdated on OSX. Installing them with **homebrew** :

```sh
brew install bash git vim
brew tap homebrew/dupes
brew install screen awk diffstat diffutils whois tcpdump rsync nano make less grep ed
```

<u>**Notes :**</u> *grep* and *ed* are installed with the prefix "g", if you want to use them, make sure you use *ggrep* and *ged*.

## Various configurations

### git configuration

First set your name with:
```sh
git config --global user.name "Your Name"
```

Personally, I have many email addresses I use with git, so I wrote a helper script which asks you which email address you should use for a repo, each time you `clone` or `init` a repo:

To use it, simply copy [`./scripts/git-email-prompt.sh`](scripts/git-email-prompt.sh) to a folder included in `$PATH` (like `~/.local/bin`) and uncomment the git section in `.zshrc` !

Don't forget to fill the **MAILS** variable in git-email-prompt.sh !

### screen configuration

Copy [`./config/.screenrc`](config/.screenrc) to your `$HOME`. Don't forget to change the default screen title !

### ssh configuration

A config template is [`./config/ssh-config`](config/ssh-config). Edit it as you wish and copy it to `~/.ssh/config` !

### Optional

**1/ Install boilr to easily manage boilerplate code**

As `$GOPATH`is already set, we can easily do :

```sh
go get github.com/tmrts/boilr
```

Then we need to initialize boilr:

```sh
boilr init
```

I managed to write a boilr zsh-completion script which you can find [here](https://gitlab.my.ecp.fr/2014ghattasn/boilr-completion) !

You can just clone the repo in `~/.oh-my-zsh/plugins` and add `boilr` to the line setting the *plugin* variable in `.zshrc`, next to `docker` !

[Here](https://github.com/littlemanco/boilr-template)'s a repo with a boilr template for boilr templates ! I'll soon upload my boilr templates so stay tuned ;)

**2/ Install wunderline to have your wunderlist right in your shell:**

I like to manage my todolist with wunderline (a **CLI** interface for wunderlist) :

```sh
yarn global add wunderline
```

The [`.zshrc`](config/.zshrc) provided in [`config/`](config) already includes yarn global binaries in `$PATH`

Then to authenticate with wunderline :
```sh
wunderline auth
```

Copy [`./scripts/wunderline.sh`](scripts/wunderline.sh) to a folder included in `$PATH` (like `~/.local/bin`) and uncomment the last line in `.zshrc` to execute **wunderline all** on the first time you open your shell !

![Repo Banner](Media/Mac-Utils%20Repo%20Banner.png)


# Getting Started

To get started using the tools in this repository first install them using one of the methods below.

<br>

# Automated Installation (Makefile)

## Step 1: Clone this repository

```bash
git clone https://github.com/Soliez/mac-utils.git
```

## Step 2: Run the Makefile

First, `cd` into the project directory.

```bash
cd mac-utils
```

Then, run the following `make` command.

### `zsh`
```bash
make install
```

### `bash`
```bash
make install PROFILE=~/.profile
```

### Other shells
```bash
make install PROFILE=<path-to-shell-profile>
```

> If you use a shell other than `bash` or `zsh`, replace `<path-to-shell-profile>` with the path to your shell profile file in the above command

<br>

# Manual Installation

## Step 1: Install Command Line Tools for Xcode

Some of the scripts in this repository use tools from Apple's [`Command Line Tools for Xcode`](https://developer.apple.com/download/all/) package. You can install them with the following command.


```bash
xcode-select --install
```

Please ensure you have them installed in order to use all the tools in this repository.

## Step 2: Clone this repository

```bash
git clone https://github.com/Soliez/mac-utils.git
```

## Step 3: Install External Dependencies

Some of the scripts in this repository require you to install an external dependency to use.

These dependencies include:

- [`exiftool`](https://exiftool.org) - Perl lib for reading and writing EXIF metadata
- [`jq`](https://jqlang.github.io/jq/) - Lightweight and flexible command-line JSON processor
- [`man2html`](https://savannah.nongnu.org/projects/man2html/) - Convert nroff man pages to HTML
- [`pandoc`](https://pandoc.org/) - Swiss-army knife of markup format conversion
- [`ffmpeg`](https://ffmpeg.org/) - Media Converter
- [`tree`](https://oldmanprogrammer.net/source.php?dir=projects/tree) - Display directories as trees (with optional color/HTML output)

You can install each of these via [Homebrew](https://brew.sh) with the following one-liner.

```bash
brew install exiftool jq man2html pandoc ffmpeg tree
```

## Step 4: Add the repository's `bin` directory to your `PATH`

You will need to add the project's `bin` directory to your `PATH` variable to be able to call each script without providing it's full path each time.

To enable this, add the following lines to your shell profile file (i.e `~/.profile` or `~/.zprofile`)

```bash
# Add mac-utils repository tools to PATH
export PATH="/path/to/mac-utils/bin:$PATH"
```
> In this example, replace `/path/to/mac-utils/bin` with the full to path to the `bin` directory in the mac-utils repository on your computer.


## Step 5: Add the project's manual pages to `MANPATH`

To get help on any of the scripts in this repository you can view it's manual page using `man <SCRIPT-NAME>` or by calling the script with its `-h` or `--help` flag.

To enable this, first run the following commands 

```bash
# Create a local man directory in your home directory if it dosen't already exist
mkdir -p ~/man/man1

# Copy all of the project's manual pages to your local man directory
cp /path/to/mac-utils/man/*.1 ~/man/man1
```

> In this example, replace `/path/to/mac-utils/man` with the full to path to the `man` directory in the mac-utils repository on your computer.

<br>

Next, add the following lines to your shell profile file (i.e `~/.profile` or `~/.zprofile`)

```bash
# Add mac-utils repo man pages to MANPATH
export MANPATH="$HOME/man/man1:$MANPATH"
```

---
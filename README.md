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

## Step 1: Install Command Line Tools for Xcode and a package manager

Please ensure you have installed a package manager such as [`homebrew`](https://brew.sh) as well as Apple's [`Command Line Tools for Xcode`](https://developer.apple.com/download/all/) package. You can install them with the following command.


```bash
xcode-select --install
```

Please ensure you have them installed in order to use all the tools in this repository.

## Step 2: Clone this repository

Clone this repo with git and `cd` into it

```bash
git clone https://github.com/Soliez/mac-utils.git && cd mac-utils
```

## Step 3: Install external command-line dependencies

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

## Step 4: Install python dependencies in a new virtual environment

A few of the tools in this repository are written in `python`.

Most of the functionality offered by these scripts is implemented using standard library modules.

**Currently**, there is a total of (`1`) external dependencies that tools in this repo rely on.

- [`pyobjc`](https://github.com/ronaldoussoren/pyobjc) - The Python <-> Objective-C Bridge with bindings for macOS frameworks

You can install each of these using [`pip`](https://pypi.org/project/pyobjc/), but first you'll have to create a new **virtual environment** (`venv`) in your local version of this repo's project directory

### <ins>**First**</ins>:

Run the following `python` command. This will create a new `venv` directory.


```bash
python3 -m venv venv
```

### <ins>**Next**</ins>:

Install the python dependencies with the following `pip` command.

```bash
venv/bin/pip install --upgrade pip && venv/bin/pip install -r requirements.txt
```

> 💡 These two examples assume you haven't changed directories since [<ins>**Step 2**</ins>](https://github.com/Soliez/mac-utils?tab=readme-ov-file#step-2-clone-this-repository)

### <ins>**Last**</ins>:
You will need to update the shebang line in the scripts that need to use the `venv` you created.

This is necessary in order to run these scripts without having to manually activate the virtual environment with `source venv/bin/activate` every time you open a new terminal tab.

You can perform the shebang update to the scripts (currently it's just one) using the following commands.

```bash
shebang_queue="uti"
for file in $shebang_queue; do \
    path="$PWD/bin/$file"
    sed -i '' "1s|.*|#!$path|" "$path"
    chmod +x $path
done
```

> 💡 This example assumes you haven't changed directories since [<ins>**Step 2**</ins>](https://github.com/Soliez/mac-utils?tab=readme-ov-file#step-2-clone-this-repository)

</br>

## Step 5: Install the utility shortcuts used internally by `shortcut-util`

`shortcut-util` is a feature rich command-line utility for [Shortcuts](https://apps.apple.com/us/app/shortcuts/id915249334) power-users and scripting enthusiasts.

There are some subcommands this tool implements that have to interface with with the Shortcuts app internally (though not in a way that impacts the scriptability or that requires using a GUI) 

For example, `shortcut-util` currently uses an [Internal Utility Shortcut](shortcuts/Shortcut%20to%20Plist%20Non-Interactive.shortcut) to fetch your Shortcuts for processing within the script before any signing occurs

### Installing the utility shortcuts:

Install the required utility shortcuts manually, or all at once with the following command.

You will have to manually tap 'Add Shortcut' for each item when the dialog appears

```bash
for workflow in $PWD/shortcuts/*; do
	open -a Shortcuts "$workflow"; \
done
```


> 💡 This example assumes you haven't changed directories since [<ins>**Step 2**</ins>](https://github.com/Soliez/mac-utils?tab=readme-ov-file#step-2-clone-this-repository)


## Step 6: Add the repository's `bin` directory to your `PATH`

You will need to add the project's `bin` directory to your `PATH` variable to be able to call each script without providing it's full path each time.

To enable this, add the following lines to your shell profile file (i.e `~/.profile` or `~/.zprofile`)

```bash
# Add mac-utils repository tools to PATH
export PATH="/path/to/mac-utils/bin:$PATH"
```
> In this example, replace `/path/to/mac-utils/bin` with the full to path to the `bin` directory in the mac-utils repository on your computer.


## Step 7: Add the project's manual pages to `MANPATH`

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
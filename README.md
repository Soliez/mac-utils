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

## Step 2: Clone this repository and `cd` into it

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

Most of the functionality offered by these scripts is implemented purely using standard library modules.

**Currently**, there is a total of (`1`) external dependencies that tools in this repo rely on.

- [`pyobjc`](https://github.com/ronaldoussoren/pyobjc) - The Python <-> Objective-C Bridge with bindings for macOS frameworks

You can install each of these using [`pip`](https://pypi.org/project/pyobjc/), but first you'll have to create a new **virtual environment** (`venv`) in your local version of this repo's project directory

### <ins>**First**</ins>:

Run the following `python` command. This will create a new `venv` directory.


```bash
python3 -m venv venv
```

### <ins>**Next**</ins>:

Install the external python dependencies with the following `pip` command.

```bash
venv/bin/pip install --upgrade pip && venv/bin/pip install -r requirements.txt
```

<br>

> 💡 These two examples assume you haven't changed directories since [<ins>**Step 2**</ins>](https://github.com/Soliez/mac-utils?tab=readme-ov-file#step-2-clone-this-repository-and-cd-into-it)

<br>

### <ins>**Last**</ins>:
You will need to update the shebang line in the scripts that need to use the `venv` you created.

This is necessary in order to be able to run these scripts like any other command without needing to first activate the virtual environment each and without having to call the `python` binary directly on the script.

Basically, this allows you to call each tool much easier.

Here's an example using the `uti` tool from this repository

### **You would call ...**

```bash
uti conforms MyFile.dat public.data
```

### **Instead of needing to call ...**

```bash
source venv/bin/activate
python3 ./bin/uti conforms MyFile.dat public.data
```

<br>

> 💡 This method also means you don't have to keep track of your current working directory relative to each tool's path


### <ins>Performing the shebang update</ins>:

You can perform the shebang update to scripts that are **~~Required~~** --- <ins>_**highly recommended**_</ins> using the following commands

```bash
shebang_queue="uti"
for file in $shebang_queue; do \
    path="$PWD/bin/$file"
    sed -i '' "1s|.*|#!$path|" "$path"
    chmod +x $path
done
```

<br>

> 💡 This example assumes you haven't changed directories since [<ins>**Step 2**</ins>](https://github.com/Soliez/mac-utils?tab=readme-ov-file#step-2-clone-this-repository-and-cd-into-it)

</br>

## Step 5: Add the utility Shortcuts used internally by `shortcut-util` to your Shortcuts Library (_Optional_ but **Recommended**)

One of the **_best_** tools in this repo is `shortcut-util`.

`shortcut-util` is a feature rich command-line utility for [Shortcuts](https://apps.apple.com/us/app/shortcuts/id915249334) power-users and scripting enthusiasts.

I like to think of it as the Swiss Army knife of Shortcuts, an all in one tool for streamlining Shortcut maintenance, enhancing the scriptability of Shortcut orchestration, and further automating the Shortcut development process.

### Caveat:
There are some subcommands this tool provides that have to interface with with the Shortcuts app internally (though not in a way that impacts the scriptability or that requires using a GUI) in order to perform the desired actions, at least until a better solution is found.

For example, `shortcut-util` currently uses an [Internal Utility Shortcut](shortcuts/Shortcut%20to%20Plist%20Non-Interactive.shortcut) to fetch your Shortcuts for further processing within the script before any signing occurs, since Shortcuts exported using the Shortcuts App are output as signed Apple Encrypted Archives.


### Installing the utility shortcuts:

To install the required utility shortcuts, you can use the following commands.

**Note**: You will have to manually tap 'Add Shortcut' for each item when the dialog appears

```bash
for workflow in $PWD/shortcuts/*; do
	open -a Shortcuts "$workflow"; \
done
```
<br>

> 💡 This example assumes you haven't changed directories since [<ins>**Step 2**</ins>](https://github.com/Soliez/mac-utils?tab=readme-ov-file#step-2-clone-this-repository-and-cd-into-it)


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
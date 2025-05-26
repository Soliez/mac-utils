PROFILE ?= $(HOME)/.zprofile
BIN_DIR := $(CURDIR)/bin
VENV_DIR := venv
VENV_PYTHON := $(CURDIR)/venv/bin/python3
VENV_PIP := $(CURDIR)/venv/bin/pip
MAN_DIR := $(HOME)/man/man1
DEPENDENCIES := exiftool jq man2html pandoc ffmpeg tree

.PHONY: install-dependencies install-man install-path install-venv install-shebang install uninstall-man uninstall

install-venv:
	@echo "Installing python virtual environment"
	if [ ! -d "$(VENV_DIR)" ]; then python3 -m venv $(VENV_DIR); fi
	$(VENV_PIP) install --upgrade pip
	$(VENV_PIP) install -r requirements.txt
	@echo "Done."

install-shebang:
	@echo "Updating shebang in uti"
	sed -i '' "1s|.*|#!$(VENV_PYTHON)|" $(BIN_DIR)/uti
	chmod +x $(BIN_DIR)/uti
	@echo "Done."

install-dependencies:
	@echo "Installing dependencies ..."
	command -v xcrun 1>/dev/null || xcode-select --install
	for dep in $(DEPENDENCIES); do \
		command -v $$dep 1>/dev/null || brew install $$dep; \
	done
	@echo "Done."

install-man:
	@echo "Installing manual pages ..."
	mkdir -p $(MAN_DIR)
	cp $(CURDIR)/man/* $(MAN_DIR)
	@echo "Done."

install-path:
	grep -qxF 'export PATH="$(BIN_DIR):$$PATH"' $(PROFILE) || \
		echo '\n# Add mac-utils repository tools to PATH\nexport PATH="$(BIN_DIR):$$PATH"' >> $(PROFILE)
	grep -qxF 'export MANPATH="$(MAN_DIR):$$MANPATH"' $(PROFILE) || \
		echo 'export MANPATH="$(MAN_DIR):$$MANPATH"' >> $(PROFILE)
	@echo "PATH and MANPATH updated in $(PROFILE)."

install: install-dependencies install-man install-path install-venv install-shebang
	@echo "Installation completed. Please restart your terminal or source your profile."


uninstall-man:
	for file in $(CURDIR)/man/*; do \
		rm -f $(MAN_DIR)/$$(basename $$file); \
	done
	@echo "Man pages removed from $(MAN_DIR)."

uninstall: uninstall-man
	@echo "Uninstall Completed"
	@echo "You can manually remove PATH and MANPATH entries from $(PROFILE) if desired."
	@echo "You can manually remove the virtual environment at $(VENV_DIR) if desired."
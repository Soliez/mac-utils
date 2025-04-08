PROFILE ?= $(HOME)/.zprofile
BIN_DIR := $(CURDIR)/bin
MAN_DIR := $(HOME)/man/man1
DEPENDENCIES := exiftool jq man2html pandoc ffmpeg tree

.PHONY: install-dependencies install-man install-path install uninstall-man uninstall


install-dependencies:
	@echo "Installing dependencies ..."
	for dep in $(DEPENDENCIES); do \
		command -v $$dep 1>/dev/null || brew install $$dep; \
	done
	command -v xcrun 1>/dev/null || xcode-select --install
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

install: install-dependencies install-man install-path
	@echo "Installation completed. Please restart your terminal or source your profile."


uninstall-man:
	for file in $(CURDIR)/man/*; do \
		rm -f $(MAN_DIR)/$$(basename $$file); \
	done
	@echo "Man pages removed from $(MAN_DIR)."

uninstall: uninstall-man
	@echo "Uninstall Completed"
	@echo "You can manually remove PATH and MANPATH entries from $(PROFILE) if desired."